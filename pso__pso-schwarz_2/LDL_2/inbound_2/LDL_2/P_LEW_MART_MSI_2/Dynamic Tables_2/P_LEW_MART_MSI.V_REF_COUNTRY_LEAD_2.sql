
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_COUNTRY_LEAD_2 COMMENT = 'Lead Project - Multi language Country_2 reference'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  06.08.2020    Roy, Ritanjal            Introduce new country_2 Latviya
#  1.4  20.12.2021    Morris, Michael          Add Columns for Estonia EE & BE_fr
#  1.5  23.08.2024    Malec, Marcin            Added column vs_sort, with an additional country_2 sorting logic; User Story 665161
#----------------------------------------------------------------------------
*/
(
  int_id                COMMENT 'Lidl International ID'
, country_id            COMMENT 'Landeskennzeichen'
, country_iso_cd        COMMENT 'Landes ISO Code'
, country_group_id      COMMENT 'Cluster ID'
, lisy_sort             COMMENT 'Lisy Sort Wert'
, vs_sort               COMMENT 'VS_2 sort'
, dashboard_relevant_fg COMMENT 'Dashboeard relevant Flag'
, country_desc_AT       COMMENT 'Landesspezifische Bezeichnung des Landes AT'
, country_desc_BE       COMMENT 'Landesspezifische Bezeichnung des Landes BE'
, country_desc_BE_FR    COMMENT 'Landesspezifische Bezeichnung des Landes BE_FR'
, country_desc_BG       COMMENT 'Landesspezifische Bezeichnung des Landes BG'
, country_desc_CH       COMMENT 'Landesspezifische Bezeichnung des Landes CH'
, country_desc_CY       COMMENT 'Landesspezifische Bezeichnung des Landes CY'
, country_desc_CZ       COMMENT 'Landesspezifische Bezeichnung des Landes CZ'
, country_desc          COMMENT 'Bezeichnung des Landes'
, country_desc_DK       COMMENT 'Landesspezifische Bezeichnung des Landes DK'
, country_desc_EE       COMMENT 'Landesspezifische Bezeichnung des Landes EE'
, country_desc_ES       COMMENT 'Landesspezifische Bezeichnung des Landes ES'
, country_desc_FI       COMMENT 'Landesspezifische Bezeichnung des Landes FI'
, country_desc_FR       COMMENT 'Landesspezifische Bezeichnung des Landes FR'
, country_desc_GB       COMMENT 'Landesspezifische Bezeichnung des Landes GB'
, country_desc_GR       COMMENT 'Landesspezifische Bezeichnung des Landes GR'
, country_desc_HR       COMMENT 'Landesspezifische Bezeichnung des Landes HR'
, country_desc_HU       COMMENT 'Landesspezifische Bezeichnung des Landes HU'
, country_desc_IE       COMMENT 'Landesspezifische Bezeichnung des Landes IE'
, country_desc_IT       COMMENT 'Landesspezifische Bezeichnung des Landes IT'
, country_desc_LT       COMMENT 'Landesspezifische Bezeichnung des Landes LT'
, country_desc_LV       COMMENT 'Landesspezifische Bezeichnung des Landes LV'
, country_desc_NI       COMMENT 'Landesspezifische Bezeichnung des Landes NI'
, country_desc_NL       COMMENT 'Landesspezifische Bezeichnung des Landes NL'
, country_desc_DE       COMMENT 'Landesspezifische Bezeichnung des Landes DE'
, country_desc_PL       COMMENT 'Landesspezifische Bezeichnung des Landes PL'
, country_desc_PT       COMMENT 'Landesspezifische Bezeichnung des Landes PT'
, country_desc_RO       COMMENT 'Landesspezifische Bezeichnung des Landes RO'
, country_desc_SE       COMMENT 'Landesspezifische Bezeichnung des Landes SE'
, country_desc_SI       COMMENT 'Landesspezifische Bezeichnung des Landes SI'
, country_desc_SK       COMMENT 'Landesspezifische Bezeichnung des Landes SK'
, country_desc_CS       COMMENT 'Landesspezifische Bezeichnung des Landes CS'
, country_desc_MT       COMMENT 'Landesspezifische Bezeichnung des Landes MT'
, country_desc_US       COMMENT 'Landesspezifische Bezeichnung des Landes US'
, country_desc_RS       COMMENT 'Landesspezifische Bezeichnung des Landes RS_2'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   cn.int_id
       , cn.country_id                                           /* Buchungskreis/ Nummer des Landes            */
       , cn.country_iso_cd                                       /* Landeskürzel                                */
       , COALESCE(skey.country_group_id, 99) AS country_group_id /* techn. Schlüssel für die Vorstandsregion    */
       , CASE WHEN cn.country_id = 23 THEN  1   WHEN cn.country_id = 12 THEN  2   WHEN cn.country_id = 18 THEN  3
              WHEN cn.country_id = 32 THEN  4   WHEN cn.country_id =  1 THEN  5   WHEN cn.country_id = 14 THEN  6
              WHEN cn.country_id =  5 THEN  7   WHEN cn.country_id = 10 THEN  8   WHEN cn.country_id = 31 THEN  9
              WHEN cn.country_id =  2 THEN 10   WHEN cn.country_id = 25 THEN 12   WHEN cn.country_id = 22 THEN 13
              WHEN cn.country_id =  4 THEN 14   WHEN cn.country_id = 19 THEN 15   WHEN cn.country_id = 13 THEN 16
              WHEN cn.country_id = 17 THEN 17   WHEN cn.country_id = 21 THEN 18   WHEN cn.country_id = 11 THEN 19
              WHEN cn.country_id = 27 THEN 20   WHEN cn.country_id =  8 THEN 21   WHEN cn.country_id = 33 THEN 22
              WHEN cn.country_id = 24 THEN 23   WHEN cn.country_id =  6 THEN 24   WHEN cn.country_id = 29 THEN 25
              WHEN cn.country_id = 16 THEN 26   WHEN cn.country_id = 15 THEN 27   WHEN cn.country_id = 28 THEN 28
              WHEN cn.country_id = 26 THEN 29   WHEN cn.country_id =  3 THEN 30   WHEN cn.country_id = 34 THEN 31
              WHEN cn.country_id = 20 THEN 32   WHEN cn.country_id =  9 THEN 33
              ELSE 99
          END                                                                  AS lisy_sort /* Festgelegter Schlüssel zur Sortierung der Länder     */
       , CASE WHEN cn.country_id = 23 THEN 1    WHEN cn.country_id = 12 THEN 2    WHEN cn.country_id = 13 THEN 3
              WHEN cn.country_id = 24 THEN 4    WHEN cn.country_id = 33 THEN 5    WHEN cn.country_id = 18 THEN 6
              WHEN cn.country_id = 32 THEN 7    WHEN cn.country_id = 10 THEN 8    WHEN cn.country_id = 31 THEN 9
              WHEN cn.country_id = 25 THEN 10   WHEN cn.country_id = 1  THEN 11   WHEN cn.country_id = 14 THEN 12
              WHEN cn.country_id = 5  THEN 13   WHEN cn.country_id = 4  THEN 14   WHEN cn.country_id = 22 THEN 15
              WHEN cn.country_id = 2  THEN 16   WHEN cn.country_id = 11 THEN 17   WHEN cn.country_id = 27 THEN 18
              WHEN cn.country_id = 17 THEN 19   WHEN cn.country_id = 21 THEN 20   WHEN cn.country_id = 8  THEN 21
              WHEN cn.country_id = 19 THEN 22   WHEN cn.country_id = 20 THEN 23   WHEN cn.country_id = 9  THEN 24
              WHEN cn.country_id = 26 THEN 25   WHEN cn.country_id = 6  THEN 26   WHEN cn.country_id = 16 THEN 27
              WHEN cn.country_id = 29 THEN 28   WHEN cn.country_id = 3  THEN 29   WHEN cn.country_id = 15 THEN 30
              WHEN cn.country_id = 34 THEN 31   WHEN cn.country_id = 28 THEN 32
              ELSE 99
          END                                                                  AS vs_sort /* Festgelegter Schlüssel zur andere Sortierung der Länder  */
       , cn.dashboard_relevant_fg                                                           /* für Lead - Dashbaord relevant                        */
       , MAX(CASE WHEN cn.language_id =  1 THEN cn.country_desc ELSE NULL END) AS country_desc_AT
       , MAX(CASE WHEN cn.language_id =  2 THEN cn.country_desc ELSE NULL END) AS country_desc_BE
       , MAX(CASE WHEN cn.language_id = 12 THEN cn.country_desc ELSE NULL END) AS country_desc_BE_FR
       , MAX(CASE WHEN cn.language_id =  3 THEN cn.country_desc ELSE NULL END) AS country_desc_BG
       , MAX(CASE WHEN cn.language_id =  4 THEN cn.country_desc ELSE NULL END) AS country_desc_CH
       , MAX(CASE WHEN cn.language_id =  5 THEN cn.country_desc ELSE NULL END) AS country_desc_CY
       , MAX(CASE WHEN cn.language_id =  6 THEN cn.country_desc ELSE NULL END) AS country_desc_CZ
       , MAX(CASE WHEN cn.language_id =  7 THEN cn.country_desc ELSE NULL END) AS country_desc
       , MAX(CASE WHEN cn.language_id =  8 THEN cn.country_desc ELSE NULL END) AS country_desc_DK
       , MAX(CASE WHEN cn.language_id =  9 THEN cn.country_desc ELSE NULL END) AS country_desc_EE
       , MAX(CASE WHEN cn.language_id = 10 THEN cn.country_desc ELSE NULL END) AS country_desc_ES
       , MAX(CASE WHEN cn.language_id = 11 THEN cn.country_desc ELSE NULL END) AS country_desc_FI
       , MAX(CASE WHEN cn.language_id = 12 THEN cn.country_desc ELSE NULL END) AS country_desc_FR
       , MAX(CASE WHEN cn.language_id = 13 THEN cn.country_desc ELSE NULL END) AS country_desc_GB
       , MAX(CASE WHEN cn.language_id = 14 THEN cn.country_desc ELSE NULL END) AS country_desc_GR
       , MAX(CASE WHEN cn.language_id = 15 THEN cn.country_desc ELSE NULL END) AS country_desc_HR
       , MAX(CASE WHEN cn.language_id = 16 THEN cn.country_desc ELSE NULL END) AS country_desc_HU
       , MAX(CASE WHEN cn.language_id = 17 THEN cn.country_desc ELSE NULL END) AS country_desc_IE
       , MAX(CASE WHEN cn.language_id = 18 THEN cn.country_desc ELSE NULL END) AS country_desc_IT
       , MAX(CASE WHEN cn.language_id = 19 THEN cn.country_desc ELSE NULL END) AS country_desc_LT
       , MAX(CASE WHEN cn.language_id = 20 THEN cn.country_desc ELSE NULL END) AS country_desc_LV
       , MAX(CASE WHEN cn.language_id = 21 THEN cn.country_desc ELSE NULL END) AS country_desc_NI
       , MAX(CASE WHEN cn.language_id = 22 THEN cn.country_desc ELSE NULL END) AS country_desc_NL
       , MAX(CASE WHEN cn.language_id = 23 THEN cn.country_desc ELSE NULL END) AS country_desc_DE
       , MAX(CASE WHEN cn.language_id = 24 THEN cn.country_desc ELSE NULL END) AS country_desc_PL
       , MAX(CASE WHEN cn.language_id = 25 THEN cn.country_desc ELSE NULL END) AS country_desc_PT
       , MAX(CASE WHEN cn.language_id = 26 THEN cn.country_desc ELSE NULL END) AS country_desc_RO
       , MAX(CASE WHEN cn.language_id = 27 THEN cn.country_desc ELSE NULL END) AS country_desc_SE
       , MAX(CASE WHEN cn.language_id = 28 THEN cn.country_desc ELSE NULL END) AS country_desc_SI
       , MAX(CASE WHEN cn.language_id = 29 THEN cn.country_desc ELSE NULL END) AS country_desc_SK
       , MAX(CASE WHEN cn.language_id = 31 THEN cn.country_desc ELSE NULL END) AS country_desc_CS
       , MAX(CASE WHEN cn.language_id = 32 THEN cn.country_desc ELSE NULL END) AS country_desc_MT
       , MAX(CASE WHEN cn.language_id = 33 THEN cn.country_desc ELSE NULL END) AS country_desc_US
       , MAX(CASE WHEN cn.language_id = 34 THEN cn.country_desc ELSE NULL END) AS country_desc_RS
    FROM P_LEW_CORE_AC.v_wawi_ref_country_act_2            AS cn
    LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_client_skey_2 AS skey
      ON cn.country_id = skey.client_id
   GROUP BY   cn.int_id
            , cn.country_id
            , cn.country_iso_cd
            , skey.country_group_id
            , lisy_sort
            , vs_sort
            , cn.dashboard_relevant_fg
;
