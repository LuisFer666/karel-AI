# Karel-AI
![version](https://img.shields.io/badge/version-v0.25-lightgrey)
![license](https://img.shields.io/badge/license-GNU%20GPL%20v3-blue) <br>
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/luis-fernando-rojas-gonz%C3%A1lez-792a431a3/)<br>

Karel-AI is an Artificial Intelligence created in Processing. This program is inspired on the educational programming language Karel

This is an evolutionary algorithm. While is running it will calculate how much efficiency have each DNA strings in all maps. Each Karel instance will search for a beeper and when he pick up in his bag he will stop, wait until the other instances take a beeper or until all runs exactly 200 loops. Then the efficiency will be calculated and the genetic process will start

<img src="https://github.com/LuisFer666/karel-IA/blob/main/Screenshot.png" title="Screenshot.png" />

## Description

The efficiency depends of how many errors and how many steps Karel did for getting a beeper.
* More errors means less efficiency.
* Less steps means more efficiency

The Artificial Intelligence will follow the next steps

1. Each training cycle will take max. 200 loops trying to take a beeper and calculate the Efficiency of each DNA string
1. The AI will take the higher efficiency DNA strings and will prepare to reproduce them
1. The AI will take more or less part of the DNA strings (Randomly)
1. The AI will take these parts to create two new DNA strings (Mixing the DNA string of the parents). This will continue in pairs for others DNA strings
1. The AI will select only one instruction of the DNA (Randomly). Then this instruction will be mutated to another instruction of the instructions posible

Each complete iteration of AI <From 1. to 5.> should improve efficiency and achieve better DNA. Let the AI keep training for as long as you like. The more you train, the better results you will have.

Below you can see a diagram that explains the algorithm obtained from the book (Russell & Norvin, 2004, Page 132) 

<img src="https://github.com/LuisFer666/karel-IA/blob/main/Genetic-Algorithm.png" title="Genetic-Algorithm.png"/> 
Reference: Russell S., Norvig P. 2004. Inteligencia Artificial: Un Enfoque Moderno 2° Ed. Pearson Prentice Hall. Madrid

## Installation

1. Download and Install <a href="https://processing.org/download">Processing 3.x</a> stable release
2. Download and Install <a href="https://www.oracle.com/technetwork/es/java/javase/downloads/index.htm">Java SE 8.x</a>
3. Download the last version of Karel-AI <a href="https://github.com/LuisFer666/karel-AI/archive/refs/heads/main.zip">Click here</a> or...

If you have git command line installed in your PC you can use
```bash
git clone https://github.com/LuisFer666/karel-AI.git
```

If you have GitHub command line installed in your PC you can use
```bash
gh repo clone LuisFer666/karel-AI
```

4. Open "KarelRobot" directory and open "KarelRobot.pde" file using Processing program installed
5. Click on the "play" button of the Processing Graphic User Interface (GUI) and you will see the GUI of Karel-AI
6. ¡Now you can use Karel-AI!

## Usage

1. Click on the "play" button of the Karel-AI GUI and look how all Karel instances try to find a beeper using random moves
2. Maybe zero or more instances take a beeper. It will be better with more time of training. You need to wait untill all Karel instances take a beeper or all reach 200 cycles
3. Look at the boxes under the maps, the best DNA strings will appeare. If there is not at least one, the first DNA strings will be taken. This four DNA strings will be improve using the genetic algorithm explained previously and will take the first four places. The four places remaining will be filled with random DNA strings and all the eight DNA strings will try to be the best for reproduce next time
4. Three seconds after the initial population based on best efficiency, the next four boxes will be filled with a random selection.
5. Three seconds later a DNA strand will appear based on the section of its two corresponding parents
6. Three seconds later, the last four boxes will show the character to be mutated.
7. After this the training will continue and begin an infinite cycle of constant improvement 

Enjoy using Karel-AI. Remember, you can play, pause and reload the training process at any time

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.


