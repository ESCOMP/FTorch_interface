cmake_minimum_required(VERSION 3.12)
project(FTorch_CESM_WRAPPER LANGUAGES Fortran CXX)
enable_language(Fortran)
# Force use of Fortran compiler for linking
set(CMAKE_Fortran_LINK_EXECUTABLE
    "${CMAKE_Fortran_COMPILER} <FLAGS> <CMAKE_Fortran_LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)

if("${USE_FTORCH}" STREQUAL "ON")
  message("Building FTorch library and wrapper ${USE_FTORCH} ${CMAKE_BINARY_DIR}")
  add_subdirectory(src)
  add_library(ftorch_wrapper SHARED  FTorch_cesm_interface.F90)
  target_link_libraries(ftorch_wrapper PRIVATE ftorch)
  set_target_properties(ftorch PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/external/ftorch
  )
  # The cpp file in this library will cause cmake to prefer the cxx compiler for the link step, we override and use fc
  set_target_properties(ftorch PROPERTIES
    LINKER_LANGUAGE Fortran  
  )
 
else()
  message("Building FTorch wrapper only ${USE_FTORCH}")
  add_library(ftorch_wrapper SHARED  FTorch_cesm_interface.F90)
endif()

# Expose that module directory to anything that links against ftorch
target_include_directories(ftorch
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/external/ftorch>
)

