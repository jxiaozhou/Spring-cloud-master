package com.pupilary.provider.query;

import java.io.Serializable;
import java.util.Date;

/**
 * @author takesi
 */
public class BrandQuery implements Serializable {

    private String name;

    private Date[] createTime;

    private Date[] updateTime;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date[] getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date[] createTime) {
        this.createTime = createTime;
    }

    public Date[] getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date[] updateTime) {
        this.updateTime = updateTime;
    }
}
