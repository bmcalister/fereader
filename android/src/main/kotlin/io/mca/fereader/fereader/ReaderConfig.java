package io.mca.fereader.fereader;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;

import com.folioreader.Config;
import com.folioreader.util.AppUtil;

public class ReaderConfig {
    private String identifier;
    private String themeColor;
    private String scrollDirection;
    private boolean allowSharing;
    private boolean showTts;
    private boolean nightMode;

    public Config config;

    public ReaderConfig(Context context, String identifier, String themeColor,
                        String scrollDirection, boolean allowSharing, boolean showTts , boolean nightMode){

        config = new Config();
        config.setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL);
        if (scrollDirection.equals("vertical")){
            config.setDirection(Config.Direction.VERTICAL);
        }else if(scrollDirection.equals("horizontal")){
            config.setDirection(Config.Direction.HORIZONTAL);
        }
        config.setThemeColorInt(Color.parseColor(themeColor));
        config.setNightThemeColorInt(Color.parseColor(themeColor));
        config.setShowRemainingIndicator(false);
        config.setShowTts(showTts);
        config.setNightMode(nightMode);
    }
}
