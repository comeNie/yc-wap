package com.yc.wap.system.utils;

import java.util.*;

/**
 * Created by Nozomi on 12/10/2016.
 */
public class MapSortUtil {
    /**
     * 使用 Map按key进行排序（倒序）
     *
     * @param map
     * @return
     */
    public static Map<String, String> sortMapByKey(Map<String, String> map) {
        if (map == null || map.isEmpty()) {
            return null;
        }

        Map<String, String> sortMap = new TreeMap<String, String>(new Comparator<String>() {
            @Override
            public int compare(String str1, String str2) {

                return str2.compareTo(str1);
            }
        });

        sortMap.putAll(map);
        return sortMap;
    }

    /**
     * 使用 Map按value进行排序
     *
     * @param oriMap
     * @return
     */
    public static Map<String, String> sortMapByValue(Map<String, String> oriMap) {
        if (oriMap == null || oriMap.isEmpty()) {
            return null;
        }
        Map<String, String> sortedMap = new LinkedHashMap<String, String>();

        List<Map.Entry<String, String>> entryList = new ArrayList<Map.Entry<String, String>>(oriMap.entrySet());

        Collections.sort(entryList, new Comparator<Map.Entry<String, String>>() {
            @Override
            public int compare(Map.Entry<String, String> me1, Map.Entry<String, String> me2) {

                return me1.getValue().compareTo(me2.getValue());
            }
        });

        Iterator<Map.Entry<String, String>> iter = entryList.iterator();
        Map.Entry<String, String> tmpEntry = null;
        while (iter.hasNext()) {
            tmpEntry = iter.next();
            sortedMap.put(tmpEntry.getKey(), tmpEntry.getValue());
        }
        return sortedMap;
    }

}
