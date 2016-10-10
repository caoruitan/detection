package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.Map;

import org.cd.weioa.entity.User;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends BaseDaoImpl<User> {
    
    public User getUserByOpenId(String openId) {
        String hql = "from User u where u.userOpenId=:openId";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("openId", openId);
        return this.getDataByHQL(hql, params);
    }
    
}
