CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CLIENT COMMENT = 'Multi language Client/Country descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  06.08.2020    Roy,Ritanjal             Introducing new country Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  21.12.2021    Morris, Michael          Add Estonia EE
#-----------------------------------------------------------------------------
*/
(
  int_id            COMMENT 'Lidl International ID'
, client_id         COMMENT 'Landeskennzeichen'
, country_id        COMMENT 'Landeskennzeichen'
, client_desc_AT    COMMENT 'Landesspezifische Bezeichnung des Landes AT'
, client_desc_BE    COMMENT 'Landesspezifische Bezeichnung des Landes BE'
, client_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung des Landes BE_FR'
, client_desc_BG    COMMENT 'Landesspezifische Bezeichnung des Landes BG'
, client_desc_CH    COMMENT 'Landesspezifische Bezeichnung des Landes CH'
, client_desc_CY    COMMENT 'Landesspezifische Bezeichnung des Landes CY'
, client_desc_CZ    COMMENT 'Landesspezifische Bezeichnung des Landes CZ'
, client_desc       COMMENT 'Bezeichnung des Landes'
, client_desc_DK    COMMENT 'Landesspezifische Bezeichnung des Landes DK'
, client_desc_EE    COMMENT 'Landesspezifische Bezeichnung des Landes EE'
, client_desc_ES    COMMENT 'Landesspezifische Bezeichnung des Landes ES'
, client_desc_FI    COMMENT 'Landesspezifische Bezeichnung des Landes FI'
, client_desc_FR    COMMENT 'Landesspezifische Bezeichnung des Landes FR'
, client_desc_GB    COMMENT 'Landesspezifische Bezeichnung des Landes GB'
, client_desc_GR    COMMENT 'Landesspezifische Bezeichnung des Landes GR'
, client_desc_HR    COMMENT 'Landesspezifische Bezeichnung des Landes HR'
, client_desc_HU    COMMENT 'Landesspezifische Bezeichnung des Landes HU'
, client_desc_IE    COMMENT 'Landesspezifische Bezeichnung des Landes IE'
, client_desc_IT    COMMENT 'Landesspezifische Bezeichnung des Landes IT'
, client_desc_LT    COMMENT 'Landesspezifische Bezeichnung des Landes LT'
, client_desc_LV    COMMENT 'Landesspezifische Bezeichnung des Landes LV'
, client_desc_NI    COMMENT 'Landesspezifische Bezeichnung des Landes NI'
, client_desc_NL    COMMENT 'Landesspezifische Bezeichnung des Landes NL'
, client_desc_DE    COMMENT 'Landesspezifische Bezeichnung des Landes DE'
, client_desc_PL    COMMENT 'Landesspezifische Bezeichnung des Landes PL'
, client_desc_PT    COMMENT 'Landesspezifische Bezeichnung des Landes PT'
, client_desc_RO    COMMENT 'Landesspezifische Bezeichnung des Landes RO'
, client_desc_SE    COMMENT 'Landesspezifische Bezeichnung des Landes SE'
, client_desc_SI    COMMENT 'Landesspezifische Bezeichnung des Landes SI'
, client_desc_SK    COMMENT 'Landesspezifische Bezeichnung des Landes SK'
, client_desc_CS    COMMENT 'Landesspezifische Bezeichnung des Landes CS'
, client_desc_MT    COMMENT 'Landesspezifische Bezeichnung des Landes MT'
, client_desc_US    COMMENT 'Landesspezifische Bezeichnung des Landes US'
, client_desc_RS    COMMENT 'Landesspezifische Bezeichnung des Landes RS'
)
AS
SELECT   1 AS int_id
       , client_id  /* techn. Schlüssel zur Referenzierung des Landes    */
       , country_id /* Referenzierung des Landes                         */
       , MAX(CASE WHEN language_id = 1  THEN client_desc ELSE NULL END ) AS client_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN client_desc ELSE NULL END ) AS client_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN client_desc ELSE NULL END ) AS client_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN client_desc ELSE NULL END ) AS client_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN client_desc ELSE NULL END ) AS client_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN client_desc ELSE NULL END ) AS client_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN client_desc ELSE NULL END ) AS client_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN client_desc ELSE NULL END ) AS client_desc     /* ""Stiftungssprache"" - Deutsch   */
       , MAX(CASE WHEN language_id = 8  THEN client_desc ELSE NULL END ) AS client_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN client_desc ELSE NULL END ) AS client_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN client_desc ELSE NULL END ) AS client_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN client_desc ELSE NULL END ) AS client_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN client_desc ELSE NULL END ) AS client_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN client_desc ELSE NULL END ) AS client_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN client_desc ELSE NULL END ) AS client_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN client_desc ELSE NULL END ) AS client_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN client_desc ELSE NULL END ) AS client_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN client_desc ELSE NULL END ) AS client_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN client_desc ELSE NULL END ) AS client_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN client_desc ELSE NULL END ) AS client_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN client_desc ELSE NULL END ) AS client_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN client_desc ELSE NULL END ) AS client_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN client_desc ELSE NULL END ) AS client_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN client_desc ELSE NULL END ) AS client_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN client_desc ELSE NULL END ) AS client_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN client_desc ELSE NULL END ) AS client_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN client_desc ELSE NULL END ) AS client_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN client_desc ELSE NULL END ) AS client_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN client_desc ELSE NULL END ) AS client_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN client_desc ELSE NULL END ) AS client_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN client_desc ELSE NULL END ) AS client_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN client_desc ELSE NULL END ) AS client_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN client_desc ELSE NULL END ) AS client_desc_US
       , MAX(CASE WHEN language_id = 34 THEN client_desc ELSE NULL END ) AS client_desc_RS
  FROM (
       SELECT   1            AS int_id
              , client_id    AS client_id
              , language_id  AS language_id
              , client_id    AS country_id
              , client_desc  AS client_desc
         FROM P_LEW_CORE_AC.v_wawi_ref_client_desc
       ) AS x

  GROUP BY   1
           , client_id
           , country_id
;