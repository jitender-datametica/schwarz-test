CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_l_problemcode_1 AS SELECT mandant_id,
 problemcode_id,
 problemcode_bez,
 kopf_fehler_fg,
 pos_fehler_fg,
 mkcheck,
 faktor,
 aus_problemcode_id,
 active
FROM kfl_production_dbp_data.vis_l_problemcode_1;