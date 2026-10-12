--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.wsoh;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.wsoh  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'en-ci',
skopf      DECIMAL(18,0) NOT NULL,
vtext      VARCHAR(40) COLLATE 'en-ci',
datab      DATE,
datub      DATE,
lvorm      CHAR(1) COLLATE 'en-ci')
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.wsof;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.wsof  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'en-ci',
skopf      DECIMAL(18,0) NOT NULL,
filiale    INTEGER NOT NULL,
datuv      DATE,
datub      DATE NOT NULL,
lvorm      CHAR(1) COLLATE 'en-ci')
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.wsop;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.wsop  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'en-ci',
skopf      DECIMAL(18,0) NOT NULL,
sposi      INTEGER NOT NULL,
datuv      DATE,
datub      DATE NOT NULL,
akz  CHAR(1) COLLATE 'en-ci',
stcklst    INTEGER NOT NULL,
lvorm      CHAR(1) COLLATE 'en-ci')
;

