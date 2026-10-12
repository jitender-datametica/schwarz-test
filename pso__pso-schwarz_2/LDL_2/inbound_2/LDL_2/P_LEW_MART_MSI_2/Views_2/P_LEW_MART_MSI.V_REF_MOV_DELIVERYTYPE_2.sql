CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_MOV_DELIVERYTYPE_2 COMMENT = 'Multisprache Anlieferarten Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  13.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id               COMMENT 'Landeskennzeichen'
, deliverytype_id         COMMENT 'Anlieferart - Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten'
, deliverytype_desc_AT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung AT'
, deliverytype_desc_BE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung BE'
, deliverytype_desc_BE_FR COMMENT 'Anlieferart - Landesspezifische Bezeichnung BE_FR'
, deliverytype_desc_BG    COMMENT 'Anlieferart - Landesspezifische Bezeichnung BG'
, deliverytype_desc_CH    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CH'
, deliverytype_desc_CY    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CY'
, deliverytype_desc_CZ    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CZ'
, deliverytype_desc       COMMENT 'Anlieferart - Bezeichnung'
, deliverytype_desc_DK    COMMENT 'Anlieferart - Landesspezifische Bezeichnung DK'
, deliverytype_desc_EE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung EE'
, deliverytype_desc_ES    COMMENT 'Anlieferart - Landesspezifische Bezeichnung ES'
, deliverytype_desc_FI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung FI'
, deliverytype_desc_FR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung FR'
, deliverytype_desc_GB    COMMENT 'Anlieferart - Landesspezifische Bezeichnung GB'
, deliverytype_desc_GR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung GR'
, deliverytype_desc_HR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung HR'
, deliverytype_desc_HU    COMMENT 'Anlieferart - Landesspezifische Bezeichnung HU'
, deliverytype_desc_IE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung IE'
, deliverytype_desc_IT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung IT'
, deliverytype_desc_LT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung LT'
, deliverytype_desc_LV    COMMENT 'Anlieferart - Landesspezifische Bezeichnung LV'
, deliverytype_desc_NI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung NI'
, deliverytype_desc_NL    COMMENT 'Anlieferart - Landesspezifische Bezeichnung NL'
, deliverytype_desc_DE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung DE'
, deliverytype_desc_PL    COMMENT 'Anlieferart - Landesspezifische Bezeichnung PL'
, deliverytype_desc_PT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung PT'
, deliverytype_desc_RO    COMMENT 'Anlieferart - Landesspezifische Bezeichnung RO'
, deliverytype_desc_SE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SE'
, deliverytype_desc_SI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SI'
, deliverytype_desc_SK    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SK'
, deliverytype_desc_CS    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CS'
, deliverytype_desc_MT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung MT'
, deliverytype_desc_US    COMMENT 'Anlieferart - Landesspezifische Bezeichnung US'
, deliverytype_desc_RS    COMMENT 'Anlieferart - Landesspezifische Bezeichnung RS_2'
)
AS
SELECT   client_id
       , deliverytype_id
       , MAX(CASE WHEN language_id = 1  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc
       , MAX(CASE WHEN language_id = 8  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_US
       , MAX(CASE WHEN language_id = 34 THEN deliverytype_desc ELSE NULL END ) AS deliverytype_desc_RS
  FROM (
        SELECT   rmd.client_id
               , rmd.deliverytype_id
               , rmd.deliverytype_desc
               , rmd.language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_mov_deliverytype_2 AS rmd
       ) AS x

 GROUP BY   client_id
          , deliverytype_id
;