#!/bin/bash

COMMAND=$1

case "$COMMAND" in 
    build_generator)
        echo "Сборка образа генератора"
        docker build -t data_generator ./generator
        ;;

    run_generator)
        echo "Запуск генератора данных"
        mkdir -p data
        docker run --rm -v "$(pwd)/data:/data" data_generator
        ;;

    create_local_data)
        echo "Локальная генерация"
        mkdir -p local_data
        python3 ./generator/generate.py "$(pwd)/local_data"
        ;;

    build_reporter)
        echo "Сборка аналитики"
        docker build -t data_reporter ./reporter
        ;;

    run_reporter)
        echo "Запуск аналитики"
        mkdir -p data
        docker run --rm -v "$(pwd)/data:/data" data_reporter
        ;;

    structure)
        echo "Структура проекта"
        if command -v tree &> /dev/null; then
            tree .
        else
            find . -not -path '*/.*' -not -path './reporter/node_modules*'
        fi 
        ;;

    clear_data)
        echo "Очистка данных"
        rm -f data/*.csv data/*html
        echo "Папка data очищена"
        ;;
    
    inside_generator)
        echo "Просмотр папки data из генератора"
        docker run --rm -v "$(pwd)/data:/data" data_generator ls -la /data
        ;;

    inside_reporter)
        echo "Просмотр папки data из аналитики"
        docker run --rm -v "$(pwd)/data:/data" data_reporter ls -la /data
        ;;
    *)

    echo "Неизвестная команда"
    echo "Введите ./run.sh {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
    exit 1
    ;;

esac