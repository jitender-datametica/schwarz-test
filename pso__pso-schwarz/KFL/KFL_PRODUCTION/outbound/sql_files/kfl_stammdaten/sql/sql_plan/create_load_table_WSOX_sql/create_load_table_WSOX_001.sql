--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.wsox;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.wsox;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsox ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      INTEGER NOT NULL,
--sart       STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      INTEGER NOT NULL,
--vtext      STRING(40) CHARACTER SET LATIN NOT CASESPECIFIC,
--datab      DATE,
--datub      DATE,
--lvorm      STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--filiale    INTEGER NOT NULL,
--datuv      DATE,
--sposi      INTEGER NOT NULL,
--akz        STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--stcklst    INTEGER NOT NULL)
--PRIMARY INDEX ( skopf )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.wsox (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    vtext STRING(40) COLLATE 'und:ci',
    datab DATE,
    datub DATE,
    lvorm STRING(1) COLLATE 'und:ci',
    filiale INTEGER NOT NULL,
    datuv DATE,
    sposi INTEGER NOT NULL,
    akz STRING(1) COLLATE 'und:ci',
    stcklst INTEGER NOT NULL
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.wsoh;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.wsoh;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsoh ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      INTEGER NOT NULL,
--sart       STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      INTEGER NOT NULL,
--vtext      STRING(40) CHARACTER SET LATIN NOT CASESPECIFIC,
--datab      DATE,
--datub      DATE,
--lvorm      STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.wsoh (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    vtext STRING(40) COLLATE 'und:ci',
    datab DATE,
    datub DATE,
    lvorm STRING(1) COLLATE 'und:ci'
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.wsof;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.wsof;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsof ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      INTEGER NOT NULL,
--sart       STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      INTEGER NOT NULL,
--filiale    INTEGER NOT NULL,
--datuv      DATE,
--datub      DATE NOT NULL,
--lvorm      STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf ,filiale );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.wsof (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    filiale INTEGER NOT NULL,
    datuv DATE,
    datub DATE NOT NULL,
    lvorm STRING(1) COLLATE 'und:ci'
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.wsop;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.wsop;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.wsop ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL
--(
--mandt      INTEGER NOT NULL,
--sart       STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--skopf      INTEGER NOT NULL,
--sposi      INTEGER NOT NULL,
--datuv      DATE,
--datub      DATE NOT NULL,
--akz  STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--stcklst    INTEGER NOT NULL,
--lvorm      STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC)
--PRIMARY INDEX ( skopf ,sposi )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.wsop (
    mandt INTEGER NOT NULL,
    sart STRING(1) COLLATE 'und:ci',
    skopf INTEGER NOT NULL,
    sposi INTEGER NOT NULL,
    datuv DATE,
    datub DATE NOT NULL,
    akz STRING(1) COLLATE 'und:ci',
    stcklst INTEGER NOT NULL,
    lvorm STRING(1) COLLATE 'und:ci'
);
