

Para projetos maven:

```xml

<plugin>
 <groupId>org.apache.tomcat.maven</groupId>
 <artifactId>tomcat7-maven-plugin</artifactId>
 <version>2.2</version>
 <configuration>
  <url>http://localhost:8080/manager/text</url>
  <server>TomcatServer</server>
  <path>/sample</path>
  <username>sutomcat</username>
  <password>@bana@na@</password>
 </configuration>
</plugin>

```