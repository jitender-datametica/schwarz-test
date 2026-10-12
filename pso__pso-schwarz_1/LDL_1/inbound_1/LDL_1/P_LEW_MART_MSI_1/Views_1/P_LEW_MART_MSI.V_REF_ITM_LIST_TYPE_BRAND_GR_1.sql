CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_LIST_TYPE_BRAND_GR_1 COMMENT = 'Multisprache Markenartgruppen Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1..  06.08.2020    Roy, Ritanjal            Introduce new country_1 Latviya
#  1.3  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.4  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  brand_type_group_id         COMMENT 'Guppen Markenart ID'
, brand_type_group_desc_AT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  AT'
, brand_type_group_desc_BE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BE'
, brand_type_group_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BE_FR'
, brand_type_group_desc_BG    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BG'
, brand_type_group_desc_CH    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CH'
, brand_type_group_desc_CY    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CY'
, brand_type_group_desc_CZ    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CZ'
, brand_type_group_desc       COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart'
, brand_type_group_desc_DK    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  DK'
, brand_type_group_desc_EE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  EE'
, brand_type_group_desc_ES    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  ES'
, brand_type_group_desc_FI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  FI'
, brand_type_group_desc_FR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  FR'
, brand_type_group_desc_GB    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  GB'
, brand_type_group_desc_GR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  GR'
, brand_type_group_desc_HR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  HR'
, brand_type_group_desc_HU    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  HU'
, brand_type_group_desc_IE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  IE'
, brand_type_group_desc_IT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  IT'
, brand_type_group_desc_LT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  LT'
, brand_type_group_desc_LV    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  LV'
, brand_type_group_desc_NI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  NI'
, brand_type_group_desc_NL    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  NL'
, brand_type_group_desc_DE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  DE'
, brand_type_group_desc_PL    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  PL'
, brand_type_group_desc_PT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  PT'
, brand_type_group_desc_RO    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  RO'
, brand_type_group_desc_SE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SE'
, brand_type_group_desc_SI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SI'
, brand_type_group_desc_SK    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SK'
, brand_type_group_desc_CS    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CS'
, brand_type_group_desc_MT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  MT'
, brand_type_group_desc_US    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  US'
, brand_type_group_desc_RS    COMMENT 'Landesspezifische Bezeichnung der Gruppe_1 der Markenart  RS_1'
)
AS
SELECT   brand_type_group_id
       , MAX(CASE WHEN language_id = 1        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc
       , MAX(CASE WHEN language_id = 8        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_US
       , MAX(CASE WHEN language_id = 34       THEN brand_type_group_desc ELSE NULL END ) AS brand_type_group_desc_RS
  FROM (
        SELECT   brand_type_group_id
               , brand_type_group_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_1
       ) AS r
 GROUP BY brand_type_group_id
;