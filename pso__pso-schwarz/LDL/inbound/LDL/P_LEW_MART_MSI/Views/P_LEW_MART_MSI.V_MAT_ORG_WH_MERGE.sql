CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_WH_MERGE
AS
/*
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  17.11.2020    Meme, Yasin                 Add LV DWHA-248 Patch 2665
#  1.2  18.03.2021    Marcin Malec                REP2-9232, adding wh contact columns - street, city, phone_number
#  1.3  17.12.2021    Michael Morris              Added Estonia EE
#----------------------------------------------------------------------------
*/
SELECT   wME.aspect_id
       , wME.client_id
       , wME.wh_id
       , wME.country_cd
       , wME.gl_region_id
       , wME.dat_opening
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
       , wME.street
       , wME.city
       , wME.phone_number
       , rME.gl_region_desc
       , rME.gl_last_name
       , rME.gl_first_name
       , COALESCE(cLE.int_id, -1)           AS int_id
       , cLE.country_iso_cd
       , COALESCE(cLE.country_group_id, -1) AS country_group_id
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
  FROM P_LEW_MART_MSI.v_mat0_org_wh_merge             AS wME
  LEFT JOIN P_LEW_MART_MSI.v_mat_ref_gl_region_merge  AS rME
    ON wME.aspect_id    = rME.aspect_id
   AND wME.client_id    = rME.client_id
   AND wME.gl_region_id = rME.gl_region_id
  LEFT JOIN P_LEW_MART_MSI.v_mat_ref_client_lead      AS cLE
   ON wME.client_id     = cLE.client_id
;