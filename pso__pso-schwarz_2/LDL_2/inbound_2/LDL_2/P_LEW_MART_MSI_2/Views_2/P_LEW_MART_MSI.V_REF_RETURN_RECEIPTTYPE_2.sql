CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_RETURN_RECEIPTTYPE_2 COMMENT = 'Multi language return receipt type reference'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  06.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.3  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.4  03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  return_receipttype_id         COMMENT 'Return_k Bez. Einheit id'
, return_receipttype_desc_AT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit AT'
, return_receipttype_desc_BE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BE'
, return_receipttype_desc_BE_FR COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BE_FR'
, return_receipttype_desc_BG    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BG'
, return_receipttype_desc_CH    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CH'
, return_receipttype_desc_CY    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CY'
, return_receipttype_desc_CZ    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CZ'
, return_receipttype_desc       COMMENT 'Return_k Bez. Einheit desc'
, return_receipttype_desc_DK    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit DK'
, return_receipttype_desc_EE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit EE'
, return_receipttype_desc_ES    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit ES'
, return_receipttype_desc_FI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit FI'
, return_receipttype_desc_FR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit FR'
, return_receipttype_desc_GB    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit GB'
, return_receipttype_desc_GR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit GR'
, return_receipttype_desc_HR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit HR'
, return_receipttype_desc_HU    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit HU'
, return_receipttype_desc_IE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit IE'
, return_receipttype_desc_IT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit IT'
, return_receipttype_desc_LT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit LT'
, return_receipttype_desc_LV    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit LV'
, return_receipttype_desc_NI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit NI'
, return_receipttype_desc_NL    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit NL'
, return_receipttype_desc_DE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit DE'
, return_receipttype_desc_PL    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit PL'
, return_receipttype_desc_PT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit PT'
, return_receipttype_desc_RO    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit RO'
, return_receipttype_desc_SE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SE'
, return_receipttype_desc_SI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SI'
, return_receipttype_desc_SK    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SK'
, return_receipttype_desc_CS    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CS'
, return_receipttype_desc_MT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit MT'
, return_receipttype_desc_US    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit US'
, return_receipttype_desc_RS    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit RS_2'
)
AS
SELECT   return_receipttype_id
       , MAX(CASE WHEN language_id = 1        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc
       , MAX(CASE WHEN language_id = 8        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_US
       , MAX(CASE WHEN language_id = 34       THEN return_receipttype_desc ELSE NULL END ) AS return_receipttype_desc_RS
  FROM (
        SELECT   return_receipttype_id
               , return_receipttype_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_return_receipttype_2
       ) AS r
 GROUP BY return_receipttype_id
;