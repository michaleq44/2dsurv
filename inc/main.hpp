#ifndef MAIN_HPP
#define MAIN_HPP
#define GLFW_INCLUDE_VULKAN

#include <GLFW/glfw3.h>

#define GLM_FORCE_RADIANS
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#include <glm/glm.hpp>

#include <iostream>
#include <stdexcept>
#include <cstdlib>
#include <vector>
#include <map>
#include <optional>
#include <set>
#include <cstdint>
#include <limits>
#include <algorithm>
#include <fstream>
#include <array>
#include <chrono>

#include <app.hpp>
#include <vlk.hpp>
#include <appprivate.hpp>

#ifdef NDEBUG
#define debug(str)
#define debugnb(str)
#define debugex(str)
#else
#define debug(str) std::cerr << (str) << std::endl
#define debugnb(str) std::cerr << (str)
#define debugex(str) << (str)
#endif

#ifdef NDEBUG
#define DEBUG false
#else
#define DEBUG true
#endif

#endif