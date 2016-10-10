package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.DeviceCalendarOrder;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class DeviceCalendarOrderDao extends BaseDaoImpl<DeviceCalendarOrder> {
    
    public List<Object[]> mySchedule(String userId) {
        String sql = "SELECT dc.calendar_id, dc.schedule_id, ds.schedule_time, dorder.order_id, dorder.device_id, dorder.order_date, dorder.device_name, dorder.device_model, dorder.device_image_url FROM device_calendar dc LEFT JOIN device_schedule ds ON ds.schedule_id = dc.schedule_id LEFT JOIN (SELECT dco.order_id, dco.device_id, dco.order_date, dco.creator, d.device_name, d.device_image_url, d.device_model FROM device_calendar_order dco LEFT JOIN device d ON d.device_id = dco.device_id) dorder ON dorder.order_id=dc.order_id WHERE dorder.creator = :creator ORDER BY dorder.order_date, ds.schedule_time";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("creator", userId);
        return this.getDatasBySQL(sql, params);
    }
    
    public List<Object[]> deviceScheduleOfDate(String deviceId, String date) {
        String sql = "SELECT sds.schedule_time, sdc.calendar_id, sdc.user_name, sdc.user_email, sdc.user_phone, sds.schedule_id, sdc.order_id FROM (SELECT ds.schedule_id, ds.device_id, ds.schedule_time FROM device_schedule ds WHERE ds.device_id = :deviceId) sds LEFT JOIN (SELECT dc.calendar_id, dc.order_id, dc.schedule_id, u.user_name, u.user_email, u.user_phone FROM device_calendar dc LEFT JOIN device_calendar_order dco ON dco.order_id = dc.order_id LEFT JOIN user u ON u.user_open_id = dco.creator WHERE dc.device_id = :deviceId AND dc.calendar_date = :date) sdc ON sdc.schedule_id = sds.schedule_id ORDER BY sds.schedule_time";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        params.put("date", date);
        return this.getDatasBySQL(sql, params);
    }
    
}
