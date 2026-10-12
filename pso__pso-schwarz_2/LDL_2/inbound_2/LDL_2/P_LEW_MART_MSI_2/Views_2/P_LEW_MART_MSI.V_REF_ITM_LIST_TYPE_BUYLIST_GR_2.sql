CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_LIST_TYPE_BUYLIST_GR_2 COMMENT = 'Multisprache Gruppen der Artikelarten Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.1  08.06.2020    Roy,Ritanjal             Introduce new country_2 latviya
#  1.2  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.3  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  buying_list_type_group_id         COMMENT 'Gruppe_2 der Art_2 des Artikels ( Saison, ... )'
, buying_list_type_group_desc_AT    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels AT'
, buying_list_type_group_desc_BE    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE'
, buying_list_type_group_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE_FR'
, buying_list_type_group_desc_BG    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BG'
, buying_list_type_group_desc_CH    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CH'
, buying_list_type_group_desc_CY    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CY'
, buying_list_type_group_desc_CZ    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CZ'
, buying_list_type_group_desc       COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ( Saison, ... )'
, buying_list_type_group_desc_DK    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DK'
, buying_list_type_group_desc_EE    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels EE'
, buying_list_type_group_desc_ES    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ES'
, buying_list_type_group_desc_FI    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FI'
, buying_list_type_group_desc_FR    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FR'
, buying_list_type_group_desc_GB    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels GB'
, buying_list_type_group_desc_GR    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DG'
, buying_list_type_group_desc_HR    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HR'
, buying_list_type_group_desc_HU    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HU'
, buying_list_type_group_desc_IE    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IE'
, buying_list_type_group_desc_IT    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IT'
, buying_list_type_group_desc_LT    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LT'
, buying_list_type_group_desc_LV    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LV'
, buying_list_type_group_desc_NI    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NI'
, buying_list_type_group_desc_NL    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NL'
, buying_list_type_group_desc_DE    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DE'
, buying_list_type_group_desc_PL    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PL'
, buying_list_type_group_desc_PT    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PT'
, buying_list_type_group_desc_RO    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RO'
, buying_list_type_group_desc_SE    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SE'
, buying_list_type_group_desc_SI    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SI'
, buying_list_type_group_desc_SK    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SK'
, buying_list_type_group_desc_CS    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CS'
, buying_list_type_group_desc_MT    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels MT'
, buying_list_type_group_desc_US    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels US'
, buying_list_type_group_desc_RS    COMMENT 'Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RS_2'
)
AS
SELECT   buying_list_type_group_id
       , MAX(CASE WHEN language_id = 1        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc
       , MAX(CASE WHEN language_id = 8        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_US
       , MAX(CASE WHEN language_id = 34       THEN buying_list_type_group_desc ELSE NULL END ) AS buying_list_type_group_desc_RS
  FROM (
        SELECT   buying_list_type_group_id
               , buying_list_type_group_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2
       ) AS r
 GROUP BY buying_list_type_group_id
;