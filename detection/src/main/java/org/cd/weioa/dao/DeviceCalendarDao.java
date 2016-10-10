package org.cd.weioa.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.DeviceCalendar;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class DeviceCalendarDao extends BaseDaoImpl<DeviceCalendar> {
    
    public List<Object[]> getUsedCalendarCount(String deviceId, String startDate, String endDate) {
        String sql = "SELECT dc.calendar_date, COUNT(dc.schedule_id) FROM device_calendar dc WHERE dc.calendar_date >= :startDate AND dc.calendar_date <= :endDate AND dc.device_id = :deviceId GROUP BY dc.calendar_date";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("deviceId", deviceId);
        List<Object[]> calendars = this.getDatasBySQL(sql, params);
        return calendars;
    }
    
    public List<DeviceCalendar> getUsedCalendarList(String deviceId, String calendarDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = sdf.parse(calendarDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String hql = "from DeviceCalendar dc where dc.deviceId=:deviceId and dc.calendarDate=:calendarDate";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        params.put("calendarDate", date);
        return this.getDatasByHQL(hql, params);
    }
    
    public Long getCountOfCalendar(String deviceId, Date calendarDate, List<String> scheduleIds) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deviceId", deviceId);
        params.put("calendarDate", calendarDate);
        params.put("scheduleIds", scheduleIds);
        String hql = "select count(*) from DeviceCalendar dc where dc.deviceId=:deviceId and dc.calendarDate=:calendarDate and dc.scheduleId in :scheduleIds";
        return this.getCountByHQL(hql, params);
    }
    
}
