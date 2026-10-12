/* dummy_2 warehouse for country_2 level in aspect id 1 and 2 */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_org_wh_merge_base_2 (aspect_id, client_id, wh_id, country_cd, gl_region_id,
dat_opening, costcenter_cd, company, order_buying_list_cd, vat_region_nr, region_cd, stock_plain, sponsion,
global_location_nr, wh_desc, distribute_wh_fg, int_fg, hq_fg, prop_wh_fg, sales_wh_fg, supp_wh_fg, wawi_data_fg,
ovis_data_fg, parent_wh_id, buying_region) AS SELECT DISTINCT WH_ACT.aspect_id,
 WH_ACT.client_id,
 WH.src_wh_id AS wh_id,
 WH_ACT.country_cd,
 WH_ACT.gl_region_id,
 WH_ACT.dat_opening,
 WH_ACT.costcenter_cd,
 WH_ACT.company,
 WH_ACT.order_buying_list_cd,
 WH_ACT.vat_region_nr,
 WH_ACT.region_cd,
 WH_ACT.stock_plain,
 WH_ACT.sponsion,
 WH_ACT.global_location_nr,
 WH_ACT.wh_desc,
 WH_ACT.distribute_wh_fg,
 WH_ACT.int_fg,
 WH_ACT.hq_fg,
 WH_ACT.prop_wh_fg,
 WH_ACT.sales_wh_fg,
 WH_ACT.supp_wh_fg,
 WH_ACT.wawi_data_fg,
 WH_ACT.ovis_data_fg,
 WH2.src_wh_id AS parent_wh_id,
 WH_ACT.buying_region
FROM ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS WH_ACT
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON WH_ACT.wh_loc_sid = WH.loc_sid_wh AND WH_ACT.client_id = WH.client_id
  AND WH.dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH2 ON WH_ACT.parent_wh_loc_sid = WH2.loc_sid_wh AND WH_ACT.client_id = WH2.client_id
     AND WH.dwh_actual_fg = 1
UNION ALL
SELECT multiply.row_no AS aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
 CNTR.country_iso_cd AS country_cd,
  - 1 * CLNT.client_id AS gl_region_id,
 CAST(NULL AS DATE) AS dat_opening,
  - 1 * CLNT.client_id AS costcenter_cd,
 CAST(NULL AS STRING) AS company,
 CAST(NULL AS BIGNUMERIC) AS order_buying_list_cd,
 CAST(NULL AS STRING) AS vat_region_nr,
 CAST(NULL AS BIGNUMERIC) AS region_cd,
 CAST(NULL AS INTEGER) AS stock_plain,
 CAST(NULL AS STRING) AS sponsion,
 CAST(NULL AS STRING) AS global_location_nr,
  '#' || TRIM(CNTR.country_iso_cd) AS wh_desc,
 CAST(NULL AS BIGNUMERIC) AS distribute_wh_fg,
 CAST(NULL AS BIGNUMERIC) AS int_fg,
 CAST(NULL AS BIGNUMERIC) AS hq_fg,
 CAST(NULL AS BIGNUMERIC) AS prop_wh_fg,
 CAST(NULL AS BIGNUMERIC) AS sales_wh_fg,
 CAST(NULL AS BIGNUMERIC) AS supp_wh_fg,
 CAST(NULL AS BIGNUMERIC) AS wawi_data_fg,
 CAST(NULL AS BIGNUMERIC) AS ovis_data_fg,
  - 1 * CLNT.client_id AS parent_wh_id,
 CAST(NULL AS STRING) AS buying_region
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;