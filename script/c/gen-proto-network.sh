export MODELBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/modelbase/03.Development/modelbase-data
export MODELBASE_JAR=/Users/christian/export/opt/modelbase/protosys-plugin-modelbase-7.0-shaded.jar
export PROJBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/projbase/03.Development/projbase-data
export PROJBASE_JAR=/Users/christian/export/opt/projbase/protosys-plugin-projbase-7.0-shaded.jar

export OUTPUT_ROOT=out/c

export SPEC=proto-network
export APPNAME=pnw
export NAMESPACE=pnw
export MOBELBASE_MODEL=spec/$SPEC.modelbase
export PROJECT_ROOT=$OUTPUT_ROOT/$SPEC
################################################################################
##                                                                            ##
##                                      C                                     ##
##                                                                            ##
################################################################################
REPOS=("c-poco@std-1.x" "c-codec@socket-1.x")

for repo in "${REPOS[@]}"
do
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/c/$repo

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
###                         COMMAND LINE INTERFACE (C)                         ##
###                                                                            ##
#################################################################################
#export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/c/c-lib@cmake-1.x
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
#\"naming\":\"com.doublegsoft.jcommons.programming.c.CConventions\",\
#\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.c.CNamingConvention\",\
#\"language\":\"c\",\
#\"imports\":\
#\[\],\
#\"dependencies\":\
#\[\"poco\",\"sql\"\]\
#\} 2>&1
#
#SQLITE_BUILD=$PROJECT_ROOT/3rd/sqlite-3.53.4/build/darwin
#if [[ ! -d "$SQLITE_BUILD" ]]; then
#  cd $PROJECT_ROOT/3rd/sqlite-3.53.4
#  chmod +x ./configure
#  mkdir -p "build/darwin"
#  cd build/darwin && ../../configure --enable-shared && make
#  cd ../../../..
#fi
#mkdir -p $PROJECT_ROOT/build/darwin && cd $PROJECT_ROOT/build/darwin
#/opt/homebrew/bin/cmake ../.. && make
#ctest --output-on-failure

