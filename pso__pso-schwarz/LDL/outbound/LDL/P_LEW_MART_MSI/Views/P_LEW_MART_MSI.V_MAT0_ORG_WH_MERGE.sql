/* dummy warehouse for country level in aspect id 1 and 2 */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_org_wh_merge AS SELECT DISTINCT WH_ACT.aspect_id,
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
 WH_ACT.buying_region,
 WH_CON.street,
 WH_CON.city,
 WH_CON.phone_number
FROM ldl_p_lew_core_ac.v_wawi_org_wh_merge_act AS WH_ACT
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WH_ACT.wh_loc_sid = WH.loc_sid_wh AND WH_ACT.client_id = WH.client_id
  AND WH.dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_warehouse AS WH2 ON WH_ACT.parent_wh_loc_sid = WH2.loc_sid_wh AND WH_ACT.client_id = WH2.client_id
     AND WH.dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_contact AS WH_CON ON WH_ACT.wh_loc_sid = WH_CON.loc_sid_wh AND WH_ACT.client_id
    = WH_CON.client_id AND WH_CON.dwh_actual_fg = 1
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
 CAST(NULL AS STRING) AS buying_region,
 CAST(NULL AS STRING) AS street,
 CAST(NULL AS STRING) AS city,
 CAST(NULL AS STRING) AS phone_number
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;