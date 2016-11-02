package com.yc.wap.system.base;

import com.yc.wap.system.constants.Constants;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by Nozomi on 11/2/2016.
 */
public class MsgBean {
    private boolean success;
    private String status;
    private String msg;
    private Map dto;

    public MsgBean() {
        //默认的数据
        this.success=true;
        this.msg="操作成功";
        this.status= Constants.AjaxStatus.STATUS_SUCCESS;
        dto=new HashMap();
        dto.put(Constants.AjaxReturn.SUCCESS, this.success);
        dto.put(Constants.AjaxReturn.STATUS_INFO, msg);
        dto.put(Constants.AjaxReturn.STATUS_CODE, this.status);
    }

    public MsgBean(boolean success,String msg,String status) {
        //默认的数据
        this.success=success;
        this.msg="msg";
        this.status=status;
        dto=new HashMap();
        dto.put(Constants.AjaxReturn.SUCCESS, this.success);
        dto.put(Constants.AjaxReturn.STATUS_INFO, msg);
        dto.put(Constants.AjaxReturn.STATUS_CODE, this.status);
    }

    public void putData(Object value){
        dto.put(Constants.AjaxReturn.RETURN_DATA, value);
    }

    /**
     * 公开的插入数据的接口
     */
    public void put(String key,Object value){
        dto.put(key, value);
    }

    /**
     * map的键值对放入到返回数据
     */
    public void putMap(Map msg){
        Set<String> keySet=msg.keySet();
        for(String key:keySet){
            dto.put(key, msg.get(key));
        }
    }

    /**
     * 设置错误信息 标记为后台出错 自定义错误信息
     */
    public void setFailure(String errorMsg){
        dto.put(Constants.AjaxReturn.SUCCESS, false);
        dto.put(Constants.AjaxReturn.STATUS_INFO, errorMsg);
        dto.put(Constants.AjaxReturn.STATUS_CODE, Constants.AjaxStatus.STATUS_FAILURE);
    }

    /**
     * 设置错误信息 标记为后台出错 自定义错误信息
     */
    public void setFailure( String errCode, String errorMsg){
        dto.put(Constants.AjaxReturn.STATUS_INFO, errorMsg);
        dto.put(Constants.AjaxReturn.STATUS_CODE, errCode);
    }

    /**
     * 返回给前台信息
     */
    public Map returnMsg(){
        return dto;
    }
}
