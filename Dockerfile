# Используем образ Ubuntu
FROM ubuntu:latest

# Устанавливаем необходимые системные зависимости
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    ansible \
    git \
    python3-venv  # Добавляем python3-venv для создания виртуальной среды

# Создаём виртуальное окружение для pip
RUN python3 -m venv /venv

# Активируем виртуальную среду и обновляем pip
RUN /venv/bin/pip install --upgrade pip

# Добавляем в путь для использования pip и других инструментов из виртуальной среды
ENV PATH="/venv/bin:$PATH"

# Проверяем версии установленных пакетов
RUN python --version
RUN pip --version
RUN ansible --version

# Устанавливаем необходимые Python-пакеты, если потребуется (например, для работы с Ansible)
RUN pip install --no-cache-dir \
    requests \
    boto3

# Копируем ваши файлы в контейнер
WORKDIR /ansible
COPY . /ansible

# Запуск команд по умолчанию, если контейнер запущен без указания команды
CMD ["/bin/bash"]
