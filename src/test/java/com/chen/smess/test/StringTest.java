package com.chen.smess.test;

import org.junit.Test;

import java.text.DecimalFormat;

public class StringTest {
    @Test
    public void testString(){
        double s=88.0;
        DecimalFormat format = new DecimalFormat("#.00");
        String sMoney = format.format(s);
        System.out.println(sMoney);
    }

}
