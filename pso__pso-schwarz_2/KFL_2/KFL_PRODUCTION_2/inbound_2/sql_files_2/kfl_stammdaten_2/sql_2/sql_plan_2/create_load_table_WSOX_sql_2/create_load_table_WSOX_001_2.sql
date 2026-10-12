--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.wsox_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.wsox_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsox_2 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      SMALLINT NOT NULL,
--sart       CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      DECIMAL(18,0) NOT NULL,
--vtext      VARCHAR(40) CHARACTER SET LATIN NOT CASESPECIFIC,
--datab      DATE,
--datub      DATE,
--lvorm      CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--filiale    INTEGER NOT NULL,
--datuv      DATE,
--sposi      INTEGER NOT NULL,
--akz        CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--stcklst    INTEGER NOT NULL)
--PRIMARY INDEX ( skopf )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.wsox_2  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'de-ci',
skopf      DECIMAL(18,0) NOT NULL,
vtext      VARCHAR(40) COLLATE 'de-ci',
datab      DATE,
datub      DATE,
lvorm      CHAR(1) COLLATE 'de-ci',
filiale    INTEGER NOT NULL,
datuv      DATE,
sposi      INTEGER NOT NULL,
akz        CHAR(1) COLLATE 'de-ci',
stcklst    INTEGER NOT NULL)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.wsoh_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.wsoh_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsoh_2 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      SMALLINT NOT NULL,
--sart       CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      DECIMAL(18,0) NOT NULL,
--vtext      VARCHAR(40) CHARACTER SET LATIN NOT CASESPECIFIC,
--datab      DATE,
--datub      DATE,
--lvorm      CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.wsoh_2  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'de-ci',
skopf      DECIMAL(18,0) NOT NULL,
vtext      VARCHAR(40) COLLATE 'de-ci',
datab      DATE,
datub      DATE,
lvorm      CHAR(1) COLLATE 'de-ci')
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.wsof_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.wsof_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsof_2 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      SMALLINT NOT NULL,
--sart       CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      DECIMAL(18,0) NOT NULL,
--filiale    INTEGER NOT NULL,
--datuv      DATE,
--datub      DATE NOT NULL,
--lvorm      CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf ,filiale );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.wsof_2  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'de-ci',
skopf      DECIMAL(18,0) NOT NULL,
filiale    INTEGER NOT NULL,
datuv      DATE,
datub      DATE NOT NULL,
lvorm      CHAR(1) COLLATE 'de-ci')
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.wsop_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.wsop_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsop_2 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      SMALLINT NOT NULL,
--sart       CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      DECIMAL(18,0) NOT NULL,
--sposi      INTEGER NOT NULL,
--datuv      DATE,
--datub      DATE NOT NULL,
--akz  CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--stcklst    INTEGER NOT NULL,
--lvorm      CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf ,sposi )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.wsop_2  (
mandt      SMALLINT NOT NULL,
sart       CHAR(1) COLLATE 'de-ci',
skopf      DECIMAL(18,0) NOT NULL,
sposi      INTEGER NOT NULL,
datuv      DATE,
datub      DATE NOT NULL,
akz  CHAR(1) COLLATE 'de-ci',
stcklst    INTEGER NOT NULL,
lvorm      CHAR(1) COLLATE 'de-ci')
;

