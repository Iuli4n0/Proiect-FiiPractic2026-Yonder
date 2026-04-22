#!/bin/bash

DB="bank.csv"

if [ ! -f "$DB" ]; then
    echo "Client, Sold curent" > "$DB"
fi

while true; do
    echo -e "\n--- MENIU BANCAR ---"
    echo "1.adauga client"
    echo "2.depunere/retragere"
    echo "3.sterge client"
    echo "4.listeaza clientii"
    echo "5.exit"
    read -p "alege una dintre optiuni: " opt

    case $opt in
        1)
            read -p "Nume client: " nume
            if grep -qi "^$nume," "$DB"; then
                echo "Err:clientul exista deja!"
            else
                echo "$nume, 0">>"$DB"
                echo "Client adaugat!"
            fi
            ;;
        2)
            read -p "Nume client: " nume
            if grep -qi "^$nume," "$DB"; then
                read -p "Introdu suma pe care o retragi sau o depui (ex: -60 sau 800): " suma
                
                sold_vechi=$(grep -i "^$nume," "$DB" | cut -d ',' -f2)
                sold_nou=$(echo "$sold_vechi+$suma" | bc)
                
                grep -vi "^$nume," "$DB">tmp.csv
                echo "$nume,$sold_nou">>tmp.csv
                mv tmp.csv "$DB"
                
                echo "Noul tau sold este: $sold_nou"
            else
                echo "Err: Clientul nu exista!"
            fi
            ;;
        3)
            read -p "Nume clientului care urmeaza a fi sters: " nume
            if grep -qi "^$nume," "$DB_FILE"; then
                grep -vi "^$nume," "$DB_FILE" > tmp.csv
                mv tmp.csv "$DB_FILE"
                echo "Clientul $nume a fost sters."
            else
                echo "Err: Clientul nu exista!"
            fi
            ;;
        4)
            echo -e "\n---LISTA CLIENTI---"
            column -s, -t "$DB"
            ;;
        5)
            echo "Exit..."
            exit 0
            ;;
        *)
            echo "Alege o optiune valida!!"
            ;;
    esac
done
