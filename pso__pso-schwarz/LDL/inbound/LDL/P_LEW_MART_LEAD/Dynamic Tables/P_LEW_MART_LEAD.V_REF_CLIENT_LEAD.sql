CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_REF_CLIENT_LEAD COMMENT = 'Lead project : Client lead reference view'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  2018-01-29  Deepak Kumar Purseth   Initial version - DDL for Abshiften
#                                          20180328_1631_QuickView_BR_Client_View
#  1.1  2018-10-09  J. Graeff              20181009_1854_RS_Korrektur_Landesnamen
#                                          correct US and RS value for country_opening_date
#  1.3  07.08.2020  Roy,Ritanjal           Introduce new country Latviya
#  1.4  03.01.2022  Morris, Michael        Added Estonia EE
#  1.5  23.08.2024  Malec, Marcin          Added column vs_sort, with an additional country sorting logic; User Story 665161
#----------------------------------------------------------------------------
*/
(
  int_id                COMMENT 'Lidl International ID'
, client_id             COMMENT 'Mandant'
, country_iso_cd        COMMENT 'Landeskürzel'
, country_group_id      COMMENT 'Landesgruppen Kennzeichen'
, lisy_sort             COMMENT 'lisy sort'
, vs_sort               COMMENT 'VS sort'
, dashboard_relevant_fg COMMENT 'Dashboardrelevant'
, country_desc_AT       COMMENT 'Filial-Land Landesspezifische Bezeichnung AT'
, country_desc_BE       COMMENT 'Filial-Land Landesspezifische Bezeichnung BE'
, country_desc_BG       COMMENT 'Filial-Land Landesspezifische Bezeichnung BG'
, country_desc_CH       COMMENT 'Filial-Land Landesspezifische Bezeichnung CH'
, country_desc_CY       COMMENT 'Filial-Land Landesspezifische Bezeichnung CY'
, country_desc_CZ       COMMENT 'Filial-Land Landesspezifische Bezeichnung CZ'
, country_desc          COMMENT 'Filial-Land Landesspezifische Bezeichnung'
, country_desc_DK       COMMENT 'Filial-Land Landesspezifische Bezeichnung DK'
, country_desc_EE       COMMENT 'Filial-Land Landesspezifische Bezeichnung EE'
, country_desc_ES       COMMENT 'Filial-Land Landesspezifische Bezeichnung ES'
, country_desc_FI       COMMENT 'Filial-Land Landesspezifische Bezeichnung FI'
, country_desc_FR       COMMENT 'Filial-Land Landesspezifische Bezeichnung FR'
, country_desc_GB       COMMENT 'Filial-Land Landesspezifische Bezeichnung GB'
, country_desc_GR       COMMENT 'Filial-Land Landesspezifische Bezeichnung GR'
, country_desc_HR       COMMENT 'Filial-Land Landesspezifische Bezeichnung HR'
, country_desc_HU       COMMENT 'Filial-Land Landesspezifische Bezeichnung HU'
, country_desc_IE       COMMENT 'Filial-Land Landesspezifische Bezeichnung IE'
, country_desc_IT       COMMENT 'Filial-Land Landesspezifische Bezeichnung IT'
, country_desc_LT       COMMENT 'Filial-Land Landesspezifische Bezeichnung LT'
, country_desc_LV       COMMENT 'Filial-Land Landesspezifische Bezeichnung LV'
, country_desc_NI       COMMENT 'Filial-Land Landesspezifische Bezeichnung NI'
, country_desc_NL       COMMENT 'Filial-Land Landesspezifische Bezeichnung NL'
, country_desc_DE       COMMENT 'Filial-Land Landesspezifische Bezeichnung DE'
, country_desc_PL       COMMENT 'Filial-Land Landesspezifische Bezeichnung PL'
, country_desc_PT       COMMENT 'Filial-Land Landesspezifische Bezeichnung PT'
, country_desc_RO       COMMENT 'Filial-Land Landesspezifische Bezeichnung RO'
, country_desc_SE       COMMENT 'Filial-Land Landesspezifische Bezeichnung SE'
, country_desc_SI       COMMENT 'Filial-Land Landesspezifische Bezeichnung SI'
, country_desc_SK       COMMENT 'Filial-Land Landesspezifische Bezeichnung SK'
, country_desc_CS       COMMENT 'Filial-Land Landesspezifische Bezeichnung CS'
, country_desc_MT       COMMENT 'Filial-Land Landesspezifische Bezeichnung MT'
, country_desc_US       COMMENT 'Filial-Land Landesspezifische Bezeichnung US'
, country_desc_RS       COMMENT 'Filial-Land Landesspezifische Bezeichnung RS'
, country_opening_date  COMMENT 'Eröffnungsdatum Land'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT   cn.int_id
       , cn.country_id                                           /* Buchungskreis/ Nummer des Landes             */
       , cn.country_iso_cd                                       /* Landeskürzel                                 */
       , COALESCE(skey.country_group_id, 99) AS country_group_id /* techn. Schlüssel für die Vorstandsregion     */
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
          END AS lisy_sort                                       /* Festgelegter Schlüssel zur Sortierung der Länder  */
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
          END AS vs_sort                                       /* Festgelegter Schlüssel zur andere Sortierung der Länder  */
       , cn.dashboard_relevant_fg                                /* für Lead - Dashbaord relevant                    */
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
       , CASE cn.country_id WHEN 23 THEN '1973'
                            WHEN 12 THEN '04/1989'
                            WHEN 18 THEN '03/1992'
                            WHEN 10 THEN '04/1994'
                            WHEN 13 THEN '11/1994'
                            WHEN  2 THEN '04/1995'
                            WHEN 25 THEN '07/1995'
                            WHEN 22 THEN '10/1997'
                            WHEN  1 THEN '11/1998'
                            WHEN 21 THEN '05/1999'
                            WHEN 20 THEN '01/2020'
                            WHEN 14 THEN '06/1999'
                            WHEN 17 THEN '07/2000'
                            WHEN 24 THEN '04/2002'
                            WHEN 11 THEN '08/2002'
                            WHEN  6 THEN '06/2003'
                            WHEN 27 THEN '09/2003'
                            WHEN 29 THEN '09/2004'
                            WHEN 16 THEN '11/2004'
                            WHEN  8 THEN '09/2005'
                            WHEN 15 THEN '11/2006'
                            WHEN 28 THEN '03/2007'
                            WHEN 32 THEN '04/2008'
                            WHEN  4 THEN '03/2009'
                            WHEN 31 THEN '02/2010'
                            WHEN 26 THEN '01/2010'
                            WHEN  3 THEN '01/2010'
                            WHEN  5 THEN '11/2010'
                            WHEN 19 THEN '03/2016'
                            WHEN 33 THEN '01/2017'
                            WHEN 34 THEN '03/2018'
                            WHEN 9 THEN  '03/2022'
                            ELSE '01/1900'
          END                                               AS country_opening_date
  FROM P_LEW_CORE_AC.v_wawi_ref_country_act            AS cn
  LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_client_skey AS skey
    ON cn.country_id = skey.client_id
 GROUP BY   cn.int_id
          , cn.country_id
          , cn.country_iso_cd
          , skey.country_group_id
          , lisy_sort
          , vs_sort
          , cn.dashboard_relevant_fg
;
