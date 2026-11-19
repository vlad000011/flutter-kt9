# Elementary Tasks App

Учебное Flutter-приложение «Мои задачи», демонстрирующее Clean Architecture и MVVM с библиотекой Elementary.

## Функциональность

- просмотр списка задач;
- добавление задачи;
- отметка выполнения;
- удаление задачи;
- отображение количества невыполненных задач;
- локальное сохранение списка между запусками.

## Архитектура

В проекте разделены слои:

- **Presentation** — `TasksWidget` (View), `TasksWidgetModel` (ViewModel) и `TasksModel` (ElementaryModel).
- **Domain** — сущность `Task`, контракт `TasksRepository` и отдельные Use Cases.
- **Data** — реализация репозитория и источник локальных данных на `SharedPreferences`.

Поток данных:

`TasksWidget → TasksWidgetModel → TasksModel → Use Case → TasksRepository → LocalDataSource`

Виджет не обращается к хранилищу и не содержит бизнес-логики. `WidgetModel` управляет состоянием экрана и вызывает методы `ElementaryModel`. Domain не зависит от Flutter и конкретного способа хранения данных.

## Запуск на macOS

Требуется установленный Flutter SDK.

```bash
flutter doctor
```

Перейдите в каталог проекта:

```bash
cd elementary_tasks_app
```

Сгенерируйте платформенные файлы:

```bash
flutter create --project-name elementary_tasks_app .
```

Установите зависимости:

```bash
flutter pub get
```

Запустите приложение:

```bash
flutter run
```

## Проверка

1. Добавьте несколько задач.
2. Отметьте одну задачу выполненной — счётчик оставшихся задач изменится.
3. Удалите задачу.
4. Полностью закройте и снова откройте приложение — список должен сохраниться.

## Публикация на GitHub

Создайте пустой репозиторий `elementary_tasks_app` на GitHub, затем в папке проекта выполните:

```bash
git init
git add .
git commit -m "Initial commit: Elementary MVVM clean architecture"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/elementary_tasks_app.git
git push -u origin main
```

Замените `YOUR_USERNAME` на свой логин GitHub.

## Основные зависимости

- `elementary` — реализация MVVM для Flutter;
- `shared_preferences` — локальное сохранение;
- `uuid` — генерация уникальных идентификаторов задач.
