# cleanup
rm -rf split_testcase_dir

ruby splitter.rb configurations.yaml ./tests split_testcase_dir

# install npm packages
npm install mocha chai parallel-mocha webdriverio

# run tests.
node_modules/parallel-mocha/bin/parallel-mocha -p 10 split_testcase_dir/*.js