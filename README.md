# Dune Super Build

This is just an experiment with dune core modules built in a CMake super build.

```bash
# fetch repository
git clone https://github.com/SoilRos/dune-super-build.git
# configure super build
cmake -DCMAKE_BUILD_TYPE=Release -S dune-super-build -B dune-super-build/build
# build binaries
cd dune-super-build/build
cmake --build . --config Release
# run tests
ctest --output-on-failure -C Release
```

## Testing a branch with GitHub Actions:

### Manually running action

* Login into github and goto https://github.com/SoilRos/dune-super-build.
* Open the 'Actions' tab and on the left choose 'testing scenarios'.
* On the right click 'Run workflow' which opens a window with some fields to fill out. Select the corresponding branch in core modules. This will checkout the requested branch if it exsists, otherwise it will fallback to master.
* Click the 'Run workflow' button to start the process.

Note: if you can not see a 'Run workflow' button then you need to be added to the 'dune-project' group. Please ask somebody to do that.
