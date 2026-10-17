# Re-enable shared library support (intended for Cray systems where CIME sets CMAKE_SYSTEM_NAME=Catamount, triggering make files that disable shared libs)
# Enable shared libs so we can link in C++ libtorch.so.
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS TRUE)
set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".so" ".a")
set(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-Wl,-soname,")
set(CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG "-Wl,-soname,")
set(CMAKE_SHARED_LIBRARY_SONAME_Fortran_FLAG "-Wl,-soname,")
