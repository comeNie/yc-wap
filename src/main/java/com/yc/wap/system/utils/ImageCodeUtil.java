package com.yc.wap.system.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;

import javax.imageio.ImageIO;
/**
 * Created by ldy on 2016/11/15.
 */
public class ImageCodeUtil {

    /**
    * 验证码生成器
    * @author dsna
    *
    */

    private char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N',  'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z',  '1', '2', '3', '4', '5', '6', '7', '8', '9' };
    /**
     *
     * @param width 图片宽
     * @param height 图片高
     * @param codeCount 字符个数
     * @param lineCount 干扰线条数
     */
    public String creatCode(int width,int height,int codeCount,int lineCount,OutputStream os) {
        // 验证码
        String code = null;
        int x = 0,fontHeight=0,codeY=0;
        int red = 0, green = 0, blue = 0;

        x = width / (codeCount +2);//每个字符的宽度
        fontHeight = height - 2;//字体的高度
        codeY = height - 4;

        // 图像buffer
        BufferedImage buffImg = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
        Graphics2D g = buffImg.createGraphics();
        // 生成随机数
        Random random = new Random();
        // 将图像填充为白色
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        // 创建字体
        Font dynamicFontPt = new Font("Atlantic Inline", Font.PLAIN, 24);

        g.setFont(dynamicFontPt);

        for (int i = 0; i < lineCount; i++) {
            int xs = random.nextInt(width);
            int ys = random.nextInt(height);
            int xe = xs+random.nextInt(width/8);
            int ye = ys+random.nextInt(height/8);
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            g.setColor(new Color(red, green, blue));
            g.drawLine(xs, ys, xe, ye);
        }

        // randomCode记录随机产生的验证码
        StringBuffer randomCode = new StringBuffer();
        // 随机产生codeCount个字符的验证码。
        for (int i = 0; i < codeCount; i++) {
            String strRand = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);
            // 产生随机的颜色值，让输出的每个字符的颜色值都将不同。
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            g.setColor(new Color(red, green, blue));
//            g.setColor(Color.RED);
            g.drawString(strRand, (i + 1) * x, codeY);
            // 将产生的四个随机数组合在一起。
            randomCode.append(strRand);
        }
        g.dispose();
        // 将四位数字的验证码保存到Session中。
        code=randomCode.toString();
        try {
            // 输出图像到页面
            ImageIO.write(buffImg, "PNG", os);
        } catch (IOException e) {
            return "";
        }
        return code;
    }
}
