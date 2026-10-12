CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_MAINITEMGROUP_2 COMMENT='Multi language Mainitek Bezeichnungen'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  08.06.2020    Roy,Ritanjal             Release 2.3
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  14.05.2021    Roy, Ritanjal            Introduce Estonia
#----------------------------------------------------------------------------
*/
(
  mainitemgroup_id               COMMENT 'WAWI Quellschluessel'
, mainitemgroup_desc_AT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit AT'
, mainitemgroup_desc_BE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BE'
, mainitemgroup_desc_BE_FR       COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BE_FR'
, mainitemgroup_desc_BG          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BG'
, mainitemgroup_desc_CH          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CH'
, mainitemgroup_desc_CY          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CY'
, mainitemgroup_desc_CZ          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CZ'
, mainitemgroup_desc             COMMENT 'Mainitek generische Bezeichnung'
, mainitemgroup_desc_DK          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit DK'
, mainitemgroup_desc_EE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit EE'
, mainitemgroup_desc_ES          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit ES'
, mainitemgroup_desc_FI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit FI'
, mainitemgroup_desc_FR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit FR'
, mainitemgroup_desc_GB          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit GB'
, mainitemgroup_desc_GR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit GR'
, mainitemgroup_desc_HR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit HR'
, mainitemgroup_desc_HU          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit HU'
, mainitemgroup_desc_IE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit IE'
, mainitemgroup_desc_IT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit IT'
, mainitemgroup_desc_LT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit LT'
, mainitemgroup_desc_LV          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit LV'
, mainitemgroup_desc_NI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit NI'
, mainitemgroup_desc_NL          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit NL'
, mainitemgroup_desc_DE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit DE'
, mainitemgroup_desc_PL          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit PL'
, mainitemgroup_desc_PT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit PT'
, mainitemgroup_desc_RO          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit RO'
, mainitemgroup_desc_SE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SE'
, mainitemgroup_desc_SI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SI'
, mainitemgroup_desc_SK          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SK'
, mainitemgroup_desc_CS          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CS'
, mainitemgroup_desc_MT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit MT'
, mainitemgroup_desc_US          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit US'
, mainitemgroup_desc_RS          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit RS_2'
, mainitemgroup_short_desc_AT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit AT'
, mainitemgroup_short_desc_BE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BE'
, mainitemgroup_short_desc_BE_FR COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BE_FR'
, mainitemgroup_short_desc_BG    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BG'
, mainitemgroup_short_desc_CH    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CH'
, mainitemgroup_short_desc_CY    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CY'
, mainitemgroup_short_desc_CZ    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CZ'
, mainitemgroup_short_desc       COMMENT 'Mainitek generische Kurzbezeichnung'
, mainitemgroup_short_desc_DK    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit DK'
, mainitemgroup_short_desc_EE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit EE'
, mainitemgroup_short_desc_ES    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit ES'
, mainitemgroup_short_desc_FI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit FI'
, mainitemgroup_short_desc_FR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit FR'
, mainitemgroup_short_desc_GB    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit GB'
, mainitemgroup_short_desc_GR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit GR'
, mainitemgroup_short_desc_HR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit HR'
, mainitemgroup_short_desc_HU    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit HU'
, mainitemgroup_short_desc_IE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit IE'
, mainitemgroup_short_desc_IT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit IT'
, mainitemgroup_short_desc_LT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit LT'
, mainitemgroup_short_desc_LV    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit LV'
, mainitemgroup_short_desc_NI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit NI'
, mainitemgroup_short_desc_NL    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit NL'
, mainitemgroup_short_desc_DE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit DE'
, mainitemgroup_short_desc_PL    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit PL'
, mainitemgroup_short_desc_PT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit PT'
, mainitemgroup_short_desc_RO    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit RO'
, mainitemgroup_short_desc_SE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SE'
, mainitemgroup_short_desc_SI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SI'
, mainitemgroup_short_desc_SK    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SK'
, mainitemgroup_short_desc_CS    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CS'
, mainitemgroup_short_desc_MT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit MT'
, mainitemgroup_short_desc_US    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit US'
, mainitemgroup_short_desc_RS    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit RS_2'
)
AS
SELECT   mainitemgroup_id
       , MAX(CASE WHEN language_id = 1  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc
       , MAX(CASE WHEN language_id = 8  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_US
       , MAX(CASE WHEN language_id = 34 THEN mainitemgroup_desc       ELSE NULL END ) AS mainitemgroup_desc_RS
       , MAX(CASE WHEN language_id = 1  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc
       , MAX(CASE WHEN language_id = 8  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_US
       , MAX(CASE WHEN language_id = 34 THEN mainitemgroup_short_desc ELSE NULL END ) AS mainitemgroup_short_desc_RS
  FROM (
        SELECT   mig.mainitemgroup_id
               , mig.language_id
               , MAX(mig.mainitemgroup_desc)       AS mainitemgroup_desc
               , MAX(mig.mainitemgroup_short_desc) AS mainitemgroup_short_desc
          FROM P_LEW_CORE_AC.v_wawi_itm_mainitemgroup_2 mig

         WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
         GROUP BY   mig.mainitemgroup_id
                  , mig.language_id
       ) AS x

 GROUP BY mainitemgroup_id
;