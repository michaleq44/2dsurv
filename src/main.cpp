#include <main.hpp>

App2Dsurv app;

constexpr int FRAMES_IN_FLIGHT = 2;

int main() {
    debug("debug mode");

    try {
        app.run({800, 600}, "2DSURV", FRAMES_IN_FLIGHT);
    } catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
