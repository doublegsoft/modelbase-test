export MODELBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/modelbase/03.Development/modelbase-data
export MODELBASE_JAR=/Users/christian/export/opt/modelbase/protosys-plugin-modelbase-6.0-shaded.jar
export PROJBASE_DATA_ROOT=/Users/christian/export/local/works/doublegsoft.io/projbase/03.Development/projbase-data
export PROJBASE_JAR=/Users/christian/export/opt/projbase/protosys-plugin-projbase-4.5-shaded.jar

export OUTPUT_ROOT=out/rust

export SPEC=meta_
export APPNAME=meta
export NAMESPACE=app
export MOBELBASE_MODEL=spec/$SPEC.modelbase
export PROJECT_ROOT=$OUTPUT_ROOT/$SPEC
################################################################################
##                                                                            ##
##                                    RUST                                    ##
##                                                                            ##
################################################################################
REPOS=("rust-poco@std-1.x" "rust-sql@std-1.x")

for repo in "${REPOS[@]}"
do
export TEMPLATE_ROOT=$MODELBASE_DATA_ROOT/rust/$repo

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
\"naming\":\"com.doublegsoft.jcommons.programming.rust.RustConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.rust.RustNamingConvention\",\
\"language\":\"rust\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\]\
\} 2>&1
done

################################################################################
##                                                                            ##
##                        COMMAND LINE INTERFACE (RUST)                       ##
##                                                                            ##
################################################################################
export TEMPLATE_ROOT=$PROJBASE_DATA_ROOT/rust/rust-lib@std-1.x

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
\"naming\":\"com.doublegsoft.jcommons.programming.rust.RustConventions\",\
\"globalNamingConvention\":\"com.doublegsoft.jcommons.programming.rust.RustNamingConvention\",\
\"language\":\"rust\",\
\"imports\":\
\[\],\
\"dependencies\":\
\[\"poco\",\"sql\"\]\
\} 2>&1


