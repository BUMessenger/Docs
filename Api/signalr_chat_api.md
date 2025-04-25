# SignalR API для чата 

- **Хаб**: `ChatHub` (доступ по URL `/hubs/chat`)
- **Транспорт**: WebSocket (основной), SSE/Long Polling (резервные)
- **Аутентификация**: JWT через `access_token` в query string
- **Группы**: 
  - `chat_{chatId}` – участники чата

---

## Методы хаба (Client → Server)
| **Метод**               | **Параметры**                              | **Описание**                                 | **Авторизация**           |
|-------------------------|--------------------------------------------|---------------------------------------------|---------------------------|
| `JoinChat`              | `chatId: string`                           | Подключиться к чату                         | Требуется JWT             |
| `LeaveChat`             | `chatId: string`                           | Покинуть чат                                | Требуется JWT             |
| `SendMessage`           | `chatId: string`, `text: string`           | Отправить сообщение в чат                   | Участник чата             |
| `SendThreadMessage`          | `chatId: string`, `parentMessageId: string`, `text: string`| Отправить сообщение в тред                   | Участник чата             |
| `AddUserToChat`         | `chatId: string`, `userId: string`         | Добавить пользователя в чат                 | Участник чата      |
| `RenameChat`            | `chatId: string`, `newName: string`        | Переименовать чат                           | Участник чата      |

---

## События (Server → Client)
| **Событие**             | **Данные**                                 | **Триггер**                                 | **Получатели**            |
|-------------------------|--------------------------------------------|---------------------------------------------|---------------------------|
| `ChatMessageReceived`   | `{ id, text, senderId, timestamp }`       | Новое сообщение в чате                      | Группа `chat_{chatId}`    |
| `ChatCreated`           | `{ id, chatName }`                 | Создан новый чат                            | Инициатор        |
| `ChatRenamed`           | `{ chatId, newName }`                     | Изменено название чата                      | Группа `chat_{chatId}`    |
| `UserJoinedChat`        | `{ chatId, userId }`                      | Пользователь добавлен в чат                 | Группа `chat_{chatId}`    |
| `UserLeftChat`          | `{ chatId, userId }`                      | Пользователь вышел из чата                  | Группа `chat_{chatId}`    |
| `ThreadCreated`         | `{ id, parentMessageId, name }`           | Создан новый тред                          | Группа `chat_{chatId}`    |

---
