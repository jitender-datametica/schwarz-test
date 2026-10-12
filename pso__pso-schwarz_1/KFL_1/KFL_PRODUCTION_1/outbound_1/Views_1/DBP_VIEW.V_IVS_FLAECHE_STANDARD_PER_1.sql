CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_flaeche_standard_per_1 AS SELECT mandant_id,
 flaeche_id,
 dat_von,
 dat_bis,
 std_branche_id,
 std_vertragart_id,
 std_miete_betrag,
 std_miete_qm_betrag,
 std_miete_prozent,
 system_id,
 buchungskreis_id,
 flaeche_bez
FROM kfl_production_dbp_data.ivs_flaeche_standard_per_1;