package org.cd.weioa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity()
@Table(name = "device")
public class Device {

    private String deviceId;
    
    private String deviceName;
    
    private String deviceModel;
    
    private String deviceType;
    
    private String devicePrice;
    
    private String deviceDescription;
    
    private String deviceFunction;
    
    private String deviceImageUrl;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "device_id")
    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    @Column(name = "device_name")
    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    @Column(name = "device_model")
    public String getDeviceModel() {
        return deviceModel;
    }

    public void setDeviceModel(String deviceModel) {
        this.deviceModel = deviceModel;
    }

    @Column(name = "device_type")
    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    @Column(name = "device_price")
    public String getDevicePrice() {
        return devicePrice;
    }

    public void setDevicePrice(String devicePrice) {
        this.devicePrice = devicePrice;
    }

    @Column(name = "device_description")
    public String getDeviceDescription() {
        return deviceDescription;
    }

    public void setDeviceDescription(String deviceDescription) {
        this.deviceDescription = deviceDescription;
    }

    @Column(name = "device_function")
    public String getDeviceFunction() {
        return deviceFunction;
    }

    public void setDeviceFunction(String deviceFunction) {
        this.deviceFunction = deviceFunction;
    }

    @Column(name = "device_image_url")
    public String getDeviceImageUrl() {
        return deviceImageUrl;
    }

    public void setDeviceImageUrl(String deviceImageUrl) {
        this.deviceImageUrl = deviceImageUrl;
    }
    
}
