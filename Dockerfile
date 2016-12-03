# Pull base image
FROM 10.19.13.36:5000/tomcat:7.x-GMT
MAINTAINER gucl<gucl@asiainfo.com>

# Install tomcat7
RUN rm -rf /opt/tomcat/webapps/* && mkdir /opt/tomcat/webapps/ROOT
# 如门户中心的为yc-wap.war
COPY ./build/libs/yc-wap.war /opt/tomcat/webapps/ROOT/ROOT.war
RUN cd /opt/tomcat/webapps/ROOT && jar -xf ROOT.war && rm -rf /opt/tomcat/webapps/ROOT.war

ADD ./script/start-web.sh /start-web.sh
RUN chmod 755 /*.sh

# Define default command.
CMD ["/start-web.sh"]