#!/bin/bash

project=`basename $PWD`
package=`make var-PACKAGE`

boilerplatePackage="github.com/sagikazarmark/modern-go-application"

rep() {
    sed -E -e $1 $2 > $2.new
    mv -f $2.new $2
}

mv .idea/project.iml .idea/${project}.iml
rep "s|.idea/project.iml|.idea/${project}.iml|g" .idea/modules.xml

# Run configurations
rep "s|name=\"project\"|name=\"${project}\"|" .idea/runConfigurations/All_tests.xml
rep "s|name=\"project\"|name=\"${project}\"|" .idea/runConfigurations/Debug.xml
rep "s|name=\"project\"|name=\"${project}\"|" .idea/runConfigurations/Integration_tests.xml
rep "s|name=\"project\"|name=\"${project}\"|" .idea/runConfigurations/Tests.xml

# Other project files
rep "s|${boilerplatePackage}|${package}|" .circleci/config.yml
rep "s|${boilerplatePackage}|${package}|" .gitlab-ci.yml
rep "s|${boilerplatePackage}|${package}|" cmd/config.go
rep "s|${boilerplatePackage}|${package}|" cmd/main.go
rep "s|${boilerplatePackage}|${package}|" CHANGELOG.md
rep "s|${boilerplatePackage}|${package}|" Dockerfile

# Example code
find internal/greeting -type f | while read file; do rep "s|${boilerplatePackage}|${package}|" "$file"; done
