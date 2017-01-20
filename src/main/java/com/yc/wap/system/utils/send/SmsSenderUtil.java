package com.yc.wap.system.utils.send;

import com.ai.opt.sdk.components.mail.EmailFactory;
import com.ai.opt.sdk.components.mail.EmailTemplateUtil;
import com.ai.paas.ipaas.util.StringUtil;
import com.order.cc.sms.AccessType;
import com.order.cc.sms.SmsSender;
import com.order.cc.sms.entity.Body;
import com.order.cc.sms.entity.FocusSms;
import com.order.cc.sms.entity.Head;
import com.order.cc.sms.entity.Message;
import com.order.cc.sms.entity.Messages;

public class SmsSenderUtil {
	/**
	 * 发送短信
	 * @param telephone
	 * @param text
     * @return
     */
	public static boolean sendMessage(String telephone,String text){
		if(!StringUtil.isBlank(telephone)&&telephone.startsWith("+86")){
			telephone=telephone.replace("+86", "");
		}
		SmsSender sender=new SmsSender();
		Head head=new Head();
		head.setRequestType("SEND");
		head.setSystemId("4");
		String yeecloudUser = PropertiesUtil.getStringByKey("yeecloudUser");
		head.setUser(yeecloudUser);
		head.setStatus("0");
		String yeecloudPassword = PropertiesUtil.getStringByKey("yeecloudPassword");
		head.setPassword(yeecloudPassword);
		head.setMessageCount("1");
		head.setMessageFrom("1");
		head.setMessageFromName("yeecloud");
		head.setStatus("0");
		head.setErrorCode("0000");
		head.setErrorMessage("处理成功");
		Messages messages=new Messages();
		Message message=new Message();
		message.setBusinessType("DC0004");
		message.setMessageType("SMS");
		message.setMessageTo(telephone);
		message.setMessageSubject("yeecloud");
		message.setMessageText(text);
		message.setSendStartTime("");
		message.setCustomerType("5");
		message.setCustomerId("");
		message.setChannelType("9");
		message.setDepartmentId(""); 
		message.setBusinessData1("remark1");
		message.setBusinessData2("remark2");
		message.setBusinessData3("remark3");
		messages.addMessage(message);
		Body body=new Body();
		body.setMessages(messages);
		FocusSms f=new FocusSms();
		f.setBody(body);
		f.setHead(head);
		sender.setFocusSms(f);
		boolean flag = false;
		try {
			FocusSms focus=sender.send(AccessType.HTTP_TYPE);
			if(focus.getHead().getResult()){
				flag = true;
				System.out.println(focus.getHead().getErrorCode());
				System.out.println(focus.getHead().getErrorMessage());
			}else{
				flag = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return flag;
	}

	/**
	 * 发送邮件
	 * @param emailRequest
	 * @return
     */
	public static boolean sendEmail(SendEmailRequest emailRequest) {
		boolean success = true;
		String htmlcontext = EmailTemplateUtil.buildHtmlTextFromTemplate(emailRequest.getTemplateURL(), emailRequest.getData());
		try {
			EmailFactory.SendEmail(emailRequest.getTomails(), emailRequest.getCcmails(), emailRequest.getSubject(), htmlcontext);
		} catch (Exception e) {
			success = false;
			e.printStackTrace();
		}
		return true;
	}
}
