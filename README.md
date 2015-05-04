## Pre-req

Have node / npm installed.

Have SAUCE_USERNAME and SAUCE_ACCESS_KEY in ENV variables.

## To run

Once in root of directory (i.e. pwd is mocha-webdriverio-parallel)

```
	./run_tests.sh
```

## How it works

Put in desired browser / os configurations in configurations.yaml.

Ruby script (splitter.rb) is used to create multiple files from one test case file. A new file will be created in split_testcase_dir that has desiredCapability read from configuration.yaml.

parallel-mocha is used to run all those tests in parallel.