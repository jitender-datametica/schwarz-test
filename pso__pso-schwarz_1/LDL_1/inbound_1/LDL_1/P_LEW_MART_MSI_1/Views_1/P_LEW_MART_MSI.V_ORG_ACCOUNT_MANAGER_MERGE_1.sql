CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_ACCOUNT_MANAGER_MERGE_1
/*
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  06.08.2020    Roy, Ritanjal               Introduce new country_1 Latviya
#  1.2  27.11.2020    Morris, Michael             Add Column(s) for _BE_fr
#                                                 20200824_2572_trans_NR_FR_corr
#                                                 https://jira.schwarz/browse/REP4-7173
#  1.3  21.12.2021    Morris, Michael             Added Estonia EE
#----------------------------------------------------------------------------
*/
(
    aspect_id
  , client_id
  , wh_id
  , account_manager_id
  , account_manager_name
  , country_cd
  , gl_region_id
  , dat_opening
  , costcenter_cd
  , company
  , order_buying_list_cd
  , vat_region_nr
  , region_cd
  , stock_plain
  , sponsion
  , global_location_nr
  , wh_desc
  , distribute_wh_fg
  , int_fg
  , hq_fg
  , prop_wh_fg
  , sales_wh_fg
  , supp_wh_fg
  , wawi_data_fg
  , ovis_data_fg
  , parent_wh_id
  , buying_region
  , gl_region_desc
  , gl_last_name
  , gl_first_name
  , int_id
  , country_iso_cd
  , country_group_id
  , lisy_sort
  , dashboard_relevant_fg
  , country_desc_AT
  , country_desc_BE
  , country_desc_BE_FR
  , country_desc_BG
  , country_desc_CH
  , country_desc_CY
  , country_desc_CZ
  , country_desc
  , country_desc_DK
  , country_desc_EE
  , country_desc_ES
  , country_desc_FI
  , country_desc_FR
  , country_desc_GB
  , country_desc_GR
  , country_desc_HR
  , country_desc_HU
  , country_desc_IE
  , country_desc_IT
  , country_desc_LT
  , country_desc_LV
  , country_desc_NI
  , country_desc_NL
  , country_desc_DE
  , country_desc_PL
  , country_desc_PT
  , country_desc_RO
  , country_desc_SE
  , country_desc_SI
  , country_desc_SK
  , country_desc_CS
  , country_desc_MT
  , country_desc_US
  , country_desc_RS
  , country_opening_date
)
AS
SELECT   aspect_id
       , client_id
       , wh_id
       , account_manager_id
       , account_manager_name
       , country_cd
       , gl_region_id
       , dat_opening
       , costcenter_cd
       , company
       , order_buying_list_cd
       , vat_region_nr
       , region_cd
       , stock_plain
       , sponsion
       , global_location_nr
       , wh_desc
       , distribute_wh_fg
       , int_fg
       , hq_fg
       , prop_wh_fg
       , sales_wh_fg
       , supp_wh_fg
       , wawi_data_fg
       , ovis_data_fg
       , parent_wh_id
       , buying_region
       , gl_region_desc
       , gl_last_name
       , gl_first_name
       , int_id
       , country_iso_cd
       , country_group_id
       , lisy_sort
       , dashboard_relevant_fg
       , country_desc_AT
       , country_desc_BE
       , country_desc_FR AS country_desc_BE_FR
       , country_desc_BG
       , country_desc_CH
       , country_desc_CY
       , country_desc_CZ
       , country_desc
       , country_desc_DK
       , country_desc_EE
       , country_desc_ES
       , country_desc_FI
       , country_desc_FR
       , country_desc_GB
       , country_desc_GR
       , country_desc_HR
       , country_desc_HU
       , country_desc_IE
       , country_desc_IT
       , country_desc_LT
       , country_desc_LV
       , country_desc_NI
       , country_desc_NL
       , country_desc_DE
       , country_desc_PL
       , country_desc_PT
       , country_desc_RO
       , country_desc_SE
       , country_desc_SI
       , country_desc_SK
       , country_desc_CS
       , country_desc_MT
       , country_desc_US
       , country_desc_RS
       , country_opening_date
FROM     P_LEW_MART_MSI.t_org_account_manager_merge_1
;