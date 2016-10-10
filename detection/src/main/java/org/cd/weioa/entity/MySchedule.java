package org.cd.weioa.entity;

import java.util.Date;
import java.util.List;

public class MySchedule {
    
    private String orderId;
    
    private String deviceId;
    
    private String deviceName;
    
    private String deviceModel;
    
    private String deviceImageUrl;
    
    private Date orderDate;
    
    private List<String> calendarTimes;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public void setDeviceModel(String deviceModel) {
        this.deviceModel = deviceModel;
    }

    public String getDeviceImageUrl() {
        return deviceImageUrl;
    }

    public void setDeviceImageUrl(String deviceImageUrl) {
        this.deviceImageUrl = deviceImageUrl;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public List<String> getCalendarTimes() {
        return calendarTimes;
    }

    public void setCalendarTimes(List<String> calendarTimes) {
        this.calendarTimes = calendarTimes;
    }
    
}
