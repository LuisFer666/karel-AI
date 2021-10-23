# Karel-AI
![version](https://img.shields.io/badge/version-v0.25-lightgrey)
![license](https://img.shields.io/badge/license-GNU%20GPL%20v3-blue) <br>
[![LinkedIn](https://img.shields.io/badge/-LinkedIn-black.svg?style=social&logo=linkedin&colorB=555)](https://www.linkedin.com/in/luis-fernando-rojas-gonz%C3%A1lez-792a431a3/) <br>

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

This is the UML class diagram

<img src="https://github.com/LuisFer666/karel-IA/blob/main/Clases.png" title="Clases.png" />


