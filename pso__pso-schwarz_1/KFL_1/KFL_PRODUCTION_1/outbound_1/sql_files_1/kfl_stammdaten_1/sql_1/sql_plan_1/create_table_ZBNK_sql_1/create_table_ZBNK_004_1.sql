--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.zbnk_1 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
-- mandt           INTEGER
--,matnr           STRING( 7) CHARACTER SET LATIN NOT CASESPECIFIC
--,lifnr           STRING( 7) CHARACTER SET LATIN NOT CASESPECIFIC
--,werks           STRING( 4) CHARACTER SET LATIN NOT CASESPECIFIC
--,datab           STRING( 8) CHARACTER SET LATIN NOT CASESPECIFIC
--,afracht1        STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,afracht2        STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,zoll            STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,antidump        STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,ifracht         STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,grs             STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,dsd             STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,gema            STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,vsteuer         STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,verpack         STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,prov            STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,hkprov          STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,anprov          STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,mto             STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,pruefk          STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,euregel         STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,sonstige        STRING(12) CHARACTER SET LATIN NOT CASESPECIFIC
--,konwa           STRING( 4) CHARACTER SET LATIN NOT CASESPECIFIC
--
--)
--PRIMARY INDEX (matnr,lifnr,werks,datab )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.zbnk_1 (
    mandt INTEGER,
    matnr STRING(7) COLLATE 'und:ci',
    lifnr STRING(7) COLLATE 'und:ci',
    werks STRING(4) COLLATE 'und:ci',
    datab STRING(8) COLLATE 'und:ci',
    afracht1 STRING(12) COLLATE 'und:ci',
    afracht2 STRING(12) COLLATE 'und:ci',
    zoll STRING(12) COLLATE 'und:ci',
    antidump STRING(12) COLLATE 'und:ci',
    ifracht STRING(12) COLLATE 'und:ci',
    grs STRING(12) COLLATE 'und:ci',
    dsd STRING(12) COLLATE 'und:ci',
    gema STRING(12) COLLATE 'und:ci',
    vsteuer STRING(12) COLLATE 'und:ci',
    verpack STRING(12) COLLATE 'und:ci',
    prov STRING(12) COLLATE 'und:ci',
    hkprov STRING(12) COLLATE 'und:ci',
    anprov STRING(12) COLLATE 'und:ci',
    mto STRING(12) COLLATE 'und:ci',
    pruefk STRING(12) COLLATE 'und:ci',
    euregel STRING(12) COLLATE 'und:ci',
    sonstige STRING(12) COLLATE 'und:ci',
    konwa STRING(4) COLLATE 'und:ci'
);
