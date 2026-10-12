CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS SELECT mietvertrag_id,
 mandant_id,
 flaeche_id,
 flaeche_status_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.ivs_miet_fl_stat_zu_per_2;