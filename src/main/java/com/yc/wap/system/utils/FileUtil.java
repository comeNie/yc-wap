package com.yc.wap.system.utils;

import java.io.*;

/**
 * Created by Nozomi on 11/3/2016.
 */
public class FileUtil {
    public static byte[] ByteinfoFile(byte[] filedata, int offset) {
            byte[] audioByte=null;
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            InputStream input = new ByteArrayInputStream(filedata);
            byte[] buffer = new byte[1024*1024];
            int lens;
            while ((lens = input.read(buffer)) > -1 ) {
                baos.write(buffer, 0, lens);
            }
            baos.flush();

            InputStream is = new ByteArrayInputStream(baos.toByteArray());
            is.skip(offset);

            ByteArrayOutputStream audioStream = new ByteArrayOutputStream();
            byte[] b=new byte[1024*1024];
            int len=0;
            while ((len = is.read(b)) != -1){
                audioStream.write(b,0,len);
            }

            audioByte = audioStream.toByteArray();

            is.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return audioByte;
    }
}
