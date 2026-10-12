CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ORG_WH_MERGE
   (
     aspect_id
   , client_id
   , wh_id
   , loc_sid_wh
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
   , street
   , city
   , phone_number
   )

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

   AS
      SELECT DISTINCT
      wh_act.aspect_id,
      wh_act.client_id,
      wh.src_wh_id AS wh_id,
      wh.loc_sid_wh,
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
      wh_act.buying_region,
      wh_con.street,
      wh_con.city,
      wh_con.phone_number
      FROM p_lew_core_ac.v_wawi_org_wh_merge_act AS wh_act
      INNER JOIN p_lew_bil_ac.v_warehouse AS wh
      ON wh_act.wh_loc_sid = wh.loc_sid_wh
      AND wh_act.client_id = wh.client_id
      AND wh.dwh_actual_fg = 1
      LEFT OUTER JOIN p_lew_bil_ac.v_warehouse AS wh2
      ON wh_act.parent_wh_loc_sid = wh2.loc_sid_wh
      AND wh_act.client_id = wh2.client_id
      AND wh.dwh_actual_fg = 1
      LEFT OUTER JOIN p_lew_bil_ac.v_warehouse_contact wh_con
      ON wh_act.wh_loc_sid = wh_con.loc_sid_wh  
      AND wh_act.client_id = wh_con.client_id
      AND wh_con.dwh_actual_fg = 1
      UNION ALL
      /* dummy warehouse for country level in aspect id 1 and 2 */
      SELECT
      aspt.aspect_id                                    AS aspect_id,
      client_id                                         AS client_id,
      -1 * client_id                                    AS wh_id,
      -1 * client_id                                    AS loc_sid_wh,
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
      -1 * client_id                                    AS parent_wh_id,
      NULL                                              AS buying_region,
      NULL::VARCHAR(100)                                AS street,
      NULL::VARCHAR(100)                                AS city,
      NULL::VARCHAR(100)                                AS phone_number
      FROM p_lew_core_ac.v_wawi_ref_client_country              AS clnt
      INNER JOIN p_lew_core_ac.v_wawi_ref_country               AS cntr
      ON clnt.country_id = cntr.country_id
      CROSS JOIN p_lew_mart_lead.v_ref_aspect                   AS aspt
      WHERE cntr.dashboard_relevant_fg = 1
;
