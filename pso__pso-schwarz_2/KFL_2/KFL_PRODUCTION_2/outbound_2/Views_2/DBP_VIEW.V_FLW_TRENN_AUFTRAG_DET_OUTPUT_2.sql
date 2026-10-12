CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_trenn_auftrag_det_output_2 AS SELECT auftrag_id,
 mandant_id,
 flw_art_id,
 system_id,
 menge_ist_bme
FROM kfl_production_dbp_data.flw_trenn_auftrag_det_output_2;