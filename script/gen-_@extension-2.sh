export MODELBASE_MODEL_ROOT=/Volumes/EXPORT/local/works/doublegsoft.biz/stdbiz/03.Development/stdbiz-spec
export MODELBASE_DATA_ROOT=/Volumes/EXPORT/local/works/doublegsoft.io/modelbase/03.Development/modelbase-data
export PROJBASE_DATA_ROOT=/Volumes/EXPORT/local/works/doublegsoft.io/projbase/03.Development/projbase-data
export MODELBASE_JAR=/Volumes/EXPORT/local/works/doublegsoft.org/protosys/03.Development/protosys-plugin-modelbase/target/protosys-plugin-modelbase-6.0-shaded.jar
export PROJBASE_JAR=/Volumes/EXPORT/local/works/doublegsoft.org/protosys/03.Development/protosys-plugin-projbase/target/protosys-plugin-projbase-4.5-shaded.jar
export OUTPUT_ROOT=out

export SPEC=单个直接继承和灵活间接扩展
export APPNAME=smbiz
export NAMESPACE=biz.doublegsoft
export MOBELBASE_MODEL=spec/$SPEC.modelbase
export PROJECT_ROOT=$OUTPUT_ROOT/$SPEC
################################################################################
##                                                                            ##
##                                     JAVA                                   ##
##                                                                            ##
################################################################################
REPOS=("java-poco@gfc-1.x" "java-util@gfc-1.x" "java-dto@gfc-1.x" "java-orm@mybatis-1.x" "java-orm@gfc-1.x" \
"java-tx@spring-1.x" "java-mvc@spring-1.x" "java-test@gfc-1.x")

for repo in "${REPOS[@]}"
do
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/java/$repo

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.java.JavaConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.java.JavaNamingConvention\",\
\"language\":\"java\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1
done

################################################################################
##                                                                            ##
##                              SPRINGBOOT (JAVA)                             ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/java/java-backend@gfc%springboot-1.x

java -jar $PROJBASE_JAR \
--model=$MOBELBASE_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.java.JavaConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.java.JavaNamingConvention\",\
\"language\":\"java\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

mvn clean package -f $PROJECT_ROOT/pom.xml

################################################################################
##                                                                            ##
##                                  DTO (DART)                                ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/dart/dart-dto@gfc-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--dependent-model=$DEPEDENT_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.dart.DartConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.dart.DartNamingConvention\",\
\"language\":\"dart\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

################################################################################
##                                                                            ##
##                                  POCO (DART)                               ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/dart/dart-poco@gfc-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--dependent-model=$DEPEDENT_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.dart.DartConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.dart.DartNamingConvention\",\
\"language\":\"dart\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

################################################################################
##                                                                            ##
##                                  DB (DART)                                 ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/dart/dart-db@sqflite%flutter-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--dependent-model=$DEPEDENT_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.dart.DartConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.dart.DartNamingConvention\",\
\"language\":\"dart\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

################################################################################
##                                                                            ##
##                                  SDK (DART)                                ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/dart/dart-sdk@gfc-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--dependent-model=$DEPEDENT_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.dart.DartConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.dart.DartNamingConvention\",\
\"language\":\"dart\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

################################################################################
##                                                                            ##
##                                PROVIDER (DART)                              ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/dart/dart-provider@gfc-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $MODELBASE_JAR \
--model=$MOBELBASE_MODEL \
--dependent-model=$DEPEDENT_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.dart.DartConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.dart.DartNamingConvention\",\
\"language\":\"dart\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1

################################################################################
##                                                                            ##
##                                FLUTTER (DART)                              ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/dart/dart-universal@gfc%flutter-1.x
export PROJECT_ROOT=$OUTPUT_ROOT/"$SPEC"_flutter

java -jar $PROJBASE_JAR \
--model=$MOBELBASE_MODEL \
--template-root=$TEMPLATE_ROOT \
--output-root=$PROJECT_ROOT \
--license=res/LICENSE \
--globals=\
\{\
\"application\":\"$APPNAME\",\
\"namespace\":\"$NAMESPACE\",\
\"artifact\":\"$APPNAME\",\
\"version\":\"1.0.0\",\
\"description\":\"\",\
\"naming\":\"com.doublegsoft.jcommons.programming.java.JavaConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.java.JavaNamingConvention\",\
\"language\":\"java\",\
\"shareable\":true,\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1


