CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_wup_entfernungsmatrix_2 (wup_id_a, wup_id_b, nb_id_a,
nb_id_b, mandant_id_a, mandant_id_b, distanz_fahrweg_km) AS SELECT wup_id_a,
 wup_id_b,
 nb_id_a,
 nb_id_b,
 mandant_id_a,
 mandant_id_b,
 distanz_fahrweg_km
FROM kfl_production_dbp_view.v_wup_entfernungsmatrix_2;