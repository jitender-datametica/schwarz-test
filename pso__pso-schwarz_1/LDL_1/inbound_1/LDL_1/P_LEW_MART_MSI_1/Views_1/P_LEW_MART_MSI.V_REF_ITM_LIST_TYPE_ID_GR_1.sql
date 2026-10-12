CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_LIST_TYPE_ID_GR_1 COMMENT = 'Multisprache Einlistungstype Gruppen Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  06.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.3  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.4  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  listing_type_group_id         COMMENT 'Guppe Einlistungstype Id'
, listing_type_group_desc_AT    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung AT'
, listing_type_group_desc_BE    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung BE'
, listing_type_group_desc_BE_FR COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung BE_FR'
, listing_type_group_desc_BG    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung BG'
, listing_type_group_desc_CH    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung CH'
, listing_type_group_desc_CY    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung CY'
, listing_type_group_desc_CZ    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung CZ'
, listing_type_group_desc       COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung'
, listing_type_group_desc_DK    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung DK'
, listing_type_group_desc_EE    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung EE'
, listing_type_group_desc_ES    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung ES'
, listing_type_group_desc_FI    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung FI'
, listing_type_group_desc_FR    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung FR'
, listing_type_group_desc_GB    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung GB'
, listing_type_group_desc_GR    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung GR'
, listing_type_group_desc_HR    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung HR'
, listing_type_group_desc_HU    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung HU'
, listing_type_group_desc_IE    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung IE'
, listing_type_group_desc_IT    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung IT'
, listing_type_group_desc_LT    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung LT'
, listing_type_group_desc_LV    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung LV'
, listing_type_group_desc_NI    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung NI'
, listing_type_group_desc_NL    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung NL'
, listing_type_group_desc_DE    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung DE'
, listing_type_group_desc_PL    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung PL'
, listing_type_group_desc_PT    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung PT'
, listing_type_group_desc_RO    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung RO'
, listing_type_group_desc_SE    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung SE'
, listing_type_group_desc_SI    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung SI'
, listing_type_group_desc_SK    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung SK'
, listing_type_group_desc_CS    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung CS'
, listing_type_group_desc_MT    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung MT'
, listing_type_group_desc_US    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung US'
, listing_type_group_desc_RS    COMMENT 'Gruppe_1 Einlistungstype Landesspezifische Bezeichnung RS_1'
)
AS
SELECT   listing_type_group_id
       , MAX(CASE WHEN language_id = 1        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc
       , MAX(CASE WHEN language_id = 8        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_US
       , MAX(CASE WHEN language_id = 34       THEN listing_type_group_desc ELSE NULL END ) AS listing_type_group_desc_RS
  FROM (
        SELECT   listing_type_group_id
               , listing_type_group_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_1
       ) AS r
 GROUP BY   listing_type_group_id
;