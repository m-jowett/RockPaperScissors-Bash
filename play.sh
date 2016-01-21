#!/usr/bin/env bash

# RockPaperScissors-Bash
# https://github.com/m-jowett/RockPaperScissors-Bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

playerScore=0 # Used to store the player's total score
cpuScore=0 # Used to store the CPU's total score

rounds=-1 # Number of rounds to be played

playerChosen=-1 # Player's choice of r/p/s
cpuChosen=-1 # Computer's choice of r/p/s

currentRound=-1 # The number of current round playing

cpuWin=0  # 0/1 computer round win/loss
playerWin=0 # 0/1 player round win/loss

playerdisplayChosen=-1
cpudisplayChosen=-1

re='^[0-9]+$'

echo -e "Rock, Paper, Scissors!\n"

while true; do
  echo -n "How many rounds do you want to play: "
  read -r rounds
  if ! [[ $rounds =~ $re ]] ; then
     echo "That is not a valid number of rounds!"
     echo -e "Please try again.\n"
  elif [ $rounds -lt 0 ]; then
    echo "You must chose at least 1 round!"
  else
    echo -e "$rounds rounds it is then, lets play!\n"
    break
  fi
done

re='^[rps]+$'
currentRound=1

while [ $rounds -gt 0 ]; do
  echo "Round: $currentRound"
  cpuChosen=$(shuf -i 1-3 -n 1)
  [ "$cpuChosen" == "1" ] && cpuChosen="r"
  [ "$cpuChosen" == "2" ] && cpuChosen="p"
  [ "$cpuChosen" == "3" ] && cpuChosen="s"
  echo -n "Rock, Paper or Scissors (r/p/s): "
  read -r playerChosen
  if ! [[ "$playerChosen" =~ $re ]] || [ "${#playerChosen}" != "1" ]; then
     echo "That is not a valid move!"
     echo -e "Please chose again.\n"
  else

    [ "$playerChosen" == "r" ] && playerdisplayChosen="Rock"
    [ "$playerChosen" == "p" ] && playerdisplayChosen="Paper"
    [ "$playerChosen" == "s" ] && playerdisplayChosen="Scissors"

    [ "$cpuChosen" == "r" ] && cpudisplayChosen="Rock"
    [ "$cpuChosen" == "p" ] && cpudisplayChosen="Paper"
    [ "$cpuChosen" == "s" ] && cpudisplayChosen="Scissors"

    echo "You chose $playerdisplayChosen !"
    echo "CPU chose $cpudisplayChosen !"
    echo -e "\n"

    cpuWin=0
    playerWin=0

    if [ "$playerChosen" == "r" ]; then
      #[ "$cpuChosen" == "r" ] &&
      [ "$cpuChosen" == "p" ] && cpuWin=1
      [ "$cpuChosen" == "s" ] && playerWin=1
    fi

    if [ "$playerChosen" == "p" ]; then
      [ "$cpuChosen" == "r" ] && cpuWin=1
      #[ "$cpuChosen" == "p" ]
      [ "$cpuChosen" == "s" ] && playerWin=1
    fi

    if [ "$playerChosen" == "s" ]; then
      [ "$cpuChosen" == "r" ] && cpuWin=1
      [ "$cpuChosen" == "p" ] && playerWin=1
      #[ "$cpuChosen" == "s" ] && playerWin=1
    fi

    if [ "$cpuWin" == "0" ] && [ "$playerWin" == "0" ]; then
      echo "It's a draw!"
    elif [ "$playerWin" == 1 ]; then
      echo "You win!"
      ((playerScore++))
    elif [ "$cpuWin" == 1 ]; then
      echo "Computer wins :("
      ((cpuScore++))
    fi

    echo -e "\n"
    ((rounds--))
    ((currentRound++))
  fi
done

echo "That's the game!"
echo "Player scored $playerScore"
echo "Computer scored $cpuScore"
echo -e "\n"

if [ $cpuScore -gt $playerScore ]; then
  echo "You lose!"
elif [ $playerScore -gt $cpuScore ]; then
  echo "You win :)"
elif [ $cpuScore -eq $playerScore ]; then
  echo "The game is a draw!"
fi

echo -e "\n"
echo "Thanks for playing!"

exit
