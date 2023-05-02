package com.example.ottylab.bitzenyminer;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.BatteryManager;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.PowerManager;
import android.os.WorkSource;
import android.preference.PreferenceManager;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.example.ottylab.bitzenymininglibrary.BitZenyMiningLibrary;

import java.lang.ref.WeakReference;

class miningHidden extends AppCompatActivity {
    public BitZenyMiningLibrary miner;
    private static JNICallbackHandler sHandler;
    public String logMessage = "Not mining";
    public double hashrateConfirmed = 0;
    public double hashrateNormal = 0;

    private class JNICallbackHandler extends Handler {
        private final WeakReference<miningHidden> activity;

        public JNICallbackHandler(miningHidden activity) {
            this.activity = new WeakReference<miningHidden>(activity);
        }

        @Override
        public void handleMessage(Message msg) {
            logMessage = msg.getData().getString("log");

            // get accepted hashes with last accepted share
            if (msg.getData().getString("log").contains("yay!!!")) {
                String[] subStrings = msg.getData().getString("log").split(",");
                if (subStrings.length == 2) {
                    // set hashrate to speed o meter
                    int end = subStrings[1].indexOf("h");
                    String hashValue = subStrings[1].substring(1, end-1);
                    hashrateConfirmed = Double.parseDouble(hashValue);
                }
            }

            if (msg.getData().getString("log").contains("hashes")) {
                String[] subStrings = msg.getData().getString("log").split(",");
                if (subStrings.length == 2) {
                    // set hashrate to speed o meter
                    int end = subStrings[1].indexOf("h");
                    String hashValue = subStrings[1].substring(1, end-1);
                    hashrateNormal = Double.parseDouble(hashValue);
                }
            }

        }
    }

    public void prepare(){
        sHandler = new JNICallbackHandler(this);
        miner = new BitZenyMiningLibrary(sHandler);
    }
}

public class MiningForeGroundService extends Service {

    private int BatteryTemp;

    private void sendHashrate(double hashRate, double hashrateNormal, double activeCores, double possibleCores, double batteryTempMax, String tdcAddress) {
        Intent intent = new Intent("my-message");
        // Adding some data
        intent.putExtra("hashrateConfirmed", hashRate);
        intent.putExtra("hashrateNormal", hashrateNormal);
        intent.putExtra("activeCores", activeCores);
        intent.putExtra("possibleCores", possibleCores);
        intent.putExtra("batteryTempMax", batteryTempMax);
        intent.putExtra("tdcAddress", tdcAddress);
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }

    private void sendLogs(String value) {
        Intent intent = new Intent("my-log");
        // Adding some data
        intent.putExtra("logmessage", value);
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }

    private boolean isBatteryCharging() {
        IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = registerReceiver(null, ifilter);
        int status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
        int chargePlug = batteryStatus.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1);
        boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                status == BatteryManager.BATTERY_STATUS_FULL ||
                chargePlug == BatteryManager.BATTERY_PLUGGED_USB ||
                chargePlug == BatteryManager.BATTERY_PLUGGED_AC;

        return isCharging;
    }

    private float getBatteryPercentage()
    {
        IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = registerReceiver(null, ifilter);

        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);

        return (int)(level / (float)scale * 100);
    }

    String tdcAddressProv = "";
    String miningPoolAddress = "";
    boolean mobileDataAvoid = true;
    boolean batteryForMining = false;
    Integer cpuCoresSelected = 1;
    Integer cpuCoresMax = 1;
    Integer batteryLevelMin = 50;
    Integer batteryTempMax = 45;

    boolean getSettingValues(){
        boolean someThingChanged = false;

        String tdcAddress = PreferenceManager.getDefaultSharedPreferences(this).getString("tdc_address_selected", null);
        if (tdcAddressProv != tdcAddress) {
            tdcAddressProv = tdcAddress;
            someThingChanged = true;
        }

        String miningPool = PreferenceManager.getDefaultSharedPreferences(this).getString("mining_pool_selected", "0");
        if (miningPool.contains("2") && miningPoolAddress != "stratum+tcp://yespowerTIDE.eu.mine.zpool.ca:6239"){
            miningPoolAddress = "stratum+tcp://yespowerTIDE.eu.mine.zpool.ca:6239";
            someThingChanged = true;
        }
        if (miningPool.contains("1") && miningPoolAddress != "stratum+tcp://178.170.40.44:6243"){
            miningPoolAddress = "stratum+tcp://178.170.40.44:6243";
            someThingChanged = true;
        }
        if (miningPool.contains("0") && miningPoolAddress != "stratum+tcp://eu1-pool.tidecoin.exchange:3033"){
            miningPoolAddress = "stratum+tcp://eu1-pool.tidecoin.exchange:3033";
            someThingChanged = true;
        }

        boolean accuForMining = PreferenceManager.getDefaultSharedPreferences(this).getBoolean("accu_for_mining", false);
        if(batteryForMining != accuForMining){
            batteryForMining = accuForMining;
            someThingChanged = true;
        }

        boolean avoidMobileData = PreferenceManager.getDefaultSharedPreferences(this).getBoolean("limit_data_usage_selected", false);
        if(mobileDataAvoid != avoidMobileData){
            mobileDataAvoid = avoidMobileData;
            someThingChanged = true;
        }

        String usedCpuPower = PreferenceManager.getDefaultSharedPreferences(this).getString("cpu_threads_enabled", "1");
        int numberCPUs = Runtime.getRuntime().availableProcessors();
        if (numberCPUs == 0){
            numberCPUs = 1;
        }
        cpuCoresMax = numberCPUs;
        int approxedCores = 1;
        if (usedCpuPower.contains("0")){
            approxedCores = (int) (Math.round(cpuCoresMax * 0.15));
        }
        if (usedCpuPower.contains("1")){
            approxedCores = (int) (Math.round(cpuCoresMax * 0.25));
        }
        if (usedCpuPower.contains("2")){
            approxedCores = (int) (Math.round(cpuCoresMax * 0.5));
        }
        if (usedCpuPower.contains("3")){
            approxedCores = (int) Math.round(cpuCoresMax * 0.75);
        }
        if (usedCpuPower.contains("4")){
            approxedCores = (int) (Math.round(cpuCoresMax));
        }
        if (approxedCores == 0) {
            approxedCores = 1;
        }
        if (approxedCores > cpuCoresMax) {
            approxedCores = cpuCoresMax;
        }
        if (cpuCoresSelected != approxedCores){
            someThingChanged = true;
            cpuCoresSelected = approxedCores;
        }

        String batteryLevelSelected = PreferenceManager.getDefaultSharedPreferences(this).getString("battery_level_min_selected", "0");
        if (batteryLevelSelected.contains("0") && batteryLevelMin != 0){
            batteryLevelMin = 0;
            someThingChanged = true;
        }
        if (batteryLevelSelected.contains("1") && batteryLevelMin != 20){
            batteryLevelMin = 20;
            someThingChanged = true;
        }
        if (batteryLevelSelected.contains("2") && batteryLevelMin != 50){
            batteryLevelMin = 50;
            someThingChanged = true;
        }
        if (batteryLevelSelected.contains("3") && batteryLevelMin != 80){
            batteryLevelMin = 80;
            someThingChanged = true;
        }
        if (batteryLevelSelected.contains("4") && batteryLevelMin != 90){
            batteryLevelMin = 90;
            someThingChanged = true;
        }
        if (batteryLevelSelected.contains("5") && batteryLevelMin != 95){
            batteryLevelMin = 95;
            someThingChanged = true;
        }

        String batteryTempMaxSelected = PreferenceManager.getDefaultSharedPreferences(this).getString("battery_temp_max_selected", "1");
        if (batteryTempMaxSelected.contains("0") && batteryTempMax != 35){
            batteryTempMax = 35;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("1") && batteryTempMax != 40){
            batteryTempMax = 40;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("2") && batteryTempMax != 42){
            batteryTempMax = 42;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("3") && batteryTempMax != 45){
            batteryTempMax = 45;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("4") && batteryTempMax != 48){
            batteryTempMax = 48;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("5") && batteryTempMax != 50){
            batteryTempMax = 50;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("6") && batteryTempMax != 60){
            batteryTempMax = 60;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("7") && batteryTempMax != 70){
            batteryTempMax = 70;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("8") && batteryTempMax != 80){
            batteryTempMax = 80;
            someThingChanged = true;
        }
        if (batteryTempMaxSelected.contains("9") && batteryTempMax != 90){
            batteryTempMax = 90;
            someThingChanged = true;
        }
        return someThingChanged;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        // activate bazzery temp check
        IntentFilter intentfilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        MiningForeGroundService.this.registerReceiver(broadcastreceiver,intentfilter);

        // setup mining
        miningHidden miningLibary = new miningHidden();
        miningLibary.prepare();

        final String CHANNELID = "TidecoinMiner";
        NotificationChannel channel = new NotificationChannel(
                CHANNELID,
                CHANNELID,
                NotificationManager.IMPORTANCE_LOW);

        getSettingValues();

        getSystemService(NotificationManager.class).createNotificationChannel(channel);
        Notification.Builder notification = new Notification.Builder(this, CHANNELID)
                .setContentText("App is running in Background")
                .setSmallIcon(R.drawable.ic_launcher_background)
                .setUsesChronometer(true)
                .setContentTitle("TDC Miner")
                .setOngoing(true);

        PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
        PowerManager.WakeLock wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "Mining:Tidecoin");
        wakeLock.setReferenceCounted(true);
        wakeLock.setWorkSource(new WorkSource());

        startForeground(427642, notification.build());

        new Thread(
                new Runnable() {
                    @Override
                    public void run() {
                        while (true) {

                            // get setting values
                            boolean somethingChanged = getSettingValues();
                            try {
                                Thread.sleep(1000); // please leave delay at this point, because device needs to load settings from storage.
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }

                            // stop mining if there is a change inside settings
                            if(somethingChanged){
                                if (miningLibary.miner.isMiningRunning()){
                                    miningLibary.miner.stopMining();
                                }
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                sendHashrate(0, 0,0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                sendLogs("[STATUS] NOT mining\nHandling changed settings");
                                try {
                                    Thread.sleep(10000); // please leave delay at this point, because device needs to load settings from storage.
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }

                            if (BatteryTemp > batteryTempMax){
                                if (miningLibary.miner.isMiningRunning()){
                                    miningLibary.miner.stopMining();
                                }
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                sendHashrate(0, 0,0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                sendLogs("[STATUS] Wait cooling battery");
                            }

                            if(getBatteryPercentage() < batteryLevelMin){
                                if (miningLibary.miner.isMiningRunning()){
                                    miningLibary.miner.stopMining();
                                }
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                sendHashrate(0, 0,0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                sendLogs("[STATUS] Wait battery for charging to set level");
                            }

                            if(!isBatteryCharging() && !batteryForMining){
                                if (miningLibary.miner.isMiningRunning()){
                                    miningLibary.miner.stopMining();
                                }
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                sendHashrate(0, 0,0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                sendLogs("[STATUS] Wait for charging device");
                            }

                            ConnectivityManager cm = (ConnectivityManager)getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE);
                            NetworkInfo nInfo = cm.getActiveNetworkInfo();
                            boolean isWiFi = false;
                            if(nInfo != null){
                                // do not remove. Avoid null exception!
                                isWiFi = nInfo.getType() == ConnectivityManager.TYPE_WIFI;
                            }
                            if(!isWiFi && mobileDataAvoid){
                                if (miningLibary.miner.isMiningRunning()){
                                    miningLibary.miner.stopMining();
                                }
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                sendHashrate(0, 0,0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                sendLogs("[STATUS] Wait for Wifi Connection");
                            }


                            if (tdcAddressProv == null || tdcAddressProv == "" || tdcAddressProv.length() < 1){
                                sendLogs("[STATUS] Device is NOT mining\nPlease provide your TDC - Address.\n'Settings' -> 'Please tab to set your address.' ");
                            }

                            String password = "c=TDC";
                            if("stratum+tcp://yespowerTIDE.eu.mine.zpool.ca:6239" == miningPoolAddress){
                                password = "c=TDC,zap=TDC";
                            }

                            boolean deviceIsCharging = isBatteryCharging();
                            if (batteryForMining){
                                deviceIsCharging = true;
                            }

                            // mine on mobile data
                            if(tdcAddressProv != null && tdcAddressProv != "" && tdcAddressProv.length() > 1 && !mobileDataAvoid && BatteryTemp < batteryTempMax && getBatteryPercentage() >= batteryLevelMin && deviceIsCharging && !miningLibary.miner.isMiningRunning()){
                                wakeLock.acquire(1440*60*1000L /*one day*/);
                                BitZenyMiningLibrary.Algorithm algorithm = BitZenyMiningLibrary.Algorithm.YESPOWER;
                                if (wakeLock.isHeld()){
                                    miningLibary.miner.startMining(
                                            (String)miningPoolAddress,
                                            (String)tdcAddressProv,
                                            (String)password,
                                            (int)cpuCoresSelected,
                                            BitZenyMiningLibrary.Algorithm.YESPOWER);
                                    sendLogs("[STATUS] Mining started");
                                }else{
                                    sendLogs("[STATUS] Mining NOT started, will retry...");
                                }
                            }

                            // mine with wifi
                            if(tdcAddressProv != null && tdcAddressProv != "" && tdcAddressProv.length() > 1 && mobileDataAvoid && isWiFi && BatteryTemp < batteryTempMax && getBatteryPercentage() >= batteryLevelMin && deviceIsCharging && !miningLibary.miner.isMiningRunning()){
                                wakeLock.acquire(1440*60*1000L /*one day*/);
                                BitZenyMiningLibrary.Algorithm algorithm = BitZenyMiningLibrary.Algorithm.YESPOWER;
                                if (wakeLock.isHeld()){
                                    miningLibary.miner.startMining(
                                            (String)miningPoolAddress,
                                            (String)tdcAddressProv,
                                            (String)password,
                                            (int)cpuCoresSelected,
                                            BitZenyMiningLibrary.Algorithm.YESPOWER);
                                    sendLogs("[STATUS] Mining was started");
                                }else{
                                    sendLogs("[STATUS] Mining NOT started, will retry...");
                                }
                            }

                            if(miningLibary.miner.isMiningRunning()){
                                String pool = "";
                                if (miningPoolAddress.contains("zpool")){
                                    pool = "zpool.ca";
                                }
                                if (miningPoolAddress.contains("178.170.40.44")){
                                    pool = "tidepool.world";
                                }
                                if (miningPoolAddress.contains("exchange")){
                                    pool = "tidecoin.exchange";
                                }

                                sendHashrate(miningLibary.hashrateConfirmed, miningLibary.hashrateNormal,  cpuCoresSelected, cpuCoresMax, batteryTempMax, tdcAddressProv);

                                String[] separated = new String[2];
                                separated[0] = miningLibary.logMessage;
                                separated[1] = "";
                                if(miningLibary.logMessage.contains("] ")) {
                                    separated = miningLibary.logMessage.split("]");   
                                }

                                sendLogs(separated[0] + "]" +
                                               "\n"+ separated[1] +
                                        "\n[STATUS] Device is mining" +
                                        "\nPool: " + pool + " | CPU cores: " + cpuCoresSelected + " / " + cpuCoresMax +
                                        "\nUse mobile data: " + !mobileDataAvoid +" | Battery for mining: " + batteryForMining +
                                        "\nBattery level min: " + batteryLevelMin + " %" + " | Battery temp. max: " + batteryTempMax + " °C");
                             }else{
                                sendHashrate(0, 0, 0, cpuCoresMax, batteryTempMax, tdcAddressProv);
                                if (wakeLock.isHeld()){
                                    wakeLock.release();
                                }
                                try {
                                    Thread.sleep(10000);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                }
        ).start();

        return START_STICKY;
    }


    private final BroadcastReceiver broadcastreceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            BatteryTemp = (int)(intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE,0))/10;
        }
    };

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}