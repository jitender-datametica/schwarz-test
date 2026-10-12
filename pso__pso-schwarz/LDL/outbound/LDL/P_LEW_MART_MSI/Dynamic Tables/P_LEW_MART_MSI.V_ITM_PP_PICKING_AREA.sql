CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_pp_picking_area
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT PA.client_id,
 PA.client_id AS language_id,
 PA.pick_area_descr AS picking_area_desc_pp,
 PA.pick_area_id AS picking_area_nr_pp,
 WH.src_wh_id AS wh_id_pp
FROM ldl_p_lew_core_ac.v_ref_pick_area_descr AS PA
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON PA.client_id = WH.client_id AND PA.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 -- außer Stiftungssprache

WHERE PA.lang_sid <> 2;