#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    GET_DATA=$($PSQL "SELECT * FROM elements el LEFT JOIN properties prop USING(atomic_number) LEFT JOIN types ty USING(type_id) WHERE symbol='$1' OR name='$1'")
  else
    GET_DATA=$($PSQL "SELECT * FROM elements el LEFT JOIN properties prop USING(atomic_number) LEFT JOIN types ty USING(type_id) WHERE atomic_number='$1'")
  fi

  if [[ -z $GET_DATA ]]
  then
    echo -e "I could not find that element in the database."
  else

    echo "$GET_DATA" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
    do
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
    
  fi
fi

# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.