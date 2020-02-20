# Vein Framework
Framework for data processing and transport

Based on Qt framework

## Logging options
```C++

QStringList loggingFilters = QStringList() << QString("*.debug=false"); // ... << QString("*.warning=false") ...
QLoggingCategory::setFilterRules(loggingFilters.join("\n"));

```

# Superbuild Information

This Superbuild combines libs, plugins and services in one metaproject

**SubProjects**

* vf-helpers
* vf-tcp
* xiqnet
* vf-crypto-bridge
* vf-event
* vf-storage-hash
* vf-net2
* vf-protobuf
* vf-qml
* vf-script
* vf-logger
* vf-database-recorder
* vf-database-replay
* vf-debugger
* vf-unittest2
* vf-declarative-gui
* zera-setup2



## clone Project

in your terminal:

```
git clone <repo> 
cd /<path>/<to>/<repo>
git submodule update --init --recursive
git submodule update --remote
```


## Setup Project
Following folders must be set:

* CMAKE_PREFIX_PATH=/usr
* CMAKE_INSTALL_PREFIX=/usr
* CMAKE_INSTALL_SYSCONFDIR=/etc

CMAKE_PREFIX_PATH has to be equal to /usr;${CMAKE_INSTALL_PREFIX}.
It is recommendet to set the variables not to the hosts systemroot.

For example use:

CMAKE_PREFIX_PATH=/usr;/${some}/${folder}/usr
CMAKE_INSTALL_PREFIX=/${some}/${folder}/usr
CMAKE_INSTALL_SYSCONFDIR=/${some}/${folder}/etc

### in Terminal 

To setup the Project in your terminal go to your desired build location and call:

```
cmake -DCMAKE_PREFIX_PATH="/usr;${install_dir}" -DCMAKE_INSTALL_PREFIX="${install_dir}"  
-DCMAKE_INSTALL_SYSCONFDIR="${config_dir}" -S /<path>/<to>/<repo> 
```

To build the project call 

```
make -j8
```
in your build directory.


### in qt Creator

* Go to open project and choose the toplevel CMakeLists.txt
* Configure project
* Go to Projects
* Delete all build steps 
* add Custom process step 
* Add the required cmake variables and set them as described above
* Run CMake 
* Build 
* set firstBuild OFF
* Run CMake

Now the project behaves like a normal project.

## Add Subproject to SuperBuild

### Add to git 
To add a subproject first add it in git with following command:

```
git submodule add -b <branch> git@github.com:ZeraGmbH/<project> <path>/<project>
```

for example:


```
git submodule add -b master git@github.com:ZeraGmbH/vf-declarative-gui.git guis/vf-declarative-gui
```

check if the submodule appears in .gitmodules.


### Add to cmake


To add the project to cmake open CMakeLists.txt and add following lines:

```
set(name <project>)
set(path <path>)
set(deps <dep1> <dep2> <dep3>)
add_sub_project_deps(${name} ${path} "deps")
```


Please note that the project order is important. The project must be added after all projects it depends on. 
The dependencies will determine the build order during make. 

## issues

* 1 
If one of these steps is executed wrong it might happen that the build will not work. 
In this case delete the build folder. In case you are using qt creator remove CMakeLists.tyt.user and import the project again. 
Then repeat the setup steps.




