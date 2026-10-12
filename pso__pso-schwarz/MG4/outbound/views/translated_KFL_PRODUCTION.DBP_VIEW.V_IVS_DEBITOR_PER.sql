CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_debitor_per (debitor_id, mandant_id, debitor_status_id, dat_von,
dat_bis, konzern_id, konzessionaer_id, ivs_fg) AS SELECT debitor_id,
 mandant_id,
 debitor_status_id,
 dat_von,
 dat_bis,
 konzern_id,
 konzessionaer_id,
 ivs_fg
FROM kfl_production_dbp_data.ivs_debitor_per;