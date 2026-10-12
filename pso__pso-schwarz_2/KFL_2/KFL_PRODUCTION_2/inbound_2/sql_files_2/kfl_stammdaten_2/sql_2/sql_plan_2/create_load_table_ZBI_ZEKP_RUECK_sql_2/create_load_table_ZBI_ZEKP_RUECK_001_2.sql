--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_bg_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_bg_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_bg_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_bg_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_cz_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_cz_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_cz_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_cz_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_hr_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_hr_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_hr_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_hr_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_pl_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_pl_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_pl_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_pl_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_ro_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_ro_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_ro_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_ro_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_sk_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_sk_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_sk_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_sk_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.kmo_zekp_md_2;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.kmo_zekp_md_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.kmo_zekp_md_2 , NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id    BYTEINT,
--cycle_id      INTEGER,
--quellsystem   CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--matnr         INTEGER,
--lifnr         INTEGER,
--ekorg         SMALLINT,
--werks         INTEGER,
--datab         DATE FORMAT 'YYYY-MM_2-DD',
--datbis        DATE FORMAT 'YYYY-MM_2-DD',
--wrg_2           CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--aedat         TIMESTAMP(6),
--ebrut         DECIMAL(18,4),
--ekkba         DECIMAL(18,4),
--abrut         DECIMAL(18,4),
--aknet         DECIMAL(18,4),
--aknne         DECIMAL(18,4),
--mepre         DECIMAL(18,4),
--lsein         DECIMAL(18,4),
--lokau         DECIMAL(18,4),
--abrna         DECIMAL(18,4),
--abonba        DECIMAL(18,4),
--aknb          DECIMAL(18,4),
--aknbs         DECIMAL(18,4),
--zollba        DECIMAL( 9,4),
--bnk           DECIMAL(18,4)
--)
--PRIMARY INDEX NUPI_kmo_zekp (matnr, lifnr, werks)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.kmo_zekp_md_2  (
mandant_id    BYTEINT,
cycle_id      INTEGER,
quellsystem   CHAR(2) COLLATE 'de-ci',
matnr         INTEGER,
lifnr         INTEGER,
ekorg         SMALLINT,
werks         INTEGER,
datab         DATE,
datbis        DATE,
wrg_2           CHAR(3) COLLATE 'de-ci',
aedat         TIMESTAMP(6),
ebrut         DECIMAL(18,4),
ekkba         DECIMAL(18,4),
abrut         DECIMAL(18,4),
aknet         DECIMAL(18,4),
aknne         DECIMAL(18,4),
mepre         DECIMAL(18,4),
lsein         DECIMAL(18,4),
lokau         DECIMAL(18,4),
abrna         DECIMAL(18,4),
abonba        DECIMAL(18,4),
aknb          DECIMAL(18,4),
aknbs         DECIMAL(18,4),
zollba        DECIMAL( 9,4),
bnk           DECIMAL(18,4)
)
;

