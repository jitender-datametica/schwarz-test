CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_zusatz_per_1 (mandant_id, gp_id, einkaufsorganisation_id, dat_von,
dat_bis, entgelt_mind_kz, ret_sperrprofil_id, system_id, td_update, td_insert) AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 dat_von,
 dat_bis,
 entgelt_mind_kz,
 ret_sperrprofil_id,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gp_zusatz_per_1;