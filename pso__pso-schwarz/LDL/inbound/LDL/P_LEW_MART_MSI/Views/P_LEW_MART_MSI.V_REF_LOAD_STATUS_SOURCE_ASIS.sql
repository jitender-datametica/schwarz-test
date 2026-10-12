CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_LOAD_STATUS_SOURCE_ASIS
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  08.11.2017    Toth,Gabriel             Angepasst, bessere language handling
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  19.04.2018    Proch,Marika             Update auf neue Core Tabelle
#  1.5  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.6  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.7  03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  source_id
, source_desc_AT
, source_desc_BE
, source_desc_BE_FR
, source_desc_BG
, source_desc_CH
, source_desc_CY
, source_desc_CZ
, source_desc
, source_desc_DK
, source_desc_EE
, source_desc_ES
, source_desc_FI
, source_desc_FR
, source_desc_GB
, source_desc_GR
, source_desc_HR
, source_desc_HU
, source_desc_IE
, source_desc_IT
, source_desc_LT
, source_desc_LV
, source_desc_NI
, source_desc_NL
, source_desc_DE
, source_desc_PL
, source_desc_PT
, source_desc_RO
, source_desc_SE
, source_desc_SI
, source_desc_SK
, source_desc_CS
, source_desc_MT
, source_desc_US
, source_desc_RS
, mod_tmsp
)
AS
SELECT   source_id
       , COALESCE(MAX(CASE WHEN language_id = 1  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_AT
       , COALESCE(MAX(CASE WHEN language_id = 2  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_BE
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_BE_FR
       , COALESCE(MAX(CASE WHEN language_id = 3  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_BG
       , COALESCE(MAX(CASE WHEN language_id = 4  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_CH
       , COALESCE(MAX(CASE WHEN language_id = 5  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_CY
       , COALESCE(MAX(CASE WHEN language_id = 6  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_CZ
       , COALESCE(MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc
       , COALESCE(MAX(CASE WHEN language_id = 8  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_DK
       , COALESCE(MAX(CASE WHEN language_id = 9  THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_EE
       , COALESCE(MAX(CASE WHEN language_id IN (10,31) THEN source_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_ES
       , COALESCE(MAX(CASE WHEN language_id = 11 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_FI
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_FR
       , COALESCE(MAX(CASE WHEN language_id = 13 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_GB
       , COALESCE(MAX(CASE WHEN language_id IN (14,5) THEN source_desc ELSE NULL END )  , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_GR
       , COALESCE(MAX(CASE WHEN language_id = 15 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_HR
       , COALESCE(MAX(CASE WHEN language_id = 16 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_HU
       , COALESCE(MAX(CASE WHEN language_id IN (17,21) THEN source_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_IE
       , COALESCE(MAX(CASE WHEN language_id IN (18,32) THEN source_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_IT
       , COALESCE(MAX(CASE WHEN language_id = 19 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_LT
       , COALESCE(MAX(CASE WHEN language_id = 20 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_LV
       , COALESCE(MAX(CASE WHEN language_id = 21 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_NI
       , COALESCE(MAX(CASE WHEN language_id = 22 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_NL
       , COALESCE(MAX(CASE WHEN language_id = 23 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_DE
       , COALESCE(MAX(CASE WHEN language_id = 24 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_PL
       , COALESCE(MAX(CASE WHEN language_id = 25 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_PT
       , COALESCE(MAX(CASE WHEN language_id = 26 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_RO
       , COALESCE(MAX(CASE WHEN language_id = 27 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_SE
       , COALESCE(MAX(CASE WHEN language_id = 28 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_SI
       , COALESCE(MAX(CASE WHEN language_id = 29 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_SK
       , COALESCE(MAX(CASE WHEN language_id = 31 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_CS
       , COALESCE(MAX(CASE WHEN language_id = 32 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_MT
       , COALESCE(MAX(CASE WHEN language_id = 33 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_US
       , COALESCE(MAX(CASE WHEN language_id = 34 THEN source_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN source_desc ELSE NULL END )) AS source_desc_RS
       , MAX(mod_tmsp) mod_tmsp
  FROM P_LEW_CORE_AC.v_wawi_ref_load_status_source_asis
  GROUP BY source_id
;