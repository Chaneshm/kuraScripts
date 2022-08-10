#!/bin/bash

# Welcome to me being bored and just creating a game to test my skills.

# declare entity objects as a dictionary

declare -A player
declare -A weapon
declare -A goblin
declare -A orc

# Preset/Default settings
player[money]=20
player[weapon]=0
player[health]=100
player[armor]=0
shortswordCost=10
greatswordCost=100
epicCost=200
enemyType=0
crit=0

# Function made to randomize damage for each hit depending on the weapon.
damageCalc(){
    if [ ${player[weapon]} == 1 ]
    then
        weapon[damage]=$[ 5 + $RANDOM % 10 ]
    elif [ ${player[weapon]} == 2 ]
    then
        weapon[damage]=$[ 10 + $RANDOM % 15 ]
    else
        weapon[damage]=100
    fi
    if [ $[1 + $RANDOM % 20] -eq 20 ]
    then
        weapon[damage]=$(( ${weapon[damage]} * 2 ))
        crit=1
    fi
    goblin[damage]=$[ 10 + $RANDOM % 5 ]
    orc[damage]=$[ 15 + $RANDOM % 20 ]
}

# Randomize enemy stats in order to make each encounter unique
generateEnemy(){
    goblin[health]=$[ 20 + $RANDOM % 10 ]
    orc[health]=$[ 40 + $RANDOM % 20 ]
}

# Reset player HP
restore(){
    player[health]=100
}


# Generic shop menu for purchasing weapons 
shop(){
    clear
    echo "Welcome to the shop!"
    echo "What weapon would you like to purchase"
    echo "1. Shortsword 10 Gold"
    echo "2. Greatsword 100 Gold"
    echo "3. SuperCoolOmegaGreatSwordOfAwesomenessAndDeath#KillMyEnemies 200 Gold"
    echo "Press enter to exit"
    read option
    case $option in
        1) if [ ${player[money]} -ge $shortswordCost ]
                then
                    player[weapon]=1
                    read -p "GOT IT!"
                    player[money]=$(( ${player[money]} - $shortswordCost ))
            else
                echo "Not enough money! Keep fighting!"
                read -p "Press [enter] to continue"
                mainMenu
            fi
            ;;
        2) if [ ${player[money]} -ge $greatswordCost ]
                then
                    player[weapon]=2
                    read -p "GOT IT!"
                    player[money]=$(( ${player[money]} - $greatswordCost ))
            else
                echo "Not enough money! Keep fighting!"
                read -p "Press [enter] to continue"
                mainMenu
            fi
            ;;
        3) if [ ${player[money]} -ge $epicCost ]
                then
                    player[weapon]=3
                    read -p "GOT IT!"
                    player[money]=$(( ${player[money]} - $epicCost ))
            else
                echo "Not enough money! Keep fighting!"
                read -p "Press [enter] to continue"
                mainMenu
            fi
            ;;
    esac
    mainMenu
}


# Battle state
battle(){
    clear
    enemyType=0
    option=0
    if [ ${player[weapon]} == 0 ]
    then
        echo "You cannot go into battle without a weapon!"
        read -p "Go buy one!"
        mainMenu
    fi
    echo "Time for Battle!"
    generateEnemy
    echo "What monster would you like to fight?"
    echo "1. Goblin(weak)"
    echo "2. Orc(strong)"
    read option
    case $option in 
        1) enemyType=1;;
        2) enemyType=2;;
    esac
    # if goblin
    if [ $enemyType == 1 ]
    then
        while [[ ${goblin[health]} -ge 1 && ${player[health]} -ge 1 ]]
        do
            clear
            echo "Goblin Health: ${goblin[health]}"
            echo "Your Health: ${player[health]}"
            echo ""
            if [ $crit -eq 1 ]
            then
                echo "CRITICAL HIT!! Your last hit did double damage~!"
                crit=0
            fi
            echo "1. Attack"
            echo "2. Run"
            read option
            if [ $option == 1 ]
            then
                damageCalc
                goblin[health]=$(( ${goblin[health]} - ${weapon[damage]} ))
                player[health]=$(( ${player[health]} - ${goblin[damage]} ))
                
            elif [ $option == 2 ]
            then
                read -p "RUN AWAY!!!!!!"
                mainMenu
            fi

        done
        if [ ${goblin[health]} -le 0 ]
        then
            player[money]=$(( ${player[money]} + 50 ))
            read -p "YOU WON!! Heres 50 gold. Keep fighting!"
            mainMenu
        else
            echo "YOU DIED!!!!!!!!!! :c damn that sucks."
            echo "But a random traveling priest found you and revived you. LUCKY YOU"
            read -p "Wait a second... where's my money?"
            player[money]=0
            mainMenu
        fi
    fi
    # if orc
    if [ $enemyType == 2 ]
    then
        while [[ ${orc[health]} -ge 1 && ${player[health]} -ge 1 ]]
        do
            clear
            echo "Orc Health: ${orc[health]}"
            echo "Your Health: ${player[health]}"
            echo ""
            if [ $crit -eq 1 ]
            then
                echo "CRITICAL HIT!! Your last hit did double damage~!"
                crit=false
            fi
            echo "1. Attack"
            echo "2. Run"
            read option
            if [ $option == 1 ]
            then
                damageCalc
                orc[health]=$(( ${orc[health]} - ${weapon[damage]} ))
                player[health]=$(( ${player[health]} - ${orc[damage]} ))
            elif [ $option == 2 ]
            then
                read -p "RUN AWAY!!!!!!"
                mainMenu
            fi

        done
        if [ ${orc[health]} -le 0 ]
        then
            player[money]=$(( ${player[money]} + 50 ))
            read -p "YOU WON!! Heres 50 gold. Keep fighting!"
            mainMenu
        else
            echo "YOU DIED!!!!!!!!!! :c damn that sucks."
            echo "But a random traveling priest found you and revived you. LUCKY YOU"
            read -p "Wait a second... where's my money?"
            player[money]=0
            mainMenu
        fi
    fi

}

mainMenu(){
    clear
    restore
    echo "Main Menu"
    echo "Your Money: ${player[money]}"
    echo "1. Battle"
    echo "2. Shop"
    echo "3. Exit"
    read option
    if [ $option == 1 ]
    then
        battle
    elif [ $option == 2 ]
    then 
        shop
    elif [ $option == 3 ]
    then
        clear
        exit 0
    else
        read -p "ERROR: NOT AN OPTION"
        mainMenu
    fi
}
mainMenu
exit 0 