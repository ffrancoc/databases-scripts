BEGIN TRANSACTION;
DROP TABLE IF EXISTS "USERS";
CREATE TABLE IF NOT EXISTS "USERS" (
	"ID"	INTEGER NOT NULL,
	"USERNAME"	TEXT NOT NULL UNIQUE,
	"PASSWORD"	TEXT NOT NULL,
	"ROOT"	INTEGER NOT NULL DEFAULT 0,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"STATE"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "CATEGORIES";
CREATE TABLE IF NOT EXISTS "CATEGORIES" (
	"ID"	INTEGER NOT NULL,
	"NAME"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "PRODUCTS";
CREATE TABLE IF NOT EXISTS "PRODUCTS" (
	"ID"	INTEGER NOT NULL,
	"NAME"	TEXT NOT NULL,
	"STOCK"	INTEGER NOT NULL DEFAULT 0,
	"STOCK_MIN"	INTEGER NOT NULL DEFAULT 0,
	"COMMING"	INTEGER NOT NULL DEFAULT 0,
	"LABELS"	TEXT NOT NULL,
	"CATEGORY_ID"	INTEGER,
	"USER_ID"	INTEGER,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"STATE"	INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE SET NULL,
	FOREIGN KEY("CATEGORY_ID") REFERENCES "CATEGORIES"("ID") ON DELETE SET NULL,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "DEPARTMENTS";
CREATE TABLE IF NOT EXISTS "DEPARTMENTS" (
	"ID"	INTEGER NOT NULL,
	"NAME"	TEXT NOT NULL UNIQUE,
	"DESCRIPTION"	TEXT NOT NULL,
	"LEADER_ID"	INTEGER NOT NULL,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"STATE"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("LEADER_ID") REFERENCES "EMPLOYEES"("ID") ON DELETE RESTRICT
);
DROP TABLE IF EXISTS "EMPLOYEES";
CREATE TABLE IF NOT EXISTS "EMPLOYEES" (
	"ID"	INTEGER NOT NULL,
	"FIRSTNAME"	TEXT NOT NULL,
	"LASTNAME"	TEXT NOT NULL,
	"PHONE"	TEXT NOT NULL,
	"CAN_TAKEOUT"	INTEGER NOT NULL DEFAULT 1,
	"DEPARTMENT_ID"	INTEGER,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"STATE"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("DEPARTMENT_ID") REFERENCES "DEPARTMENTS"("ID") ON DELETE SET NULL
);
DROP TABLE IF EXISTS "ORDERS";
CREATE TABLE IF NOT EXISTS "ORDERS" (
	"ID"	INTEGER NOT NULL,
	"STATE"	INTEGER NOT NULL DEFAULT 0,
	"NOTES"	TEXT NOT NULL,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"USER_ID"	INTEGER,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE SET NULL
);
DROP TABLE IF EXISTS "SUPPLIERS";
CREATE TABLE IF NOT EXISTS "SUPPLIERS" (
	"ID"	INTEGER NOT NULL,
	"NAME"	TEXT NOT NULL UNIQUE,
	"PHONE"	TEXT NOT NULL UNIQUE,
	"EMAIL"	TEXT NOT NULL UNIQUE,
	"ADDRESS"	TEXT NOT NULL,
	"NOTES"	TEXT NOT NULL,
	"USER_ID"	INTEGER NOT NULL,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"STATE"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE SET NULL
);
DROP TABLE IF EXISTS "ORDERS_DETAIL";
CREATE TABLE IF NOT EXISTS "ORDERS_DETAIL" (
	"ORDER_ID"	INTEGER NOT NULL,
	"ORDER_PRODUCT"	INTEGER NOT NULL,
	"RECEIVED"	INTEGER NOT NULL,
	"PENDING"	INTEGER NOT NULL,
	"PRICE_UNIT"	REAL NOT NULL,
	"TOTAL"	REAL NOT NULL,
	"USER_ID"	INTEGER NOT NULL,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE SET NULL,
	FOREIGN KEY("ORDER_ID") REFERENCES "ORDERS"("ID") ON DELETE CASCADE,
	FOREIGN KEY("ORDER_PRODUCT") REFERENCES "PRODUCTS"("ID") ON DELETE RESTRICT
);
DROP TABLE IF EXISTS "DISPATCH";
CREATE TABLE IF NOT EXISTS "DISPATCH" (
	"ID"	INTEGER NOT NULL,
	"EMPLOYEE_ID"	INTEGER NOT NULL,
	"USER_ID"	INTEGER NOT NULL,
	"NOTES"	TEXT NOT NULL,
	"REGISTERED"	TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"MODIFIED"	TEXT,
	"ESTATE"	INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY("EMPLOYEE_ID") REFERENCES "EMPLOYEES"("ID") ON DELETE SET NULL,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE SET NULL
);
DROP TABLE IF EXISTS "DISPATCH_DETAILS";
CREATE TABLE IF NOT EXISTS "DISPATCH_DETAILS" (
	"DISPATCH_ID"	INTEGER NOT NULL,
	"PRODUCT_ID"	INTEGER NOT NULL,
	"QUANTITY"	INTEGER NOT NULL,
	FOREIGN KEY("DISPATCH_ID") REFERENCES "DISPATCH"("ID") ON DELETE CASCADE,
	FOREIGN KEY("PRODUCT_ID") REFERENCES "USERS"("ID") ON DELETE RESTRICT
);
DROP TABLE IF EXISTS "PERMISSIONS";
CREATE TABLE IF NOT EXISTS "PERMISSIONS" (
	"ID"	INTEGER NOT NULL,
	"USER_ID"	INTEGER NOT NULL,
	"USERS"	INTEGER NOT NULL,
	"CATEGORIES"	INTEGER NOT NULL,
	"DEPARTMENTS"	INTEGER NOT NULL,
	"DISPATCH"	INTEGER NOT NULL,
	"EMPLOYEES"	INTEGER NOT NULL,
	"ORDERS"	INTEGER NOT NULL,
	"PRODUCTS"	INTEGER NOT NULL,
	"SUPPLIERS"	INTEGER NOT NULL,
	PRIMARY KEY("ID" AUTOINCREMENT),
	FOREIGN KEY("USER_ID") REFERENCES "USERS"("ID") ON DELETE CASCADE
);
COMMIT;
