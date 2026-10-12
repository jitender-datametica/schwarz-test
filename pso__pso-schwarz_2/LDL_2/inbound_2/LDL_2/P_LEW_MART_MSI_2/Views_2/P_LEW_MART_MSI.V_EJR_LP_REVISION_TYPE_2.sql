CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_REVISION_TYPE_2
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  12.10.2017    Meister,Ulrich view adjusted due to changes in x_bdo_coex_view w w
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.5  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.6  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
AS
SELECT   revision_type_id
       , MAX(CASE WHEN language_id = 1        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc
       , MAX(CASE WHEN language_id = 8        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_US
       , MAX(CASE WHEN language_id = 34       THEN revision_type_desc ELSE NULL END ) AS revision_type_desc_RS
  FROM P_LEW_MART_MSI.t_msi_ejr_lp_revision_type_2
 GROUP BY  revision_type_id
;