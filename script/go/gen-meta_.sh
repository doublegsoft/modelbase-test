export MODELBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/modelbase/03.Development/modelbase-data
export MODELBASE_JAR=/Users/christian/export/opt/modelbase/protosys-plugin-modelbase-7.0-shaded.jar
export PROJBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/projbase/03.Development/projbase-data
export PROJBASE_JAR=/Users/christian/export/opt/projbase/protosys-plugin-projbase-7.0-shaded.jar

export OUTPUT_ROOT=out/go

export SPEC=meta_
export APPNAME=meta
export NAMESPACE=app
export MOBELBASE_MODEL=spec/$SPEC.modelbase
export PROJECT_ROOT=$OUTPUT_ROOT/$SPEC
################################################################################
##                                                                            ##
##                                     GO                                     ##
##                                                                            ##
################################################################################
REPOS=("go-poco@std-1.x")

for repo in "${REPOS[@]}"
do
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/go/$repo

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
\"naming\":\"com.doublegsoft.jcommons.programming.go.GoConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.go.GoNamingConvention\",\
\"language\":\"go\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1
done

################################################################################
##                                                                            ##
##                         COMMAND LINE INTERFACE (GO)                        ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/go/go-lib@std-1.x

java -jar $PROJBASE_JAR \
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
\"naming\":\"com.doublegsoft.jcommons.programming.go.GoConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.go.GoNamingConvention\",\
\"language\":\"go\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\"poco\",\"sql\"\]\
\} 2>&1


cd $PROJECT_ROOT
go test ./...
