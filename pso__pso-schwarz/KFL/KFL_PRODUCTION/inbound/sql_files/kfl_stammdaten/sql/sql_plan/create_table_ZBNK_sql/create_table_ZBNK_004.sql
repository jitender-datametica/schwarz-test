--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.zbnk ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
-- mandt           INTEGER
--,matnr           VARCHAR( 7) CHARACTER SET LATIN NOT CASESPECIFIC
--,lifnr           VARCHAR( 7) CHARACTER SET LATIN NOT CASESPECIFIC
--,werks           VARCHAR( 4) CHARACTER SET LATIN NOT CASESPECIFIC
--,datab           VARCHAR( 8) CHARACTER SET LATIN NOT CASESPECIFIC
--,afracht1        VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,afracht2        VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,zoll            VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,antidump        VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,ifracht         VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,grs             VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,dsd             VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,gema            VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,vsteuer         VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,verpack         VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,prov            VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,hkprov          VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,anprov          VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,mto             VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,pruefk          VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,euregel         VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,sonstige        VARCHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,konwa           VARCHAR( 4) CHARACTER SET LATIN NOT CASESPECIFIC
--
--)
--PRIMARY INDEX (matnr,lifnr,werks,datab )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.zbnk  (
 mandt           INTEGER
,matnr           VARCHAR( 7) COLLATE 'de-ci'
,lifnr           VARCHAR( 7) COLLATE 'de-ci'
,werks           VARCHAR( 4) COLLATE 'de-ci'
,datab           VARCHAR( 8) COLLATE 'de-ci'
,afracht1        VARCHAR(12) COLLATE 'de-ci'
,afracht2        VARCHAR(12) COLLATE 'de-ci'
,zoll            VARCHAR(12) COLLATE 'de-ci'
,antidump        VARCHAR(12) COLLATE 'de-ci'
,ifracht         VARCHAR(12) COLLATE 'de-ci'
,grs             VARCHAR(12) COLLATE 'de-ci'
,dsd             VARCHAR(12) COLLATE 'de-ci'
,gema            VARCHAR(12) COLLATE 'de-ci'
,vsteuer         VARCHAR(12) COLLATE 'de-ci'
,verpack         VARCHAR(12) COLLATE 'de-ci'
,prov            VARCHAR(12) COLLATE 'de-ci'
,hkprov          VARCHAR(12) COLLATE 'de-ci'
,anprov          VARCHAR(12) COLLATE 'de-ci'
,mto             VARCHAR(12) COLLATE 'de-ci'
,pruefk          VARCHAR(12) COLLATE 'de-ci'
,euregel         VARCHAR(12) COLLATE 'de-ci'
,sonstige        VARCHAR(12) COLLATE 'de-ci'
,konwa           VARCHAR( 4) COLLATE 'de-ci'

)
;

