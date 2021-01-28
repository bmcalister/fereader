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

//        config = AppUtil.getSavedConfig(context);
//        if (config == null)
        config = new Config();
        if (scrollDirection.equals("vertical")){
            config.setAllowedDirection(Config.AllowedDirection.ONLY_VERTICAL);
            config.setDirection(Config.Direction.VERTICAL);
        }else if(scrollDirection.equals("horizontal")){
            config.setAllowedDirection(Config.AllowedDirection.ONLY_HORIZONTAL);
            config.setDirection(Config.Direction.HORIZONTAL);
        }else{
            config.setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL);
        }
        config.setThemeColorInt(Color.parseColor(themeColor));
        config.setNightThemeColorInt(Color.parseColor(themeColor));
        config.setShowRemainingIndicator(true);
        config.setShowTts(showTts);
        config.setNightMode(nightMode);
    }
}
