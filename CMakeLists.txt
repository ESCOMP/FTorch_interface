cmake_minimum_required(VERSION 3.12)
if("${USE_FTORCH}" STREQUAL "ON")
  message("Building FTorch library and wrapper ${USE_FTORCH}")
  project(FTorch_CESM_WRAPPER)
  add_subdirectory(src)
  set_source_files_properties(
    ${CMAKE_SOURCE_DIR}/FTorch_cesm_interface.F90
    PROPERTIES
    OBJECT_DEPENDS "${CMAKE_Fortran_MODULE_DIRECTORY}/ftorch.mod"
  )
  target_sources(ftorch PRIVATE ${CMAKE_SOURCE_DIR}/FTorch_cesm_interface.F90)
else()
  message("Building FTorch wrapper only ${USE_FTORCH}")
  project(FTorch_CESM_WRAPPER LANGUAGES Fortran)
  add_library(ftorch SHARED  ${CMAKE_SOURCE_DIR}/FTorch_cesm_interface.F90)
endif()
