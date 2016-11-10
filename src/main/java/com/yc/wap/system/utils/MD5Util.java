package com.yc.wap.system.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Nozomi on 11/3/2016.
 */
public class MD5Util {
    private static final char[] DIGITS = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    private static char[] encodeHex(byte[] data) {
        int l = data.length;
        char[] out = new char[l << 1];
        // two characters form the hex value.
        for (int i = 0, j = 0; i < l; i++) {
            out[j++] = DIGITS[(0xF0 & data[i]) >>> 4];
            out[j++] = DIGITS[0x0F & data[i]];
        }
        return out;
    }

    public static String encodePassword(String rawPass) {
        MessageDigest messageDigest = getMessageDigest();
        byte[] digest = messageDigest.digest(rawPass.getBytes());
        return new String(encodeHex(digest));
    }

    protected final static MessageDigest getMessageDigest() throws IllegalArgumentException {
        try {
            return MessageDigest.getInstance("MD5");
        }
        catch (NoSuchAlgorithmException e) {
            throw new IllegalArgumentException("No such algorithm [" + "MD5" + "]");
        }
    }
}
