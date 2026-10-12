CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_SUB_ACTIONGROUP_DESC
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.3  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.4  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
    client_id
  , item_sub_actiongroup_id
  , item_actiongroup_id
  , dat_valid_from
  , dat_valid_until
  , item_sub_actgroup_desc_AT
  , item_sub_actgroup_desc_BE
  , item_sub_actgroup_desc_BE_FR
  , item_sub_actgroup_desc_BG
  , item_sub_actgroup_desc_CH
  , item_sub_actgroup_desc_CY
  , item_sub_actgroup_desc_CZ
  , item_sub_actgroup_desc
  , item_sub_actgroup_desc_DK
  , item_sub_actgroup_desc_EE
  , item_sub_actgroup_desc_ES
  , item_sub_actgroup_desc_FI
  , item_sub_actgroup_desc_FR
  , item_sub_actgroup_desc_GB
  , item_sub_actgroup_desc_GR
  , item_sub_actgroup_desc_HR
  , item_sub_actgroup_desc_HU
  , item_sub_actgroup_desc_IE
  , item_sub_actgroup_desc_IT
  , item_sub_actgroup_desc_LT
  , item_sub_actgroup_desc_LV
  , item_sub_actgroup_desc_NI
  , item_sub_actgroup_desc_NL
  , item_sub_actgroup_desc_DE
  , item_sub_actgroup_desc_PL
  , item_sub_actgroup_desc_PT
  , item_sub_actgroup_desc_RO
  , item_sub_actgroup_desc_SE
  , item_sub_actgroup_desc_SI
  , item_sub_actgroup_desc_SK
  , item_sub_actgroup_desc_CS
  , item_sub_actgroup_desc_MT
  , item_sub_actgroup_desc_US
  , item_sub_actgroup_desc_RS
)
AS
SELECT   client_id
       , item_sub_actiongroup_id
       , item_actiongroup_id
       , dat_valid_from
       , dat_valid_until
       , MAX(CASE WHEN language_id = 1  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_BE
       , MAX(CASE WHEN language_id = 2  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc
       , MAX(CASE WHEN language_id = 8  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_US
       , MAX(CASE WHEN language_id = 34 THEN item_sub_actgroup_desc ELSE NULL END ) AS item_sub_actgroup_desc_RS
  FROM (
        SELECT   client_id
               , item_sub_actiongroup_id
               , item_actiongroup_id
               , item_sub_actgroup_desc
               , dat_valid_from
               , dat_valid_until
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_itm_actiongroup_desc

         WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
         GROUP BY 1,2,3,4,5,6,7
        ) AS x

 GROUP BY   client_id
          , item_sub_actiongroup_id
          , item_actiongroup_id
          , dat_valid_from
          , dat_valid_until
;