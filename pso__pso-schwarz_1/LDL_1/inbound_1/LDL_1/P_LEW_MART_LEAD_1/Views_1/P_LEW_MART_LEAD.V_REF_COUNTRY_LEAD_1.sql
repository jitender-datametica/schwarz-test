CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_COUNTRY_LEAD_1 COMMENT = 'Lead project : Country_1 lead reference view'
/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 06.08.2020 Roy,Ritanjal           Introduce new country_1 LV
#  1.2 03.01.2022 Morris, Michael        Added Estonia EE
#
#----------------------------------------------------------------------------
*/
(
  int_id                 COMMENT 'Lidl International ID'
, country_id             COMMENT 'Landeskennzeichen'
, country_iso_cd         COMMENT 'Landeskürzel'
, country_group_id       COMMENT 'Landesgruppen Kennzeichen'
, lisy_sort              COMMENT 'lisy sort Wert'
, dashboard_relevant_fg  COMMENT 'Dashboardrelevant'
, country_desc_AT        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung AT'
, country_desc_BE        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung BE'
, country_desc_BG        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung BG'
, country_desc_CH        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CH'
, country_desc_CY        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CY'
, country_desc_CZ        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CZ'
, country_desc           COMMENT 'Filial-Land_1 Bezeichnung'
, country_desc_DK        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung DK'
, country_desc_EE        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung EE'
, country_desc_ES        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung ES'
, country_desc_FI        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung FI'
, country_desc_FR        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung FR'
, country_desc_GB        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung GB'
, country_desc_GR        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung GR'
, country_desc_HR        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung HR'
, country_desc_HU        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung HU'
, country_desc_IE        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung IE'
, country_desc_IT        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung IT'
, country_desc_LT        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung LT'
, country_desc_LV        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung LV'
, country_desc_NI        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung NI'
, country_desc_NL        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung NL'
, country_desc_DE        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung DE'
, country_desc_PL        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung PL'
, country_desc_PT        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung PT'
, country_desc_RO        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung RO'
, country_desc_SE        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SE'
, country_desc_SI        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SI'
, country_desc_SK        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SK'
, country_desc_CS        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CS'
, country_desc_MT        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung MT'
, country_desc_US        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung US'
, country_desc_RS        COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung RS_1'
)
AS
SELECT   cn.int_id
       , cn.country_id                                           /* Buchungskreis/ Nummer des Landes             */
       , cn.country_iso_cd                                       /* Landeskürzel                                */
       , COALESCE(skey.country_group_id, 99) AS country_group_id /* techn. Schlüssel für die Vorstandsregion   */
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
              WHEN cn.country_id = 20 THEN 32   WHEN cn.country_id = 9  THEN 33
              ELSE 99
          END AS lisy_sort                                       /* Festgelegter Schlüssel zur Sortierung der Länder */
       , cn.dashboard_relevant_fg                                /* fÃ¼r Lead - Dashbaord relevant                   */
       , MAX(CASE WHEN cn.language_id =  1 THEN cn.country_desc ELSE NULL END) AS country_desc_AT
       , MAX(CASE WHEN cn.language_id =  2 THEN cn.country_desc ELSE NULL END) AS country_desc_BE
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
  FROM P_LEW_CORE_AC.v_wawi_ref_country_act_1            AS cn
  LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_client_skey_1 AS skey
    ON cn.country_id = skey.client_id

 GROUP BY   cn.int_id
          , cn.country_id
          , cn.country_iso_cd
          , skey.country_group_id
          , lisy_sort
          , cn.dashboard_relevant_fg
;