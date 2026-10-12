CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ORG_WH_MERGE_BASE_1
(
  aspect_id
, client_id
, wh_id
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
)
AS
   SELECT DISTINCT
   wh_act.aspect_id,
   wh_act.client_id,
   wh.src_wh_id AS wh_id,
   wh_act.country_cd,
   wh_act.gl_region_id,
   wh_act.dat_opening,
   wh_act.costcenter_cd,
   wh_act.company,
   wh_act.order_buying_list_cd,
   wh_act.vat_region_nr,
   wh_act.region_cd,
   wh_act.stock_plain,
   wh_act.sponsion,
   wh_act.global_location_nr,
   wh_act.wh_desc,
   wh_act.distribute_wh_fg,
   wh_act.int_fg,
   wh_act.hq_fg,
   wh_act.prop_wh_fg,
   wh_act.sales_wh_fg,
   wh_act.supp_wh_fg,
   wh_act.wawi_data_fg,
   wh_act.ovis_data_fg,
   wh2.src_wh_id AS parent_wh_id,
   wh_act.buying_region
   FROM p_lew_core_ac.v_wawi_org_wh_merge_act_1 wh_act
   INNER JOIN p_lew_bil_ac.v_warehouse_1 wh
   ON wh_act.wh_loc_sid = wh.loc_sid_wh
   AND wh_act.client_id = wh.client_id
   AND wh.dwh_actual_fg = 1
   LEFT OUTER JOIN p_lew_bil_ac.v_warehouse_1 wh2
   ON wh_act.parent_wh_loc_sid = wh2.loc_sid_wh
   AND wh_act.client_id = wh2.client_id
   AND wh.dwh_actual_fg = 1

   UNION ALL
   /* dummy_1 warehouse for country_1 level in aspect id 1 and 2 */
   SELECT
   multiply.row_no                                   AS aspect_id,
   client_id                                         AS client_id,
   -1 * client_id                                    AS wh_id,
   cntr.country_iso_cd                               AS country_cd,
   -1 * client_id                                    AS gl_region_id,
   NULL                                              AS dat_opening,
   -1 * client_id                                    AS costcenter_cd,
   NULL              AS company,
   NULL                                              AS order_buying_list_cd,
   NULL              AS vat_region_nr,
   NULL                                              AS region_cd,
   NULL                                              AS stock_plain,
   NULL              AS sponsion,
   NULL              AS global_location_nr,
   '#'|| TRIM( cntr.country_iso_cd)
   AS wh_desc,
   NULL                                              AS distribute_wh_fg,
   NULL                                              AS int_fg,
   NULL                                              AS hq_fg,
   NULL                                              AS prop_wh_fg,
   NULL                                              AS sales_wh_fg,
   NULL                                              AS supp_wh_fg,
   NULL                                              AS wawi_data_fg,
   NULL                                              AS ovis_data_fg,
   -1 * client_id                                     AS parent_wh_id,
   NULL              AS buying_region
   FROM p_lew_core_ac.v_wawi_ref_client_country_1              AS clnt
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_1               AS cntr
   ON clnt.country_id = cntr.country_id
   CROSS JOIN (SELECT
   1 AS row_no
   FROM (SELECT
   1 AS one) SUB1
   UNION ALL
   SELECT
   2 AS row_no
   FROM (SELECT
   1 AS two) SUB2
  ) AS multiply
  WHERE cntr.dashboard_relevant_fg = 1
;