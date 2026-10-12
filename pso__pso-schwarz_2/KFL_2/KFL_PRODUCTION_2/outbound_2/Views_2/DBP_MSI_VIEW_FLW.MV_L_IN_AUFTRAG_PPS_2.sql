CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_auftrag_pps_2 (mandant_id, auftrag_id, in_art_id, dat_ende
, dat_start) AS SELECT mandant_id,
 auftrag_id,
 flw_art_id AS in_art_id,
 dat_ende,
 dat_start
FROM kfl_production_dbp_view.v_flw_auftrag_pps_2;