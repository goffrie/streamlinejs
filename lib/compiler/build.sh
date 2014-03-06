pushd `dirname $0` > /dev/null
../../bin/_node -lp -v -f -c builtins._js flows._js
mv builtins.js ../callbacks
mv flows.js ../callbacks

../../bin/_node -lp -v -f -c compile._js
< compile.js    sed -e "s/\/\/\/ \!doc//" > ../callbacks/compile.js
rm compile.js

../../bin/_node -lp -v -f --fibers -c builtins._js flows._js
< builtins.js   sed -e "s/\/\/\/ \!doc//" > ../fibers/builtins.js
< flows.js      sed -e "s/\/\/\/ \!doc//" > ../fibers/flows.js
rm builtins.js flows.js

../../bin/_node -lp -v -f --fibers --fast -c builtins._js flows._js
< builtins.js   sed -e "s/\/\/\/ \!doc//" > ../fibers-fast/builtins.js
< flows.js      sed -e "s/\/\/\/ \!doc//" > ../fibers-fast/flows.js
rm builtins.js flows.js

../../bin/_node -lp -v -f --generators -c builtins._js flows._js
< builtins.js   sed -e "s/\/\/\/ \!doc//" > ../generators/builtins.js
< flows.js      sed -e "s/\/\/\/ \!doc//" > ../generators/flows.js
rm builtins.js flows.js

../../bin/_node -lp -v -f --generators --fast -c builtins._js flows._js
< builtins.js   sed -e "s/\/\/\/ \!doc//" > ../generators-fast/builtins.js
< flows.js      sed -e "s/\/\/\/ \!doc//" > ../generators-fast/flows.js
rm builtins.js flows.js

../../bin/_node -lp -v -f -c ../streams/client/streams._js

# compile test files for client too (standalone, except flows-test)
pushd ../../test/common > /dev/null
../../bin/_node -lp -v -f --standalone -o callbacks/ -c eval-test._js stack-test._js futures-test._js
../../bin/_node -lp -v -f -o callbacks/ -c flows-test._js
../../bin/_node --generators -v -f -o generators/ -c .
popd > /dev/null
popd > /dev/null
