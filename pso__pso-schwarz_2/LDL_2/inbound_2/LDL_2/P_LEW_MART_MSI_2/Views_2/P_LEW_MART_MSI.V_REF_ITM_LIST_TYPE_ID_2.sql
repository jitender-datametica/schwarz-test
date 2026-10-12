CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_LIST_TYPE_ID_2 COMMENT = 'Multisprache Einlistungstypen Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  listing_type_id         COMMENT 'Einlistungstype Id'
, listing_type_desc_AT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung AT'
, listing_type_desc_BE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE'
, listing_type_desc_BE_FR COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE_FR'
, listing_type_desc_BG    COMMENT 'Einlistungstype Landesspezifische Bezeichnung BG'
, listing_type_desc_CH    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CH'
, listing_type_desc_CY    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CY'
, listing_type_desc_CZ    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CZ'
, listing_type_desc       COMMENT 'Einlistungstype Beschreibung'
, listing_type_desc_DK    COMMENT 'Einlistungstype Landesspezifische Bezeichnung DK'
, listing_type_desc_EE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung EE'
, listing_type_desc_ES    COMMENT 'Einlistungstype Landesspezifische Bezeichnung ES'
, listing_type_desc_FI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung FI'
, listing_type_desc_FR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung FR'
, listing_type_desc_GB    COMMENT 'Einlistungstype Landesspezifische Bezeichnung GB'
, listing_type_desc_GR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung GR'
, listing_type_desc_HR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung HR'
, listing_type_desc_HU    COMMENT 'Einlistungstype Landesspezifische Bezeichnung HU'
, listing_type_desc_IE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung IE'
, listing_type_desc_IT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung IT'
, listing_type_desc_LT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung LT'
, listing_type_desc_LV    COMMENT 'Einlistungstype Landesspezifische Bezeichnung LV'
, listing_type_desc_NI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung NI'
, listing_type_desc_NL    COMMENT 'Einlistungstype Landesspezifische Bezeichnung NL'
, listing_type_desc_DE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung DE'
, listing_type_desc_PL    COMMENT 'Einlistungstype Landesspezifische Bezeichnung PL'
, listing_type_desc_PT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung PT'
, listing_type_desc_RO    COMMENT 'Einlistungstype Landesspezifische Bezeichnung RO'
, listing_type_desc_SE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SE'
, listing_type_desc_SI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SI'
, listing_type_desc_SK    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SK'
, listing_type_desc_CS    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CS'
, listing_type_desc_MT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung MT'
, listing_type_desc_US    COMMENT 'Einlistungstype Landesspezifische Bezeichnung US'
, listing_type_desc_RS    COMMENT 'Einlistungstype Landesspezifische Bezeichnung RS_2'
)
AS
SELECT   listing_type_id
       , MAX(CASE WHEN language_id = 1        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc
       , MAX(CASE WHEN language_id = 8        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_US
       , MAX(CASE WHEN language_id = 34       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_RS
  FROM (
        SELECT   listing_type_id
               , listing_type_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2
       ) AS r
 GROUP BY listing_type_id
;