# CS2D
Counter Strike inspired 2D game in Godot

![Scrrenshot](https://media.discordapp.net/attachments/361593010862948362/420097225172058122/unknown.png)

## Getting Started

The project uses 2 scenes to handle lobby and 1 singleton to manage multiplayer throughout

### Testing

#### Configuring Server
To test currently, 
Run the project and Enter Player Name and Create Server, 
Note the IPs listed bellow in lobby

#### Configuring Client
Run it again in same Computer or another connected to same network
Enter player name Enter the correct IP from ones listed in server lobby 
Generally 127.0.0.1 if in same computer or the second IP in server IP list if on same network
Match the port (default is fine)
Create client

#### Starting Game
Once all players are listed in Server's lobby Server can start the game,

Game will end when only one player is left
Server can only [re]start the game
