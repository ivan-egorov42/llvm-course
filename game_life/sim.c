#include "sim.h"
#include <SFML/Graphics.hpp>
#include <cstdlib>

std::vector<sf::Vertex> grid;
sf::RenderWindow window(sf::VideoMode(800, 600), "Game life!");

void simInit() {
  grid.clear();
  grid.resize(800 * 600);

  window.setFramerateLimit(60);
}

void simSetPixels(unsigned *nextGen) {
  unsigned pos = 0;
    for (unsigned y = 0; y < SIM_Y_SIZE; ++y) {
        for (unsigned x = 0; x < SIM_X_SIZE; ++x) {
            grid[pos].position =
                sf::Vector2f(static_cast<float>(x), static_cast<float>(y));

            if (nextGen[y * SIM_X_SIZE + x])
              grid[pos++].color = sf::Color::Green;
            else
              grid[pos++].color = sf::Color::Black;
        }
    }
}

void simFlush() {
  sf::Event event;

  while (window.pollEvent(event)) {
    if (event.type == sf::Event::Closed)
      window.close();
  }

  window.clear();
  window.draw(&grid[0], grid.size(), sf::Points);
  window.display();
}

unsigned simRand() {
  return rand();
}