# Try to find Lua library
find_library(LUA_LIBRARY
    NAMES liblua_static lua_static liblua_static.a lua_static.a liblua.a
    PATHS /usr/local/lib
)

# Try to find Lua headers
find_path(LUA_INCLUDE_DIR lua.h
    PATH_SUFFIXES include
    PATHS /usr/local/include
)

# Check if Lua is found
if (LUA_LIBRARY AND LUA_INCLUDE_DIR)
    set(LUA_FOUND TRUE)
else()
    set(LUA_FOUND FALSE)
endif()

# Provide information to users
if (LUA_FOUND)
    message(STATUS "Found Lua: ${LUA_LIBRARY}")
else()
    message(FATAL_ERROR "Lua not found. Please specify the correct path.")
endif()

# Set the variables for external projects
set(LUA_INCLUDE_DIRS ${LUA_INCLUDE_DIR})
set(LUA_LIBRARIES ${LUA_LIBRARY})

# Export targets (if needed)
if (TARGET lua)
    # The target already exists, no need to create it again
    message(STATUS "Lua target already exists.")
else()
    # Create an imported target for Lua
    add_library(lua STATIC IMPORTED GLOBAL)
    set_target_properties(lua PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${LUA_INCLUDE_DIR}"
        IMPORTED_LOCATION "${LUA_LIBRARY}"
    )
endif()
