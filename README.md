# Elixir Billion Row Challenge

The goal of this project is to tackle the challenge of processing extremely large datasets with Elixir, leveraging its concurrency and functional programming capabilities. This repository provides a practical example of how to manage and manipulate a billion rows of data efficiently.

## The Challenge
The Billion Row Challenge is a simple task that involves processing a large dataset. The dataset consists of a billion rows, each containing a city and a measurement of the weather temperature. The goal is to calculate the average temperature for each city.

# Dependencies
This project requires Elixir to be installed on your machine. You can find the installation instructions [here](https://elixir-lang.org/install.html).

# Installation

```bash
git clone https://github.com/Citizen-Thayne/elixir-billion-row-challenge.git
mix deps.get
```

# Running the project
Benchmarks built with Benchee are available as a mix task

**Generating the dataset**
```bash
mix benchmark generator
```

**Calculating the average temperature for each city**
```bash
mix benchmark average
```

# TODO
1. Collect series of benchmark results
2. Render benchmark results
