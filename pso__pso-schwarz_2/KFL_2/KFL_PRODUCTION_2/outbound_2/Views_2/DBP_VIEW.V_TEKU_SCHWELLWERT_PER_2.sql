CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_schwellwert_per_2 AS SELECT mandant_id,
 teku_berichts_objekt_id,
 teku_hierarchie_objekt_id,
 teku_spalte_bez,
 dat_von,
 dat_bis,
 sw_gruen_bis,
 sw_rot_ab
FROM kfl_production_dbp_data.teku_schwellwert_per_2;