package com.chen.smess.domain.common.utils;

import com.chen.smess.domain.service.system.menu.impl.MenuService;
import com.chen.smess.domain.service.system.role.impl.RoleService;
import com.chen.smess.domain.service.system.user.UserManager;

public final class ServiceHelper {
	
	public static Object getService(String serviceName){
		//WebApplicationContextUtils.
		return Const.WEB_APP_CONTEXT.getBean(serviceName);
	}
	
	public static UserManager getUserService(){
		return (UserManager) getService("userService");
	}
	
	public static RoleService getRoleService(){
		return (RoleService) getService("roleService");
	}
	
	public static MenuService getMenuService(){
		return (MenuService) getService("menuService");
	}
}
