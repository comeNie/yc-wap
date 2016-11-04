package com.yc.wap.home;

import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.utils.FileUtil;
import com.yc.wap.system.utils.HttpUtil;
import com.yc.wap.system.utils.HttpsUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "home")
public class HomeController {
	private Log log = LogFactory.getLog(HomeController.class);

	public static String FILE = "assets/TTS.mp3";
	public static String FILE1 = "assets/TTS1.txt";
	public static String TRANSREQ = "https://translateport.yeekit.com/translate";

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		System.out.print("aasdasd");
		log.info("HomeController-home invoked");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	public void tts() {
		byte[] resp = HttpUtil.TTShttpReq("吃葡萄不吐葡萄皮不吃葡萄到吐葡萄皮");

		String result = new String(resp);
		String[] splits = result.split("</ResponseInfo>");
		String xml = splits[0] + "</ResponseInfo>";
		int offset = xml.getBytes().length;

		FileUtil.ByteinfoFile(resp, FILE, offset);
	}

	public void translate() {
//		String paramter = "{\"srcl\":zh,\"tgtl\":en,\"text\":%E4%B8%AD%E5%9B%BD,\"detoken\":true,\"align\":true}";

		JSONObject jsonObject=new JSONObject();
		jsonObject.put("srcl", "zh");
		jsonObject.put("tgtl", "en");
		jsonObject.put("text", "你很漂亮");
		jsonObject.put("detoken", true);
		jsonObject.put("align", true);

		String resp = null;
		try {
			resp = HttpsUtil.HttpsPost(TRANSREQ, jsonObject.toString(), "UTF-8");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (KeyManagementException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(resp);
	}
	
}
