FROM ches/kafka
MAINTAINER David Chen <mvjome@gmail.com>

USER root
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install curl maven git -y

# in order to run MySQL onetimeserver
RUN apt-get install gcc -y



USER kafka
WORKDIR /kafka
RUN git clone https://github.com/zendesk/maxwell.git
WORKDIR /kafka/maxwell
RUN ls -la
RUN git pull
RUN git tag  -l
RUN git checkout v1.1.0-PRE1

# Fix "Unmappable character for encoding ASCII" error in test file
#   src/test/java/com/zendesk/maxwell/ColumnDefTest.java
ENV JAVA_TOOL_OPTIONS     -Dfile.encoding=UTF8

RUN mvn install
