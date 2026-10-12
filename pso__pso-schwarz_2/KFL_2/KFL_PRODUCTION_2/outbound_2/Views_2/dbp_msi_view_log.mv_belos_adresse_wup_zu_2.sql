CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_belos_adresse_wup_zu_2 (mandant_id, belos_adresse_id, wup_id,
nb_id) AS SELECT mandant_id,
 belos_adresse_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_view.v_ts_belos_adresse_wup_zu_2;