#!/bin/sh
#env
APP_NAME="yc.wap.web"

#set base home
RESOURCES_HOME=${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes

#change config

#paas-conf.properties
sed -i "s%paas.auth.url=.*%paas.auth.url=${PAAS_AUTH_URL}%g" ${RESOURCES_HOME}/paas/paas-conf.properties
sed -i "s%paas.auth.pid=.*%paas.auth.pid=${PAAS_AUTH_PID}%g" ${RESOURCES_HOME}/paas/paas-conf.properties
sed -i "s%paas.ccs.serviceid=.*%paas.ccs.serviceid=${PAAS_CCS_ID}%g" ${RESOURCES_HOME}/paas/paas-conf.properties
sed -i "s%paas.ccs.servicepassword=.*%paas.ccs.servicepassword=${PAAS_CCS_PWD}%g" ${RESOURCES_HOME}/paas/paas-conf.properties

sed -i "s%paas.sdk.mode=.*%paas.sdk.mode=${SDK_MODE}%g" ${RESOURCES_HOME}/paas/paas-conf.properties
sed -i "s%ccs.appname=.*%ccs.appname=${CCS_NAME}%g" ${RESOURCES_HOME}/paas/paas-conf.properties
sed -i "s%ccs.zk_address=.*%ccs.zk_address=${ZK_ADDR}%g" ${RESOURCES_HOME}/paas/paas-conf.properties

# 各中心要根据情况自己修改成与dubbo.properties中对应的配置项
sed -i "s%dubbo.registry.address=.*%dubbo.registry.address=${REST_REGISTRY_ADDR}%g" ${RESOURCES_HOME}/dubbo.properties

#email-conf.properties
sed -i "s%email.hostname=.*%email.hostname=${EMAIL_HOSTNAME}%g" ${RESOURCES_HOME}/email/email-conf.properties
sed -i "s%email.from.mail=.*%email.from.mail=${EMAIL_FROM_MAIL}%g" ${RESOURCES_HOME}/email/email-conf.properties
sed -i "s%email.from.name=.*%email.from.name=${EMAIL_FROM_NAME}%g" ${RESOURCES_HOME}/email/email-conf.properties
sed -i "s%email.from.user=.*%email.from.user=${EMAIL_FROM_USER}%g" ${RESOURCES_HOME}/email/email-conf.properties
sed -i "s%email.from.password=.*%email.from.password=${EMAIL_FROM_PASSWORD}%g" ${RESOURCES_HOME}/email/email-conf.properties

#config.properties
sed -i "s%TENANT_ID=.*%TENANT_ID=${TENANT_ID}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%REQUEST_KEY=.*%REQUEST_KEY=${REQUEST_KEY}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%ACTION_URL=.*%ACTION_URL=${ACTION_URL}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%APP_ACTION_URL=.*%APP_ACTION_URL=${APP_ACTION_URL}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%NOTIFY_URL=.*%NOTIFY_URL=${NOTIFY_URL}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%RETURN_URL=.*%RETURN_URL=${RETURN_URL}%g" ${RESOURCES_HOME}/config.properties

sed -i "s%hcicloud.url=.*%hcicloud.url=${HCICLOUD_URL}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%hcicloud.appkey=.*%hcicloud.appkey=${HCICLOUD_APPKEY}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%hcicloud.devkey=.*%hcicloud.devkey=${HCICLOUD_DEVKEY}%g" ${RESOURCES_HOME}/config.properties

sed -i "s%yeekit.translate.url=.*%yeekit.translate.url=${YEEKIT_TRANSLATE_URL}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%yeekit.translate.appkid=.*%yeekit.translate.appkid=${YEEKIT_TRANSLATE_APPKID}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%yeekit.translate.appkey=.*%yeekit.translate.appkey=${YEEKIT_TRANSLATE_APPKEY}%g" ${RESOURCES_HOME}/config.properties
sed -i "s%yee.detection.url=.*%yee.detection.url=${YEE_DETECTION_URL}%g" ${RESOURCES_HOME}/config.properties

#FocusSms.properties
sed -i "s%SoaServerIpAddressA=.*%SoaServerIpAddressA=${SoaServerIpAddressA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%SoaServerIpPortA=.*%SoaServerIpPortA=${SoaServerIpPortA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%HttpServerIpAddressA=.*%HttpServerIpAddressA=${HttpServerIpAddressA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%HttpServerPortA=.*%HttpServerPortA=${HttpServerPortA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%TcpServerAddressA=.*%TcpServerAddressA=${TcpServerAddressA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%TcpServerPortA=.*%TcpServerPortA=${TcpServerPortA}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%TcpReceivePort=.*%TcpReceivePort=${TcpReceivePort}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%soapnamespace=.*%soapnamespace=${soapnamespace}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%yeecloudUser=.*%yeecloudUser=${yeecloudUser}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%yeecloudPassword=.*%yeecloudPassword=${yeecloudPassword}%g" ${RESOURCES_HOME}/FocusSms.properties
sed -i "s%MessageFormYeecloud=.*%MessageFormYeecloud=${MessageFormYeecloud}%g" ${RESOURCES_HOME}/FocusSms.properties


nohup ${CATALINA_HOME}/bin/catalina.sh run >> /${APP_NAME}.log