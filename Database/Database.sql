CREATE TABLE Product (
 id int NOT NULL,
 plug_id int NOT NULL,
 store_id int NOT NULL,
 name varchar(10) NOT NULL,
 location varchar(20) NULL
);

CREATE TABLE Env (
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 people int NULL
);

CREATE TABLE Smart_plug (
 id int NOT NULL,
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 amp float NULL
);

CREATE TABLE Hub (
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 amp float NULL
);

CREATE TABLE Store (
 store_id int NOT NULL,
 name varchar(10) NOT NULL,
 phone varchar(11) NULL,
 location varchar(25) NULL
);

CREATE TABLE Light (
 id int NOT NULL,
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 amp float NULL
);

CREATE TABLE Airconditioner (
 id int NOT NULL,
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 amp float NULL
);

CREATE TABLE Account (
 id varchar(20) NOT NULL,
 store_id int NOT NULL,
 passwd varchar(20) NOT NULL
);

CREATE TABLE Notice (
 datetime datetime NOT NULL,
 store_id int NOT NULL,
 contents varchar(40) NULL
);

ALTER TABLE Product ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (
 id,
 plug_id,
 store_id
);

ALTER TABLE Env ADD CONSTRAINT PK_ENV PRIMARY KEY (
 datetime,
 store_id
);

ALTER TABLE Smart_plug ADD CONSTRAINT PK_SMART_PLUG PRIMARY KEY (
 id,
 datetime,
 store_id
);

ALTER TABLE Hub ADD CONSTRAINT PK_HUB PRIMARY KEY (
 datetime,
 store_id
);

ALTER TABLE Store ADD CONSTRAINT PK_STORE PRIMARY KEY (
 store_id
);

ALTER TABLE Light ADD CONSTRAINT PK_LIGHT PRIMARY KEY (
 id,
 datetime,
 store_id
);

ALTER TABLE Airconditioner ADD CONSTRAINT PK_AIRCONDITIONER PRIMARY KEY (
 id,
 datetime,
 store_id
);

ALTER TABLE Account ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (
 id,
 store_id
);

ALTER TABLE Notice ADD CONSTRAINT PK_NOTICE PRIMARY KEY (
 datetime,
 store_id
);



ALTER TABLE Env ADD CONSTRAINT FK_Store_TO_Env_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Hub ADD CONSTRAINT FK_Store_TO_Hub_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Light ADD CONSTRAINT FK_Store_TO_Light_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Airconditioner ADD CONSTRAINT FK_Store_TO_Airconditioner_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Account ADD CONSTRAINT FK_Store_TO_Account_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);


ALTER TABLE Notice ADD CONSTRAINT FK_Store_TO_Notice_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Smart_plug ADD CONSTRAINT FK_Store_TO_Smart_plug_1 FOREIGN KEY (
 store_id
)
REFERENCES Store (
 store_id
);

ALTER TABLE Product ADD CONSTRAINT FK_Smart_plug_TO_Product_1 FOREIGN KEY (
 plug_id
)
REFERENCES Smart_plug (
 id
);

ALTER TABLE Product ADD CONSTRAINT FK_Smart_plug_TO_Product_2 FOREIGN KEY (
 store_id
)
REFERENCES Smart_plug (
 store_id
);
