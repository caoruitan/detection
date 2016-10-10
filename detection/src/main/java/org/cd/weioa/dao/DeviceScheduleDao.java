package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.DeviceSchedule;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class DeviceScheduleDao extends BaseDaoImpl<DeviceSchedule> {
    
    public Long getCountSchedulePerDay(String deviceId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        return this.getCountBySQL("select count(*) from device_schedule ds where ds.device_id=:deviceId", params);
    }
    
    public List<DeviceSchedule> getScheduleList(String deviceId) {
        String hql = "from DeviceSchedule ds where ds.deviceId=:deviceId order by ds.scheduleTime";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        return this.getDatasByHQL(hql, params);
    }
    
    public List<DeviceSchedule> getScheduleListByTimes(String deviceId, String[] times) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        params.put("times", times);
        String hql = "from DeviceSchedule ds where ds.deviceId=:deviceId and ds.scheduleTime in :times";
        return this.getDatasByHQL(hql, params);
    }
}
