package org.cd.weioa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity()
@Table(name = "user")
public class User {

    private String userId;
    
    private String userOpenId;
    
    private String userName;
    
    private String userPhone;
    
    private String userEmail;
    
    private String wxNickName;
    
    private String wxSex;
    
    private String wxProvince;
    
    private String wxCity;
    
    private String wxCountry;
    
    private String wxHeadImgUrl;
    
    private String wxUnionId;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column(name = "user_open_id")
    public String getUserOpenId() {
        return userOpenId;
    }

    public void setUserOpenId(String userOpenId) {
        this.userOpenId = userOpenId;
    }

    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Column(name = "user_phone")
    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    @Column(name = "user_email")
    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    @Column(name = "wx_nick_name")
    public String getWxNickName() {
        return wxNickName;
    }

    public void setWxNickName(String wxNickName) {
        this.wxNickName = wxNickName;
    }

    @Column(name = "wx_sex")
    public String getWxSex() {
        return wxSex;
    }

    public void setWxSex(String wxSex) {
        this.wxSex = wxSex;
    }

    @Column(name = "wx_province")
    public String getWxProvince() {
        return wxProvince;
    }

    public void setWxProvince(String wxProvince) {
        this.wxProvince = wxProvince;
    }

    @Column(name = "wx_city")
    public String getWxCity() {
        return wxCity;
    }

    public void setWxCity(String wxCity) {
        this.wxCity = wxCity;
    }

    @Column(name = "wx_country")
    public String getWxCountry() {
        return wxCountry;
    }

    public void setWxCountry(String wxCountry) {
        this.wxCountry = wxCountry;
    }

    @Column(name = "wx_head_img_url")
    public String getWxHeadImgUrl() {
        return wxHeadImgUrl;
    }

    public void setWxHeadImgUrl(String wxHeadImgUrl) {
        this.wxHeadImgUrl = wxHeadImgUrl;
    }

    @Column(name = "wx_union_id")
    public String getWxUnionId() {
        return wxUnionId;
    }

    public void setWxUnionId(String wxUnionId) {
        this.wxUnionId = wxUnionId;
    }
    
}
