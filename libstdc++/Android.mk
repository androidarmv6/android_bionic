LOCAL_PATH:= $(call my-dir)

# Common C++ flags to build this library.
# Note that we need to access private Bionic headers
# and define ANDROID_SMP accordingly.
libstdc++_cflags := -Ibionic/libc/
ifeq ($(TARGET_CPU_SMP),true)
    libstdc++_cflags += -DANDROID_SMP=1
else
    libstdc++_cflags += -DANDROID_SMP=0
endif

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	src/new.cpp \
	src/pure_virtual.cpp \
	src/typeinfo.cpp

LOCAL_MODULE:= libstdc++
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_CFLAGS := $(libstdc++_cflags)

ifeq ($(TARGET_ARCH_VARIANT),armv6-vfp)
	LOCAL_SRC_FILES+= \
		src/one_time_construction.cpp.arm
else
	LOCAL_SRC_FILES+= \
		src/one_time_construction.cpp
endif

LOCAL_SYSTEM_SHARED_LIBRARIES := libc

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	src/new.cpp \
	src/pure_virtual.cpp \
	src/typeinfo.cpp

ifeq ($(TARGET_ARCH_VARIANT),armv6-vfp)
	LOCAL_SRC_FILES+= \
		src/one_time_construction.cpp.arm
else
	LOCAL_SRC_FILES+= \
		src/one_time_construction.cpp
endif

LOCAL_CFLAGS := $(libstdc++_cflags)

LOCAL_MODULE:= libstdc++
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_SYSTEM_SHARED_LIBRARIES := libc

include $(BUILD_STATIC_LIBRARY)
