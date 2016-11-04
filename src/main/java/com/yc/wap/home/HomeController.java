package com.yc.wap.home;

import com.yc.wap.system.base.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "home")
public class HomeController extends BaseController{
	private Log log = LogFactory.getLog(HomeController.class);

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

//	public void tts() {
//		byte[] resp = HttpUtil.TTShttpReq("吃葡萄不吐葡萄皮不吃葡萄到吐葡萄皮");
//
//		String result = new String(resp);
//		String[] splits = result.split("</ResponseInfo>");
//		String xml = splits[0] + "</ResponseInfo>";
//		int offset = xml.getBytes().length;
//
//		FileUtil.ByteinfoFile(resp, FILE, offset);
//	}


	
}
