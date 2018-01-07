package com.chen.smess.test;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import javax.annotation.Resource;
import java.text.DecimalFormat;
@ContextConfiguration(locations = {"classpath:META-INF/spring/ApplicationContext-main.xml"})

public class StringTest {
    @Resource(name = "kucunService")
    private KucunManager kucunService;
    @Test
    public void testString(){
        double s=88.0;
        DecimalFormat format = new DecimalFormat("#.00");
        String sMoney = format.format(s);
        System.out.println(sMoney);
    }

    @Test
    public void testkucun() throws Exception {
        PageData pageData = new PageData();
        pageData.put("KUCUN_ID","ae405f5b48b94f51bc3c2e47ec2d3b24");
        pageData.put("GCOUNT","10.00");
        kucunService.editKuCun(pageData);
    }

}
