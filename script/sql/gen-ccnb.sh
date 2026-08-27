export MODELBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/modelbase/03.Development/modelbase-data
export MODELBASE_JAR=/Users/christian/export/opt/modelbase/protosys-plugin-modelbase-7.0-shaded.jar
export PROJBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/projbase/03.Development/projbase-data
export PROJBASE_JAR=/Users/christian/export/opt/projbase/protosys-plugin-projbase-7.0-shaded.jar

export OUTPUT_ROOT=out

export SPEC=ccnb
export APPNAME=ccnb
export NAMESPACE=biz.doublegsoft
export MOBELBASE_MODEL=spec/$SPEC.modelbase
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"-sql-2.x
################################################################################
##                                                                            ##
##                                      SQL                                   ##
##                                                                            ##
################################################################################
REPOS=("modelbase-olap@obt-1.x")

for repo in "${REPOS[@]}"
do
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/modelbase/$repo

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.c.CConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.c.CNamingConvention\",\
\"language\":\"c\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1
done
#
#################################################################################
###                                                                            ##
###                                      SQL                                   ##
###                                                                            ##
#################################################################################
#REPOS=("sql-ddl@dw#obt-1.x")
#
#for repo in "${REPOS[@]}"
#do
#export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/sql/$repo
#
#java -jar $MODELBASE_JAR \
#--model=$MOBELBASE_MODEL \
#--template-root=$TEMPLATE_ROOT \
#--output-root=$PROJECT_ROOT \
#--license=LICENSE \
#--globals=\
#\{\
#\"application\":\"$APPNAME\",\
#\"namespace\":\"$NAMESPACE\",\
#\"artifact\":\"$APPNAME\",\
#\"version\":\"1.0.0\",\
#\"description\":\"\",\
#\"naming\":\"com.doublegsoft.jcommons.programming.java.JavaConventions\",\
#\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.java.JavaNamingConvention\",\
#\"language\":\"java\",\
#\"imports\":\
#\[\],\
#\"dependencies\":\
#\[\]\
#\} 2>&1
#done
#
#################################################################################
###                                                                            ##
###                              SPRINGBOOT (JAVA)                             ##
###                                                                            ##
#################################################################################
#export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/java/java-backend@springboot-1.x
#
#java -jar $PROJBASE_JAR \
#--model=$MOBELBASE_MODEL \
#--template-root=$TEMPLATE_ROOT \
#--output-root=$PROJECT_ROOT \
#--license=LICENSE \
#--globals=\
#\{\
#\"application\":\"$APPNAME\",\
#\"namespace\":\"$NAMESPACE\",\
#\"artifact\":\"$APPNAME\",\
#\"version\":\"1.0.0\",\
#\"description\":\"\",\
#\"naming\":\"com.doublegsoft.jcommons.programming.java.JavaConventions\",\
#\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.java.JavaNamingConvention\",\
#\"language\":\"java\",\
#\"imports\":\
#\[\],\
#\"dependencies\":\
#\[\]\
#\} 2>&1
#
#mvn clean package -f $PROJECT_ROOT/pom.xml
