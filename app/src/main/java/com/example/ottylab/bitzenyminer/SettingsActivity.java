package com.example.ottylab.bitzenyminer;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

public class SettingsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);

        int cpuCores = Runtime.getRuntime().availableProcessors();

        // below line is used to check if
        // frame layout is empty or not.
        if (findViewById(R.id.idFrameLayout) != null) {
            if (savedInstanceState != null) {
                return;
            }
            // below line is to inflate our fragment.
            getFragmentManager().beginTransaction().add(R.id.idFrameLayout, new SettingsFragment()).commit();

        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
    }
}