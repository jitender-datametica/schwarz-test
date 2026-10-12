CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_LOGIST_UNIT_1 COMMENT = 'Multisprache Logistikeinheiten Referenz'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  30.03.2021    Morris, Michael          logistic_unit_desc_BE_fr changed to language_id = 2
#                                              20210329_2796_corr_2572
#                                              https://jira.schwarz/browse/REP4-8912
#  1.6  21.12.2021    Morris, Michael          Added Estonia EE
#  1.7  11.10.2022    Cyganska, Malgorzata     Fix for NSR3175073, AD: 393250
#----------------------------------------------------------------------------
*/
(
  logistic_unit_cd         COMMENT 'Kennz. Einheit (Liter, Kilo etc)'
, client_id                COMMENT 'Landeskennzeichen'
, logistic_unit_desc_AT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit AT'
, logistic_unit_desc_BE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BE'
, logistic_unit_desc_BE_FR COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BE_FR'
, logistic_unit_desc_BG    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BG'
, logistic_unit_desc_CH    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CH'
, logistic_unit_desc_CY    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CY'
, logistic_unit_desc_CZ    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CZ'
, logistic_unit_desc       COMMENT 'Bezinh Einheit'
, logistic_unit_desc_DK    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit DK'
, logistic_unit_desc_EE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit EE'
, logistic_unit_desc_ES    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit ES'
, logistic_unit_desc_FI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit FI'
, logistic_unit_desc_FR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit FR'
, logistic_unit_desc_GB    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit GB'
, logistic_unit_desc_GR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit GR'
, logistic_unit_desc_HR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit HR'
, logistic_unit_desc_HU    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit HU'
, logistic_unit_desc_IE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit IE'
, logistic_unit_desc_IT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit IT'
, logistic_unit_desc_LT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit LT'
, logistic_unit_desc_LV    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit LV'
, logistic_unit_desc_NI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit NI'
, logistic_unit_desc_NL    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit NL'
, logistic_unit_desc_DE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit DE'
, logistic_unit_desc_PL    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit PL'
, logistic_unit_desc_PT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit PT'
, logistic_unit_desc_RO    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit RO'
, logistic_unit_desc_SE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SE'
, logistic_unit_desc_SI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SI'
, logistic_unit_desc_SK    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SK'
, logistic_unit_desc_CS    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CS'
, logistic_unit_desc_MT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit MT'
, logistic_unit_desc_US    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit US'
, logistic_unit_desc_RS    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit RS_1'
, logistic_base_unit       COMMENT 'Logistik Basiseinheit (1kg)'
, logistic_base_factor     COMMENT 'Logistik Basisfaktor (1000)'
, logistic_base_unit_int   COMMENT 'Logistik Internationale Einheit (g)'
, logistic_base_factor_int COMMENT 'Logistik Internationaler faktor (1000)'
)
AS
SELECT   logistic_unit_cd
       , client_id
       , MAX(CASE WHEN language_id = 1         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_AT
       , MAX(CASE WHEN language_id = 2         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_BE
       , MAX(CASE WHEN language_id = 12        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_BE_FR
       , MAX(CASE WHEN language_id = 3         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_BG
       , MAX(CASE WHEN language_id = 4         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_CH
       , MAX(CASE WHEN language_id = 5         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_CY
       , MAX(CASE WHEN language_id = 6         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_CZ
       , MAX(CASE WHEN language_id = 7         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc
       , MAX(CASE WHEN language_id = 8         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_DK
       , MAX(CASE WHEN language_id = 9         THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_EE
       , MAX(CASE WHEN language_id = 10        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_ES
       , MAX(CASE WHEN language_id = 11        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_FI
       , MAX(CASE WHEN language_id = 12        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_FR
       , MAX(CASE WHEN language_id = 13        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_GB
       , MAX(CASE WHEN language_id = 14        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_GR
       , MAX(CASE WHEN language_id = 15        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_HR
       , MAX(CASE WHEN language_id = 16        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_HU
       , MAX(CASE WHEN language_id IN (17, 21) THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_IE
       , MAX(CASE WHEN language_id = 18        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_IT
       , MAX(CASE WHEN language_id = 19        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_LT
       , MAX(CASE WHEN language_id = 20        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_LV
       , MAX(CASE WHEN language_id IN (17, 21) THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_NI
       , MAX(CASE WHEN language_id = 22        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_NL
       , MAX(CASE WHEN language_id = 23        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_DE
       , MAX(CASE WHEN language_id = 24        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_PL
       , MAX(CASE WHEN language_id = 25        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_PT
       , MAX(CASE WHEN language_id = 26        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_RO
       , MAX(CASE WHEN language_id = 27        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_SE
       , MAX(CASE WHEN language_id = 28        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_SI
       , MAX(CASE WHEN language_id = 29        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_SK
       , MAX(CASE WHEN language_id = 31        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_CS
       , MAX(CASE WHEN language_id = 32        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_MT
       , MAX(CASE WHEN language_id = 33        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_US
       , MAX(CASE WHEN language_id = 34        THEN logistic_unit_desc ELSE NULL END ) AS logistic_unit_desc_RS
       , logistic_base_unit
       , logistic_base_factor
       , logistic_base_unit_int
       , logistic_base_factor_int
  FROM (
        SELECT   r.logistic_unit_cd
               , r.client_id
               , r.logistic_unit_desc
               , r.language_id
               , r.logistic_base_unit
               , r.logistic_base_factor
               , r.logistic_base_unit_int
               , r.logistic_base_factor_int
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_logist_unit_1 AS r
       ) AS x

 GROUP BY   logistic_unit_cd
          , client_id
          , logistic_base_unit
          , logistic_base_factor
          , logistic_base_unit_int
          , logistic_base_factor_int
;



