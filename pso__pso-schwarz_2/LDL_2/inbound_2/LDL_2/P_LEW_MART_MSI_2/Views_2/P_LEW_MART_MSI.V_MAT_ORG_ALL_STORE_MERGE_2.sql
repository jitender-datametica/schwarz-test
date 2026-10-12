CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_ALL_STORE_MERGE_2
AS
/*
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur         Initiliazation
#  1.1  06.08.2020    Roy,Ritanjal             Introducing new country_2 Latviya
#  1.2  24.03.2021    Rodrigo Cione            Added modernization date columns:
#                                              dat_modernization_from and dat_modernization_to
#                                              https://jira.schwarz/browse/REP2-9234
#  1.3  17.12.2021    Michael Morris           Added Estonia EE
#----------------------------------------------------------------------------
*/
SELECT   aSM.aspect_id
       , aSM.client_id
       , aSM.move_to_store_id
       , aSM.move_store_desc
       , aSM.wh_id
       , aSM.wh_id_exp
       , aSM.sales_manager_id
       , aSM.dat_closing_ovis
       , aSM.dat_opening_ovis
       , aSM.mis_store_active_fg
       , aSM.dat_opening
       , aSM.dat_closing
       , aSM.orig_store_nr
       , aSM.dat_calc_start_py
       , aSM.dat_calc_end_py
       , aSM.objectstatus_id
       , aSM.dat_calc_start_ppy
       , aSM.move_fg
       , aSM.street
       , aSM.zipcode
       , aSM.city
       , aSM.phone
       , aSM.longitude
       , aSM.latitude
       , aSM.dat_modernization_from
       , aSM.dat_modernization_to
       , COALESCE(sMM.account_manager_id, -1335) AS account_manager_id
       , sMM.sales_manager_name
       , aMM.account_manager_name
       , wME.country_cd
       , COALESCE(wME.gl_region_id, -1335)       AS gl_region_id
       , wME.costcenter_cd
       , wME.company
       , wME.order_buying_list_cd
       , wME.vat_region_nr
       , wME.region_cd
       , wME.stock_plain
       , wME.sponsion
       , wME.global_location_nr
       , wME.wh_desc
       , wME.distribute_wh_fg
       , wME.int_fg
       , wME.hq_fg
       , wME.prop_wh_fg
       , wME.sales_wh_fg
       , wME.supp_wh_fg
       , wME.wawi_data_fg
       , wME.ovis_data_fg
       , wME.parent_wh_id
       , wME.buying_region
       , rME.gl_region_desc
       , rME.gl_last_name
       , rME.gl_first_name
       , COALESCE(cLE.int_id, -1335) AS int_id
       , cLE.country_iso_cd
       , cLE.country_group_id
       , cLE.lisy_sort
       , cLE.dashboard_relevant_fg
       , cLE.country_desc_AT
       , cLE.country_desc_BE
       , cLE.country_desc_BG
       , cLE.country_desc_CH
       , cLE.country_desc_CY
       , cLE.country_desc_CZ
       , cLE.country_desc
       , cLE.country_desc_DK
       , cLE.country_desc_EE
       , cLE.country_desc_ES
       , cLE.country_desc_FI
       , cLE.country_desc_FR
       , cLE.country_desc_GB
       , cLE.country_desc_GR
       , cLE.country_desc_HR
       , cLE.country_desc_HU
       , cLE.country_desc_IE
       , cLE.country_desc_IT
       , cLE.country_desc_LT
       , cLE.country_desc_NI
       , cLE.country_desc_NL
       , cLE.country_desc_DE
       , cLE.country_desc_LV
       , cLE.country_desc_PL
       , cLE.country_desc_PT
       , cLE.country_desc_RO
       , cLE.country_desc_SE
       , cLE.country_desc_SI
       , cLE.country_desc_SK
       , cLE.country_desc_CS
       , cLE.country_desc_MT
       , cLE.country_desc_US
       , cLE.country_desc_RS
       , cLE.country_opening_date
  FROM P_LEW_MART_MSI.v_mat0_org_all_store_merge_2            AS aSM
  LEFT JOIN P_LEW_MART_MSI.v_mat_org_sales_manager_merge_2    AS sMM
    ON aSM.aspect_id = sMM.aspect_id
   AND aSM.client_id = sMM.client_id
   AND aSM.wh_id     = sMM.wh_id
   AND aSM.wh_id_exp = sMM.wh_id_exp
   AND aSM.sales_manager_id = sMM.sales_manager_id
  LEFT JOIN P_LEW_MART_MSI.v_mat_org_account_manager_merge_2  AS aMM
    ON sMM.aspect_id          = aMM.aspect_id
   AND sMM.client_id          = aMM.client_id
   AND sMM.wh_id              = aMM.wh_id
   AND sMM.account_manager_id = aMM.account_manager_id
  LEFT JOIN P_LEW_MART_MSI.v_mat_org_wh_merge_2               AS wME
    ON aSM.client_id = wME.client_id
   AND aSM.aspect_id = wME.aspect_id
   AND aSM.wh_id     = wME.wh_id
  LEFT JOIN P_LEW_MART_MSI.v_mat_ref_gl_region_merge_2        AS rME
    ON wME.aspect_id    = rME.aspect_id
   AND wME.client_id    = rME.client_id
   AND wME.gl_region_id = rME.gl_region_id
  LEFT JOIN P_LEW_MART_MSI.v_mat_ref_client_lead_2            AS cLE
    ON aSM.client_id = cLE.client_id
;