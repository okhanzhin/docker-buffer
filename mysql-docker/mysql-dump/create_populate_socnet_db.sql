# noinspection SqlNoDataSourceInspectionForFile

# CREATE DATABASE social_network;
USE social_network;

create table accounts
(
    accountID          int auto_increment
        primary key,
    surname            varchar(45)                 not null,
    middlename         varchar(45)                 null,
    name               varchar(30)                 not null,
    email              varchar(50)                 not null,
    password           varchar(60)                 not null,
    dateOfBirth        date                        null,
    skype              varchar(30)                 null,
    icq                varchar(15)                 null,
    homeAddress        varchar(45)                 null,
    workAddress        varchar(45)                 null,
    addInfo            varchar(100)                null,
    dateOfRegistration date                        null,
    role               varchar(100) default 'USER' not null,
    enabled            tinyint(1)   default 1      not null,
    picAttached        tinyint(1)   default 0      not null,
    constraint email
        unique (email),
    constraint icq
        unique (icq),
    constraint skype
        unique (skype)
);


INSERT INTO accounts (accountID, surname, middlename, name, email, password, dateOfBirth, skype, icq, homeAddress, workAddress, addInfo, dateOfRegistration, role, enabled, picAttached) VALUES (31, 'Khanzhin', 'Vladislavovich', 'Oleg', 'dealucky@mail.ru', '$2a$12$F/PLWmWsJ3RH/nTk.VbnJOnfRe6eRwwJkHic5UKny1I3SywUbYLSO', '1987-10-20', '324242', '34567654', 'Bangladesh', 'Pereslavl', '', '2021-02-11', 'USER', 1, 0);
INSERT INTO accounts (accountID, surname, middlename, name, email, password, dateOfBirth, skype, icq, homeAddress, workAddress, addInfo, dateOfRegistration, role, enabled, picAttached) VALUES (84, 'Tolstoy', 'Nikolayevich', 'Leo', 'o.khanzhin@gmail.com', '$2a$12$fLs6z.uoWY/4/ioiOBdcn.NYuBqcOg4cZJviKG9./CasWBbuQaQ0m', '2021-10-01', '438493715906319', '53715123', 'Yasnaya Polyana', '', '', '2021-05-07', 'ADMIN', 1, 0);
INSERT INTO accounts (accountID, surname, middlename, name, email, password, dateOfBirth, skype, icq, homeAddress, workAddress, addInfo, dateOfRegistration, role, enabled, picAttached) VALUES (404, 'Dostoevsky', 'Mikhailovich', 'Fedor', 'dost@gmail.com', '$2a$12$F/PLWmWsJ3RH/nTk.VbnJOnfRe6eRwwJkHic5UKny1I3SywUbYLSO', '2021-09-06', '21143431', '144664431', 'Moscow', '', '', '2021-05-19', 'USER', 1, 0);
INSERT INTO accounts (accountID, surname, middlename, name, email, password, dateOfBirth, skype, icq, homeAddress, workAddress, addInfo, dateOfRegistration, role, enabled, picAttached) VALUES (1064, 'Tarkovsky', 'Aleksandrovich', 'Arseny', 'tarkovsky@gmail.com', '$2a$12$F/PLWmWsJ3RH/nTk.VbnJOnfRe6eRwwJkHic5UKny1I3SywUbYLSO', '2021-09-06', '6543421111191', '233546562', 'Moscow', '', '', '2021-05-26', 'USER', 1, 0);
INSERT INTO accounts (accountID, surname, middlename, name, email, password, dateOfBirth, skype, icq, homeAddress, workAddress, addInfo, dateOfRegistration, role, enabled, picAttached) VALUES (1354, 'Кравиц', '', 'Nina', 'twistedyoda36@gmail.com', '$2a$12$F/PLWmWsJ3RH/nTk.VbnJOnfRe6eRwwJkHic5UKny1I3SywUbYLSO', '2021-07-07', '23124512431', '31241241243', '', '', '', '2021-07-26', 'USER', 1, 0);


create table acc_pictures
(
    picID     int auto_increment
        primary key,
    accountID int        not null,
    content   mediumblob null,
    constraint acc_pictures_accounts_fk
        foreign key (accountID) references accounts (accountID)
            on delete cascade
);

create table chat_rooms
(
    chatRoomID        int auto_increment
        primary key,
    interlocutorOneID int                  not null,
    interlocutorTwoID int                  not null,
    active            tinyint(1) default 1 not null,
    constraint chat_rooms_accounts_fk1
        foreign key (interlocutorOneID) references accounts (accountID),
    constraint chat_rooms_accounts_fk2
        foreign key (interlocutorTwoID) references accounts (accountID)
);


INSERT INTO chat_rooms (chatRoomID, interlocutorOneID, interlocutorTwoID) VALUES (24, 31, 1064);
INSERT INTO chat_rooms (chatRoomID, interlocutorOneID, interlocutorTwoID) VALUES (34, 84, 1064);
INSERT INTO chat_rooms (chatRoomID, interlocutorOneID, interlocutorTwoID) VALUES (54, 84, 31);
INSERT INTO chat_rooms (chatRoomID, interlocutorOneID, interlocutorTwoID) VALUES (64, 404, 84);


create table communities
(
    commID             int auto_increment
        primary key,
    commName           varchar(45)          not null,
    commDescription    varchar(300)         null,
    dateOfRegistration date                 null,
    picAttached        tinyint(1) default 0 not null,
    constraint commName
        unique (commName)
);


INSERT INTO communities (commID, commName, commDescription, dateOfRegistration, picAttached) VALUES (44, 'Great Russian Literature', 'Don''t cry, Maria! I''m here!', '2021-06-25', 0);
INSERT INTO communities (commID, commName, commDescription, dateOfRegistration, picAttached) VALUES (394, 'fafgdgsdas', '', '2021-05-25', 0);
INSERT INTO communities (commID, commName, commDescription, dateOfRegistration, picAttached) VALUES (404, 'Tolstoy Fans', '231111', '2021-07-26', 0);
INSERT INTO communities (commID, commName, commDescription, dateOfRegistration, picAttached) VALUES (414, 'Tolstoy Fans 2.0', 'We love you Leo', '2021-07-30', 0);

create table comm_pictures
(
    picID   int auto_increment
        primary key,
    commID  int        not null,
    content mediumblob null,
    constraint comm_pictures_communities_fk
        foreign key (commID) references communities (commID)
            on delete cascade
);

create table members
(
    accountID    int        not null,
    commID       int        not null,
    memberStatus tinyint(3) not null,
    primary key (accountID, commID),
    constraint members_accounts_fk
        foreign key (accountID) references accounts (accountID)
            on update cascade on delete cascade,
    constraint members_communities_fk
        foreign key (commID) references communities (commID)
            on update cascade on delete cascade
);

create index members_accounts_index
    on members (accountID);

INSERT INTO members (accountID, commID, memberStatus) VALUES (84, 44, 0);
INSERT INTO members (accountID, commID, memberStatus) VALUES (84, 394, 0);
INSERT INTO members (accountID, commID, memberStatus) VALUES (84, 414, 0);


create table messages
(
    messageID       int auto_increment
        primary key,
    chatRoomID      int       not null,
    sourceID        int       not null,
    targetID        int       not null,
    content         text      not null,
    publicationDate timestamp null,
    constraint messages_accounts_fk1
        foreign key (sourceID) references accounts (accountID),
    constraint messages_accounts_fk2
        foreign key (targetID) references accounts (accountID),
    constraint messages_chat_rooms_fk
        foreign key (chatRoomID) references chat_rooms (chatRoomID)
            on update cascade on delete cascade
);


INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (544, 54, 84, 31, 'fsdfhfsd', '2021-07-31 20:33:49');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (554, 64, 404, 84, 'fdasfasdas', '2021-08-05 16:02:44');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (564, 64, 404, 84, 'dassda', '2021-08-05 16:02:49');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (574, 64, 404, 84, 'fdsfsd', '2021-08-05 16:03:09');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (584, 64, 404, 84, 'dasda', '2021-08-05 16:03:11');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (594, 54, 84, 31, 'Hi', '2021-08-10 20:44:20');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (604, 54, 31, 84, 'Привет привет!!', '2021-08-10 20:44:57');
INSERT INTO messages (messageID, chatRoomID, sourceID, targetID, content, publicationDate) VALUES (614, 54, 31, 84, 'hi man how are you', '2021-10-08 18:34:18');


create table phones
(
    phoneID     int auto_increment
        primary key,
    accountID   int         not null,
    phoneNumber varchar(15) not null,
    phoneType   varchar(15) not null,
    constraint phones_accounts_fk
        foreign key (accountID) references accounts (accountID)
            on update cascade on delete cascade
);


INSERT INTO phones (phoneID, accountID, phoneNumber, phoneType) VALUES (2524, 404, '89152892321', 'work');
INSERT INTO phones (phoneID, accountID, phoneNumber, phoneType) VALUES (2534, 404, '89157340404', 'home');
INSERT INTO phones (phoneID, accountID, phoneNumber, phoneType) VALUES (3204, 1064, '89109697771', 'home');
INSERT INTO phones (phoneID, accountID, phoneNumber, phoneType) VALUES (3404, 1354, '89109694449', 'home');
INSERT INTO phones (phoneID, accountID, phoneNumber, phoneType) VALUES (3564, 84, '89152892216', 'home');

create table pictures
(
    picID   int auto_increment
        primary key,
    content mediumblob not null
);


create table posts
(
    postID          int auto_increment
        primary key,
    sourceID        int        not null,
    accTargetID     int        null,
    commTargetID    int        null,
    postType        varchar(7) not null,
    content         text       not null,
    publicationDate timestamp  null,
    constraint posts_accounts_source_fk
        foreign key (sourceID) references accounts (accountID),
    constraint posts_accounts_target_fk
        foreign key (accTargetID) references accounts (accountID),
    constraint posts_communities_target_fk
        foreign key (commTargetID) references communities (commID)
);

INSERT INTO posts (postID, sourceID, accTargetID, commTargetID, postType, content, publicationDate) VALUES (24, 84, 31, null, 'account', 'Hey Oleg!', '2021-07-23 13:51:50');
INSERT INTO posts (postID, sourceID, accTargetID, commTargetID, postType, content, publicationDate) VALUES (44, 84, 1064, null, 'account', 'Привет, Тарковский! ', '2021-07-24 15:59:24');
INSERT INTO posts (postID, sourceID, accTargetID, commTargetID, postType, content, publicationDate) VALUES (54, 84, 31, null, 'account', 'How are You?', '2021-08-05 20:49:46');
INSERT INTO posts (postID, sourceID, accTargetID, commTargetID, postType, content, publicationDate) VALUES (64, 84, 84, null, 'account', 'Hi there', '2021-08-05 20:58:34');

create table relations
(
    relationID      int auto_increment
        primary key,
    accountOneID    int                  not null,
    accountTwoID    int                  not null,
    relationStatus  tinyint(3) default 0 not null,
    actionAccountID int                  not null,
    constraint relations_accounts_fk1
        foreign key (accountOneID) references accounts (accountID),
    constraint relations_accounts_fk2
        foreign key (accountTwoID) references accounts (accountID),
    constraint relations_accounts_fk3
        foreign key (actionAccountID) references accounts (accountID)
);


INSERT INTO relations (relationID, accountOneID, accountTwoID, relationStatus, actionAccountID) VALUES (4, 84, 31, 1, 84);
INSERT INTO relations (relationID, accountOneID, accountTwoID, relationStatus, actionAccountID) VALUES (14, 404, 84, 1, 404);
INSERT INTO relations (relationID, accountOneID, accountTwoID, relationStatus, actionAccountID) VALUES (24, 84, 1064, 3, 84);


create table requests
(
    requestID     int auto_increment
        primary key,
    sourceID      int        not null,
    accTargetID   int        null,
    commTargetID  int        null,
    requestType   varchar(7) null,
    requestStatus tinyint    null,
    constraint requests_accounts_source_fk
        foreign key (sourceID) references accounts (accountID),
    constraint requests_accounts_target_fk
        foreign key (accTargetID) references accounts (accountID),
    constraint requests_communities_target_fk
        foreign key (commTargetID) references communities (commID)
);


INSERT INTO requests (requestID, sourceID, accTargetID, commTargetID, requestType, requestStatus) VALUES (34, 404, null, 44, 'comm', 0);
INSERT INTO requests (requestID, sourceID, accTargetID, commTargetID, requestType, requestStatus) VALUES (44, 1354, null, 44, 'comm', 0);
INSERT INTO requests (requestID, sourceID, accTargetID, commTargetID, requestType, requestStatus) VALUES (54, 31, null, 44, 'comm', 0);
INSERT INTO requests (requestID, sourceID, accTargetID, commTargetID, requestType, requestStatus) VALUES (84, 404, 84, null, 'account', 1);
INSERT INTO requests (requestID, sourceID, accTargetID, commTargetID, requestType, requestStatus) VALUES (94, 84, 31, null, 'account', 1);


create table roles
(
    roleID int auto_increment
        primary key,
    name   varchar(100) default 'ROLE_USER' not null
);


INSERT INTO roles (roleID, name) VALUES (1, 'ROLE_USER');
INSERT INTO roles (roleID, name) VALUES (2, 'ROLE_ADMIN');


