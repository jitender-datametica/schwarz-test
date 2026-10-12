CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_auftrag_pps_2 AS SELECT auftrag_id,
 mandant_id,
 flw_art_id,
 dat_ende,
 dat_start,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_auftrag_pps_2;