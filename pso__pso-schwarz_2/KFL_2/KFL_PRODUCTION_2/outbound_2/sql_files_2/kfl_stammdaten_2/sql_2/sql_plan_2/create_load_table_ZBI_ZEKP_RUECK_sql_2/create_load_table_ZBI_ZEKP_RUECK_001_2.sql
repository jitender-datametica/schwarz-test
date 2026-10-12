--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_bg_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_bg_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_bg_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_bg_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_cz_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_cz_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_cz_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_cz_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_hr_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_hr_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_hr_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_hr_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_pl_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_pl_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_pl_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_pl_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_ro_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_ro_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_ro_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_ro_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_sk_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_sk_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_sk_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_sk_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_zekp_md_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_zekp_md_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_md_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    INTEGER,
--cycle_id      INTEGER,
--quellsystem   STRING(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         INTEGER,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           STRING(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         timestamp_ntz(6),
--ebrut         NUMBER(29,4),
--ekkba         NUMBER(29,4),
--abrut         NUMBER(29,4),
--aknet         NUMBER(29,4),
--aknne         NUMBER(29,4),
--mepre         NUMBER(29,4),
--lsein         NUMBER(29,4),
--lokau         NUMBER(29,4),
--abrna         NUMBER(29,4),
--abonba        NUMBER(29,4),
--aknb          NUMBER(29,4),
--aknbs         NUMBER(29,4),
--zollba        NUMBER(29,4),
--bnk           NUMBER(29,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_zekp_md_2 (
    mandant_id INTEGER,
    cycle_id INTEGER,
    quellsystem STRING(2) COLLATE 'und:ci',
    matnr INTEGER,
    lifnr INTEGER,
    ekorg INTEGER,
    werks INTEGER,
    datab DATE,
    datbis DATE,
    wrg_2 STRING(3) COLLATE 'und:ci',
    aedat DATETIME,
    ebrut NUMERIC(29, 4),
    ekkba NUMERIC(29, 4),
    abrut NUMERIC(29, 4),
    aknet NUMERIC(29, 4),
    aknne NUMERIC(29, 4),
    mepre NUMERIC(29, 4),
    lsein NUMERIC(29, 4),
    lokau NUMERIC(29, 4),
    abrna NUMERIC(29, 4),
    abonba NUMERIC(29, 4),
    aknb NUMERIC(29, 4),
    aknbs NUMERIC(29, 4),
    zollba NUMERIC(29, 4),
    bnk NUMERIC(29, 4)
);
