set(OBJ
               ${COMPONENT_DIR}/.objs/b__interrupt.o
               ${COMPONENT_DIR}/.objs/esp32-gpio.o
               ${COMPONENT_DIR}/.objs/esp32.o
               ${COMPONENT_DIR}/.objs/handlers.o
               ${COMPONENT_DIR}/.objs/interrupt.o)

if(NOT CMAKE_BUILD_EARLY_EXPANSION)
  # Compile Ada file and run binder
  add_custom_command(OUTPUT ${OBJ}
     COMMAND gprbuild -b -c -p -P ${COMPONENT_DIR}/interrupt.gpr
               --RTS=${BUILD_DIR}/rts
     DEPENDS interrupt.gpr interrupt.adb handlers.ads handlers.adb
     VERBATIM)
endif()

idf_component_register(SRCS ".objs/b__interrupt.o"
                            ".objs/interrupt.o"
                            ".objs/handlers.o"
                            ".objs/esp32-gpio.o"
                            ".objs/esp32.o"
                    INCLUDE_DIRS "."
                    REQUIRES esp32-gnat-rts)

# Required for s-fretcb.ads
idf_build_set_property(COMPILE_DEFINITIONS -DconfigUSE_APPLICATION_TASK_TAG=1 APPEND)
# Required for xTaskCreate in s-fretas.adb
idf_build_set_property(COMPILE_DEFINITIONS -DconfigSUPPORT_DYNAMIC_ALLOCATION=1 APPEND)

