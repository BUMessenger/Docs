CREATE TABLE "User" (
  "Id" uuid PRIMARY KEY,
  "Name" text NOT NULL,
  "Surname" text NOT NULL,
  "Fathername" text,
  "Gender" enum(male,female) NOT NULL,
  "Email" text UNIQUE NOT NULL,
  "PasswordHashed" text NOT NULL
);

CREATE TABLE "AuthToken" (
  "Id" uuid PRIMARY KEY,
  "UserId" uuid NOT NULL,
  "RefreshToken" text NOT NULL,
  "ExpiresAt" timestamp NOT NULL
);

CREATE TABLE "Chat" (
  "Id" uuid PRIMARY KEY,
  "ChatName" text NOT NULL
);

CREATE TABLE "ChatUsers" (
  "Id" uuid PRIMARY KEY,
  "ChatId" uuid NOT NULL,
  "UserId" uuid NOT NULL,
  "LastReadMessageId" uuid
);

CREATE TABLE "Message" (
  "Id" uuid PRIMARY KEY,
  "ChatId" uuid NOT NULL,
  "CreatorId" uuid,
  "ParentMessageId" uuid,
  "SentAt" timestamp NOT NULL,
  "MessageText" text NOT NULL
);

CREATE TABLE "UnregistredUser" (
  "Id" uuid PRIMARY KEY,
  "Email" text NOT NULL,
  "ApproveCode" text NOT NULL,
  "ExpiresAt" timestamp NOT NULL
);

ALTER TABLE "AuthToken" ADD FOREIGN KEY ("UserId") REFERENCES "User" ("Id");

ALTER TABLE "ChatUsers" ADD FOREIGN KEY ("ChatId") REFERENCES "Chat" ("Id");

ALTER TABLE "ChatUsers" ADD FOREIGN KEY ("UserId") REFERENCES "User" ("Id");

ALTER TABLE "ChatUsers" ADD FOREIGN KEY ("LastReadMessageId") REFERENCES "Message" ("Id");

ALTER TABLE "Message" ADD FOREIGN KEY ("ChatId") REFERENCES "Chat" ("Id");

ALTER TABLE "Message" ADD FOREIGN KEY ("CreatorId") REFERENCES "User" ("Id");

ALTER TABLE "Message" ADD FOREIGN KEY ("ParentMessageId") REFERENCES "Message" ("Id");
