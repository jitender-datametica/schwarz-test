
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CAL_WEEK_PARTIAL_WEEK_DESC_1 COMMENT = 'Multi language Parztial Week decsriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.4  21.12.2021    Morris, Michael          Added Estonia EE
#-----------------------------------------------------------------------------
*/
(
   cy_week_partial_week_id1          COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW'
 , cy_week_partial_week_id2          COMMENT 'Geschäftsjahr - Woche_1/Teilwoche - Wochenart Id- 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'
 , cy_week_partial_week_id           COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW/Wochenart - 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'
 , cy_week_partial_week_desc_AT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT'
 , cy_week_partial_week_desc_BE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE'
 , cy_week_partial_week_desc_BE_FR   COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR'
 , cy_week_partial_week_desc_BG      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG'
 , cy_week_partial_week_desc_CH      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH'
 , cy_week_partial_week_desc_CY      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY'
 , cy_week_partial_week_desc_CZ      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ'
 , cy_week_partial_week_desc         COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Bezeichnung'
 , cy_week_partial_week_desc_DK      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK'
 , cy_week_partial_week_desc_EE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE'
 , cy_week_partial_week_desc_ES      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES'
 , cy_week_partial_week_desc_FI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI'
 , cy_week_partial_week_desc_FR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR'
 , cy_week_partial_week_desc_GB      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB'
 , cy_week_partial_week_desc_GR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR'
 , cy_week_partial_week_desc_HR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR'
 , cy_week_partial_week_desc_HU      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU'
 , cy_week_partial_week_desc_IE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE'
 , cy_week_partial_week_desc_IT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT'
 , cy_week_partial_week_desc_LT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT'
 , cy_week_partial_week_desc_LV      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV'
 , cy_week_partial_week_desc_NI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI'
 , cy_week_partial_week_desc_NL      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL'
 , cy_week_partial_week_desc_DE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE'
 , cy_week_partial_week_desc_PL      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL'
 , cy_week_partial_week_desc_PT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT'
 , cy_week_partial_week_desc_RO      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO'
 , cy_week_partial_week_desc_SE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE'
 , cy_week_partial_week_desc_SI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI'
 , cy_week_partial_week_desc_SK      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK'
 , cy_week_partial_week_desc_CS      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS'
 , cy_week_partial_week_desc_MT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT'
 , cy_week_partial_week_desc_US      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US'
 , cy_week_partial_week_desc_RS      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1'
 , cy_week_partial_week_desc_s_AT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT kurz'
 , cy_week_partial_week_desc_s_BE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE kurz'
 , cy_week_partial_week_desc_s_BE_FR COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR kurz'
 , cy_week_partial_week_desc_s_BG    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG kurz'
 , cy_week_partial_week_desc_s_CH    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH kurz'
 , cy_week_partial_week_desc_s_CY    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY kurz'
 , cy_week_partial_week_desc_s_CZ    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ kurz'
 , cy_week_partial_week_desc_s       COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Kurzbezeichnung'
 , cy_week_partial_week_desc_s_DK    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK kurz'
 , cy_week_partial_week_desc_s_EE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE kurz'
 , cy_week_partial_week_desc_s_ES    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES kurz'
 , cy_week_partial_week_desc_s_FI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI kurz'
 , cy_week_partial_week_desc_s_FR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR kurz'
 , cy_week_partial_week_desc_s_GB    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB kurz'
 , cy_week_partial_week_desc_s_GR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR kurz'
 , cy_week_partial_week_desc_s_HR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR kurz'
 , cy_week_partial_week_desc_s_HU    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU kurz'
 , cy_week_partial_week_desc_s_IE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE kurz'
 , cy_week_partial_week_desc_s_IT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT kurz'
 , cy_week_partial_week_desc_s_LT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT kurz'
 , cy_week_partial_week_desc_s_LV    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV kurz'
 , cy_week_partial_week_desc_s_NI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI kurz'
 , cy_week_partial_week_desc_s_NL    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL kurz'
 , cy_week_partial_week_desc_s_DE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE kurz'
 , cy_week_partial_week_desc_s_PL    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL kurz'
 , cy_week_partial_week_desc_s_PT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT kurz'
 , cy_week_partial_week_desc_s_RO    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO kurz'
 , cy_week_partial_week_desc_s_SE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE kurz'
 , cy_week_partial_week_desc_s_SI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI kurz'
 , cy_week_partial_week_desc_s_SK    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK kurz'
 , cy_week_partial_week_desc_s_CS    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS kurz'
 , cy_week_partial_week_desc_s_MT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT kurz'
 , cy_week_partial_week_desc_s_US    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US kurz'
 , cy_week_partial_week_desc_s_RS    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1 kurz'
 , desc_wo_year                      COMMENT 'Default Teilwoche Bezeichnung ohne Geschäftsjahr'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   a.cy_week_partial_week_id1
       , a.cy_week_partial_week_id2
       , a.cy_week_partial_week_id
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_AT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_AT END AS cy_week_partial_week_desc_AT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_BE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_BE END AS cy_week_partial_week_desc_BE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_FR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_FR END AS cy_week_partial_week_desc_BE_FR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_BG || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_BG END AS cy_week_partial_week_desc_BG
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_CH || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_CH END AS cy_week_partial_week_desc_CH
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_CY || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_CY END AS cy_week_partial_week_desc_CY
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_CZ || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_CZ END AS cy_week_partial_week_desc_CZ
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc    || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc    END AS cy_week_partial_week_desc
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_DK || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_DK END AS cy_week_partial_week_desc_DK
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_EE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_EE END AS cy_week_partial_week_desc_EE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_ES || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_ES END AS cy_week_partial_week_desc_ES
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_FI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_FI END AS cy_week_partial_week_desc_FI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_FR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_FR END AS cy_week_partial_week_desc_FR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_GB || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_GB END AS cy_week_partial_week_desc_GB
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_GR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_GR END AS cy_week_partial_week_desc_GR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_HR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_HR END AS cy_week_partial_week_desc_HR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_HU || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_HU END AS cy_week_partial_week_desc_HU
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_IE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_IE END AS cy_week_partial_week_desc_IE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_IT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_IT END AS cy_week_partial_week_desc_IT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_LT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_LT END AS cy_week_partial_week_desc_LT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_LV || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_LV END AS cy_week_partial_week_desc_LV
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_NI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_NI END AS cy_week_partial_week_desc_NI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_NL || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_NL END AS cy_week_partial_week_desc_NL
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_DE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_DE END AS cy_week_partial_week_desc_DE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_PL || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_PL END AS cy_week_partial_week_desc_PL
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_PT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_PT END AS cy_week_partial_week_desc_PT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_RO || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_RO END AS cy_week_partial_week_desc_RO
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_SE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_SE END AS cy_week_partial_week_desc_SE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_SI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_SI END AS cy_week_partial_week_desc_SI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_SK || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_SK END AS cy_week_partial_week_desc_SK
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_CS || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_CS END AS cy_week_partial_week_desc_CS
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_MT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_MT END AS cy_week_partial_week_desc_MT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_US || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_US END AS cy_week_partial_week_desc_US
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_RS || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_RS END AS cy_week_partial_week_desc_RS
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_AT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_AT END AS cy_week_partial_week_desc_s_AT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_BE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_BE END AS cy_week_partial_week_desc_s_BE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_FR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_FR END AS cy_week_partial_week_desc_s_BE_FR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_BG || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_BG END AS cy_week_partial_week_desc_s_BG
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_CH || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_CH END AS cy_week_partial_week_desc_s_CH
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_CY || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_CY END AS cy_week_partial_week_desc_s_CY
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_CZ || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_CZ END AS cy_week_partial_week_desc_s_CZ
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short    || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short    END AS cy_week_partial_week_desc_s
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_DK || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_DK END AS cy_week_partial_week_desc_s_DK
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_EE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_EE END AS cy_week_partial_week_desc_s_EE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_ES || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_ES END AS cy_week_partial_week_desc_s_ES
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_FI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_FI END AS cy_week_partial_week_desc_s_FI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_FR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_FR END AS cy_week_partial_week_desc_s_FR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_GB || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_GB END AS cy_week_partial_week_desc_s_GB
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_GR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_GR END AS cy_week_partial_week_desc_s_GR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_HR || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_HR END AS cy_week_partial_week_desc_s_HR
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_HU || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_HU END AS cy_week_partial_week_desc_s_HU
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_IE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_IE END AS cy_week_partial_week_desc_s_IE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_IT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_IT END AS cy_week_partial_week_desc_s_IT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_LT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_LT END AS cy_week_partial_week_desc_s_LT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_LV || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_LV END AS cy_week_partial_week_desc_s_LV
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_NI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_NI END AS cy_week_partial_week_desc_s_NI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_NL || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_NL END AS cy_week_partial_week_desc_s_NL
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_DE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_DE END AS cy_week_partial_week_desc_s_DE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_PL || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_PL END AS cy_week_partial_week_desc_s_PL
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_PT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_PT END AS cy_week_partial_week_desc_s_PT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_RO || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_RO END AS cy_week_partial_week_desc_s_RO
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_SE || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_SE END AS cy_week_partial_week_desc_s_SE
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_SI || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_SI END AS cy_week_partial_week_desc_s_SI
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_SK || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_SK END AS cy_week_partial_week_desc_s_SK
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_CS || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_CS END AS cy_week_partial_week_desc_s_CS
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_MT || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_MT END AS cy_week_partial_week_desc_s_MT
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_US || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_US END AS cy_week_partial_week_desc_s_US
       , CASE WHEN a.cy_week_partial_week_id2 IN (1, 2) THEN b.cy_week_desc_short_RS || '/' || TRIM(a.cy_week_partial_week_id2) ELSE b.cy_week_desc_short_RS END AS cy_week_partial_week_desc_s_RS
       , SUBSTR(cy_week_partial_week_desc, POSITION(' K' IN cy_week_partial_week_desc)+1, LENGTH(cy_week_partial_week_desc)-POSITION(' K' IN cy_week_partial_week_desc)+1) AS desc_wo_year
  FROM P_LEW_CORE_AC.v_wawi_cal_week_partial_week_1 AS a
 INNER JOIN P_LEW_MART_MSI.v_cal_week_desc_1        AS b
    ON a.cy_week_partial_week_id1 = b.cy_week
 ;
