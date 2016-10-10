package org.cd.weioa.weinxin;

import org.cd.weioa.http.HttpHelper;

import net.sf.json.JSONObject;

public class WeixinUtil {
    
    public static UserInfo getUserInfo(String code) {
        if(code != null) {
            String tokenJson = HttpHelper.getInstance().setUrl("https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxeb16fda239ff4130&secret=2cec1d3e86b4c911657fabfb4321a5b0&code=" + code + "&grant_type=authorization_code").get();
            JSONObject tokenObj = JSONObject.fromObject(tokenJson);
            String accessToken = tokenObj.getString("access_token");
            String openId = tokenObj.getString("openid");
            
            String userInfoJson = HttpHelper.getInstance().setUrl("https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openId + "&lang=zh_CN").get();
            System.out.println(userInfoJson);
            String userInfoJson1 = HttpHelper.getInstance().setUrl("https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openId + "&lang=zh_CN").get();
            System.out.println(userInfoJson1);
            JSONObject userInfoObj = JSONObject.fromObject(userInfoJson);
            UserInfo userInfo = new UserInfo();
            userInfo.setOpenId(openId);
            userInfo.setNickName(userInfoObj.getString("nickname"));
            userInfo.setSex(userInfoObj.getString("sex"));
            userInfo.setProvince(userInfoObj.getString("province"));
            userInfo.setCity(userInfoObj.getString("city"));
            userInfo.setCountry(userInfoObj.getString("country"));
            userInfo.setHeadImgUrl(userInfoObj.getString("headimgurl"));
            return userInfo;
        }
        return null;
    }
}
