CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_LOAD_STATUS_KPI_ASIS_2
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Toth,Gabriel             Neugeneriert
#  1.2  08.11.2017    Toth,Gabriel             Angepasst, bessere language handling
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  11.04.2018    Proch,Marika             Neue Basistabelle im Core
#  1.6  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.7  18.11.2020    Yasin,Meme               Change Group By DWHA-248 Patch 2665
#  1.8  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.9  29.03.2021    Morris, Michael          Correct GROUP BY cluase to named columns
#                                              20210330_2796_corr_2572
#                                              https://jira.schwarz/browse/REP4-8912
#  1.10 03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
        kpi_id
      , kpi_group_id
      , kpi_desc_AT
      , kpi_desc_BE
      , kpi_desc_BE_FR
      , kpi_desc_BG
      , kpi_desc_CH
      , kpi_desc_CY
      , kpi_desc_CZ
      , kpi_desc
      , kpi_desc_DK
      , kpi_desc_EE
      , kpi_desc_ES
      , kpi_desc_FI
      , kpi_desc_FR
      , kpi_desc_GB
      , kpi_desc_GR
      , kpi_desc_HR
      , kpi_desc_HU
      , kpi_desc_IE
      , kpi_desc_IT
      , kpi_desc_LT
      , kpi_desc_LV
      , kpi_desc_NI
      , kpi_desc_NL
      , kpi_desc_DE
      , kpi_desc_PL
      , kpi_desc_PT
      , kpi_desc_RO
      , kpi_desc_SE
      , kpi_desc_SI
      , kpi_desc_SK
      , kpi_desc_CS
      , kpi_desc_MT
      , kpi_desc_US
      , kpi_desc_RS
      , kpi_short_desc_AT
      , kpi_short_desc_BE
      , kpi_short_desc_BE_FR
      , kpi_short_desc_BG
      , kpi_short_desc_CH
      , kpi_short_desc_CY
      , kpi_short_desc_CZ
      , kpi_short_desc
      , kpi_short_desc_DK
      , kpi_short_desc_EE
      , kpi_short_desc_ES
      , kpi_short_desc_FI
      , kpi_short_desc_FR
      , kpi_short_desc_GB
      , kpi_short_desc_GR
      , kpi_short_desc_HR
      , kpi_short_desc_HU
      , kpi_short_desc_IE
      , kpi_short_desc_IT
      , kpi_short_desc_LT
      , kpi_short_desc_LV
      , kpi_short_desc_NI
      , kpi_short_desc_NL
      , kpi_short_desc_DE
      , kpi_short_desc_PL
      , kpi_short_desc_PT
      , kpi_short_desc_RO
      , kpi_short_desc_SE
      , kpi_short_desc_SI
      , kpi_short_desc_SK
      , kpi_short_desc_CS
      , kpi_short_desc_MT
      , kpi_short_desc_US
      , kpi_short_desc_RS
      , kpi_source_id
      , kpi_level_cd
      , kpi_sort_rank
      , mod_tmsp
)
AS
SELECT   kpi_id
       , kpi_group_id
       , COALESCE(MAX(CASE WHEN language_id = 1  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_AT
       , COALESCE(MAX(CASE WHEN language_id = 2  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_BE
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_BE_FR
       , COALESCE(MAX(CASE WHEN language_id = 3  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_BG
       , COALESCE(MAX(CASE WHEN language_id = 4  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_CH
       , COALESCE(MAX(CASE WHEN language_id = 5  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_CY
       , COALESCE(MAX(CASE WHEN language_id = 6  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_CZ
       , COALESCE(MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc
       , COALESCE(MAX(CASE WHEN language_id = 8  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_DK
       , COALESCE(MAX(CASE WHEN language_id = 9  THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_EE
       , COALESCE(MAX(CASE WHEN language_id IN (10,31) THEN kpi_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_ES
       , COALESCE(MAX(CASE WHEN language_id = 11 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_FI
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_FR
       , COALESCE(MAX(CASE WHEN language_id = 13 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_GB
       , COALESCE(MAX(CASE WHEN language_id IN (14,5) THEN kpi_desc ELSE NULL END )        , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_GR
       , COALESCE(MAX(CASE WHEN language_id = 15 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_HR
       , COALESCE(MAX(CASE WHEN language_id = 16 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_HU
       , COALESCE(MAX(CASE WHEN language_id IN (17,21) THEN kpi_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_IE
       , COALESCE(MAX(CASE WHEN language_id IN (18,32) THEN kpi_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_IT
       , COALESCE(MAX(CASE WHEN language_id = 19 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_LT
       , COALESCE(MAX(CASE WHEN language_id = 20 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_LV
       , COALESCE(MAX(CASE WHEN language_id = 21 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_NI
       , COALESCE(MAX(CASE WHEN language_id = 22 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_NL
       , COALESCE(MAX(CASE WHEN language_id = 23 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_DE
       , COALESCE(MAX(CASE WHEN language_id = 24 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_PL
       , COALESCE(MAX(CASE WHEN language_id = 25 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_PT
       , COALESCE(MAX(CASE WHEN language_id = 26 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_RO
       , COALESCE(MAX(CASE WHEN language_id = 27 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_SE
       , COALESCE(MAX(CASE WHEN language_id = 28 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_SI
       , COALESCE(MAX(CASE WHEN language_id = 29 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_SK
       , COALESCE(MAX(CASE WHEN language_id = 31 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_CS
       , COALESCE(MAX(CASE WHEN language_id = 32 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_MT
       , COALESCE(MAX(CASE WHEN language_id = 33 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_US
       , COALESCE(MAX(CASE WHEN language_id = 34 THEN kpi_desc ELSE NULL END )             , MAX(CASE WHEN language_id = 7  THEN kpi_desc ELSE NULL END )) AS kpi_desc_RS
       , COALESCE(MAX(CASE WHEN language_id = 1  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_AT
       , COALESCE(MAX(CASE WHEN language_id = 2  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_BE
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_BE_FR
       , COALESCE(MAX(CASE WHEN language_id = 3  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_BG
       , COALESCE(MAX(CASE WHEN language_id = 4  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_CH
       , COALESCE(MAX(CASE WHEN language_id = 5  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_CY
       , COALESCE(MAX(CASE WHEN language_id = 6  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_CZ
       , COALESCE(MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc
       , COALESCE(MAX(CASE WHEN language_id = 8  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_DK
       , COALESCE(MAX(CASE WHEN language_id = 9  THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_EE
       , COALESCE(MAX(CASE WHEN language_id IN (10,31) THEN kpi_short_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_ES
       , COALESCE(MAX(CASE WHEN language_id = 11 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_FI
       , COALESCE(MAX(CASE WHEN language_id = 12 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_FR
       , COALESCE(MAX(CASE WHEN language_id = 13 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_GB
       , COALESCE(MAX(CASE WHEN language_id IN (14,5) THEN kpi_short_desc ELSE NULL END )  , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_GR
       , COALESCE(MAX(CASE WHEN language_id = 15 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_HR
       , COALESCE(MAX(CASE WHEN language_id = 16 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_HU
       , COALESCE(MAX(CASE WHEN language_id IN (17,21) THEN kpi_short_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_IE
       , COALESCE(MAX(CASE WHEN language_id IN (18,32) THEN kpi_short_desc ELSE NULL END ) , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_IT
       , COALESCE(MAX(CASE WHEN language_id = 19 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_LT
       , COALESCE(MAX(CASE WHEN language_id = 20 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_LV
       , COALESCE(MAX(CASE WHEN language_id = 21 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_NI
       , COALESCE(MAX(CASE WHEN language_id = 22 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_NL
       , COALESCE(MAX(CASE WHEN language_id = 23 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_DE
       , COALESCE(MAX(CASE WHEN language_id = 24 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_PL
       , COALESCE(MAX(CASE WHEN language_id = 25 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_PT
       , COALESCE(MAX(CASE WHEN language_id = 26 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_RO
       , COALESCE(MAX(CASE WHEN language_id = 27 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_SE
       , COALESCE(MAX(CASE WHEN language_id = 28 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_SI
       , COALESCE(MAX(CASE WHEN language_id = 29 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_SK
       , COALESCE(MAX(CASE WHEN language_id = 31 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_CS
       , COALESCE(MAX(CASE WHEN language_id = 32 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_MT
       , COALESCE(MAX(CASE WHEN language_id = 33 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_US
       , COALESCE(MAX(CASE WHEN language_id = 34 THEN kpi_short_desc ELSE NULL END )       , MAX(CASE WHEN language_id = 7  THEN kpi_short_desc ELSE NULL END )) AS kpi_short_desc_RS
       , kpi_source_id
       , kpi_level_cd
       , kpi_sort_rank
       , MAX(mod_tmsp) mod_tmsp
  FROM P_LEW_CORE_AC.v_wawi_ref_load_status_kpi_asis_2
 GROUP BY   kpi_id
          , kpi_group_id
          , kpi_source_id
          , kpi_level_cd
          , kpi_sort_rank
;