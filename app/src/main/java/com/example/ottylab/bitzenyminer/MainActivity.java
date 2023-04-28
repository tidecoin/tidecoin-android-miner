package com.example.ottylab.bitzenyminer;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.github.anastr.speedviewlib.TubeSpeedometer;
import com.github.anastr.speedviewlib.components.Section;

import androidx.appcompat.app.AppCompatActivity;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.preference.PreferenceManager;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "BitZenyMiner";
    private static final int LOG_LINES = 1000;
    private Button settingsBtn;
    private TextView textViewLog, tvHashrate, accuTemp;
    private TextView userAddress;
    private float hashrateUnconfirmedMax = 1;
    private float hashrateConfirmedMax = 1;
    private int batteryTemp;

    //graühicla elements
    TubeSpeedometer meterHashrate;
    TubeSpeedometer meterCores;
    TubeSpeedometer meter_cores_gap;
    TubeSpeedometer meter_accepted_hash;


    @Override
    public void onResume() {
        super.onResume();
        // This registers messageReceiver to receive messages.
        LocalBroadcastManager.getInstance(this).registerReceiver(messageReceiverHashrate, new IntentFilter("my-message"));
        LocalBroadcastManager.getInstance(this).registerReceiver(messageReceiverLogs, new IntentFilter("my-log"));
    }

    // Handling the received Intents for the "hashrateConfirmed" event
    private final BroadcastReceiver messageReceiverHashrate = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            double activeCores = intent.getDoubleExtra("activeCores", 0);
            double cpuCoresMax = intent.getDoubleExtra("possibleCores", 1);

            //  1. show hashrate
            double hashrateNormal = intent.getDoubleExtra("hashrateNormal", 1);
            //meterHashrate.makeSections(1, getResources().getColor(R.color.c_blue), Section.Style.SQUARE);
            // will set the highest value as maximum hashrate
            if (hashrateUnconfirmedMax < ((float) (hashrateNormal * cpuCoresMax))) {
                hashrateUnconfirmedMax = ((float) (hashrateNormal * cpuCoresMax));
                meterHashrate.setMaxSpeed(hashrateUnconfirmedMax);
            }
            meterHashrate.speedTo((float) (hashrateNormal * activeCores));

            // 2. show mining cores
            meterCores.setMaxSpeed((float) cpuCoresMax);
            meterCores.speedTo((float) activeCores, 1);

            // 3. meter cores gap
            double batteryTempMax = intent.getDoubleExtra("batteryTempMax", 1);
            //meter_cores_gap.makeSections((int) cpuCoresMax, getResources().getColor(R.color.c_red_bright), Section.Style.SQUARE);
            meter_cores_gap.setMaxSpeed((float) cpuCoresMax);
            meter_cores_gap.speedTo((float) activeCores, 1);

            // 4. confirmed hashrate
            double hashrateConfirmed = intent.getDoubleExtra("hashrateConfirmed", 0);
            //meter_accepted_hash.makeSections(1, getResources().getColor(R.color.c_yellow), Section.Style.SQUARE);
            if (hashrateConfirmedMax < ((float) ((hashrateConfirmed / activeCores) * cpuCoresMax))) {
                hashrateConfirmedMax = ((float) ((hashrateConfirmed / activeCores) * cpuCoresMax));
                meter_accepted_hash.setMaxSpeed(hashrateConfirmedMax);
            }
            meter_accepted_hash.speedTo((float) hashrateConfirmed);

            // 5. set hashrate to string
            if(hashrateNormal == 0) {
                tvHashrate.setText("0");
            }else{
                tvHashrate.setText("~"+String.valueOf(Math.round(hashrateNormal*activeCores)));
            }

            // 6. show accu temp
            accuTemp.setText(String.valueOf(batteryTemp));


            // tdcAddress
            String tdcAddress = intent.getStringExtra("tdcAddress");
            userAddress.setText(tdcAddress);
        }
    };

    // Handling the received Intents for the "hashrateConfirmed" event
    private final BroadcastReceiver messageReceiverLogs = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            // Extract data included in the Intent
            String receivedMessage = intent.getStringExtra("logmessage");
            textViewLog.setText(receivedMessage);
        }
    };

    @Override
    protected void onPause() {
        // Unregister since the activity is not visible
        LocalBroadcastManager.getInstance(this).unregisterReceiver(messageReceiverHashrate);
        LocalBroadcastManager.getInstance(this).unregisterReceiver(messageReceiverLogs);
        super.onPause();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            // TODO Extract the data returned from the child Activity.
            String returnValue = data.getStringExtra("some_key");
            userAddress.setText(returnValue);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        meterHashrate = findViewById(R.id.meter_hashrate);
        meterCores = findViewById(R.id.meter_cores);
        meter_cores_gap = findViewById(R.id.meter_cores_gap);
        meter_accepted_hash = findViewById(R.id.meter_accepted_hash);


        // provide text edit for mining address
        userAddress = (TextView) findViewById(R.id.editTextUser);

        String tdcAddress = PreferenceManager.getDefaultSharedPreferences(this).getString("tdc_address_selected", null);
        userAddress.setText(tdcAddress);

        // provide textViewLog
        textViewLog = (TextView) findViewById(R.id.textViewLog);
        textViewLog.setMovementMethod(new ScrollingMovementMethod());
        tvHashrate = findViewById(R.id.hashrate);
        accuTemp = findViewById(R.id.accuTemp);

        // default hashrate to string
        TextView tvHashrate = findViewById(R.id.hashrate);
        tvHashrate.setText("-");

        // Foreground Service
        if(!foregroundServiceRunning()) {
            Intent serviceIntentForeground = new Intent(this, MiningForeGroundService.class);
            startForegroundService(serviceIntentForeground);
        }

        // activate bazzery temp check
        IntentFilter intentfilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        MainActivity.this.registerReceiver(broadcastreceiver,intentfilter);

        // activate settings button
        // initializing our button.
        settingsBtn = findViewById(R.id.idBtnSettings);

        // adding on click listener for our button.
        settingsBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // opening a new intent to open settings activity.
                Intent i = new Intent(MainActivity.this, SettingsActivity.class);
                startActivity(i);
            }
        });
    }

    public boolean foregroundServiceRunning(){
        ActivityManager activityManager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        for(ActivityManager.RunningServiceInfo service: activityManager.getRunningServices(Integer.MAX_VALUE)) {
            if(MiningForeGroundService.class.getName().equals(service.service.getClassName())) {
                return true;
            }
        }

        Toast.makeText(getApplicationContext(), "Miner is running as foreground Service", Toast.LENGTH_SHORT).show();

        return false;
    }

    private final BroadcastReceiver broadcastreceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            batteryTemp = (int)(intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE,0))/10;
        }
    };

}