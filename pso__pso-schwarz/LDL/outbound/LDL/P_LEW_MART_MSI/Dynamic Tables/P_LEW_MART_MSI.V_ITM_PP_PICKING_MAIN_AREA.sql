CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_pp_picking_main_area
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
-- workaround
 SELECT A.client_id,
 WH.src_wh_id AS wh_id_pp,
 A.pick_area_id AS picking_area_nr_pp,
  10 * TRUNC(CAST(A.pick_area_id / 10 AS BIGNUMERIC)) AS picking_main_area_nr_pp,
 A.pick_main_area_descr AS picking_main_area_desc_pp
FROM ldl_p_lew_core_ac.v_ref_pick_area_descr AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 -- Stiftungssprache

WHERE A.lang_sid = 2;