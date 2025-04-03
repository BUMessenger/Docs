CREATE TABLE "Users" (
  "Id" uuid PRIMARY KEY,
  "Name" text NOT NULL,
  "Surname" text NOT NULL,
  "Fathername" text,
  "Email" text UNIQUE NOT NULL,
  "PasswordHashed" text NOT NULL
);

CREATE TABLE "AuthTokens" (
  "Id" uuid PRIMARY KEY,
  "UserId" uuid NOT NULL,
  "RefreshToken" text NOT NULL,
  "ExpiresAtUtc" timestamp NOT NULL
);

CREATE TABLE "Chats" (
  "Id" uuid PRIMARY KEY,
  "ChatName" text NOT NULL
);

CREATE TABLE "ChatUserInfos" (
  "Id" uuid PRIMARY KEY,
  "ChatId" uuid NOT NULL,
  "UserId" uuid NOT NULL,
  "LastReadMessageId" uuid
);

CREATE TABLE "Messages" (
  "Id" uuid PRIMARY KEY,
  "ChatId" uuid NOT NULL,
  "CreatorId" uuid,
  "ParentMessageId" uuid,
  "SentAtUtc" timestamp NOT NULL,
  "MessageText" text NOT NULL
);

CREATE TABLE "UnregisteredUsers" (
  "Id" uuid PRIMARY KEY,
  "Email" text NOT NULL,
  "PasswordHashed" text NOT NULL,
  "ApproveCode" text NOT NULL,
  "ExpiresAtUtc" timestamp NOT NULL
);

ALTER TABLE "AuthTokens" ADD FOREIGN KEY ("UserId") REFERENCES "Users" ("Id");

ALTER TABLE "ChatUserInfos" ADD FOREIGN KEY ("ChatId") REFERENCES "Chats" ("Id");

ALTER TABLE "ChatUserInfos" ADD FOREIGN KEY ("UserId") REFERENCES "Users" ("Id");

ALTER TABLE "ChatUserInfos" ADD FOREIGN KEY ("LastReadMessageId") REFERENCES "Messages" ("Id");

ALTER TABLE "Messages" ADD FOREIGN KEY ("ChatId") REFERENCES "Chats" ("Id");

ALTER TABLE "Messages" ADD FOREIGN KEY ("CreatorId") REFERENCES "Users" ("Id");

ALTER TABLE "Messages" ADD FOREIGN KEY ("ParentMessageId") REFERENCES "Messages" ("Id");
