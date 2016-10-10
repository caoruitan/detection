package org.cd.weioa.dao;

import java.util.List;

import org.cd.weioa.entity.Device;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class DeviceDao extends BaseDaoImpl<Device> {
    
    public List<Device> deviceList() {
        String hql = "from Device";
        return this.getDatasByHQL(hql);
    }
    
}
