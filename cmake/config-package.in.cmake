cmake_minimum_required(VERSION 2.6)
include("${CMAKE_CURRENT_LIST_DIR}/@targets_file_name@")

# include the old FindSFML.cmake to be backward compatible
# it will also populate SFML_<comp>_DEPENDENCIES
# FindSFML.cmake will only be included, if sfml is installed. Otherwise the file can not be found (which should be not problematically)
if(NOT SFML_ROOT)
    # find SFML_ROOT so FindSFML.cmake can work properly
    find_path(SFML_ROOT include/SFML/Config.hpp
              PATHS "${CMAKE_CURRENT_LIST_DIR}/.."
                    "${CMAKE_CURRENT_LIST_DIR}/../..")
endif(NOT SFML_ROOT)
include("${CMAKE_CURRENT_LIST_DIR}/Modules/FindSFML.cmake" OPTIONAL)

# sfml's dependencies are added privately to all sfml targets, but they might be needed, when use static linking
# so add dependencies
if(SFML_STATIC_LIBRARIES)
    set_property(TARGET sfml::sfml-audio PROPERTY IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG APPEND ${SFML_AUDIO_DEPENDENCIES})
    set_property(TARGET sfml::sfml-window PROPERTY IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG APPEND ${SFML_WINDOW_DEPENDENCIES})
    set_property(TARGET sfml::sfml-graphics PROPERTY IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG APPEND ${SFML_GRAPHICS_DEPENDENCIES})
    set_property(TARGET sfml::sfml-system PROPERTY IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG APPEND ${SFML_SYSTEM_DEPENDENCIES})
    set_property(TARGET sfml::sfml-network PROPERTY IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG APPEND ${SFML_NETWORK_DEPENDENCIES})
endif(SFML_STATIC_LIBRARIES)