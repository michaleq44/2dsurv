#include <main.hpp>

App2Dsurv app;

int main() {
    debug("debug mode");

    try {
        app.run({800, 600}, "2DSURV");
    } catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
