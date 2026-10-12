CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_aktion_1 AS SELECT aktion_id,
 dat_von,
 dat_bis,
 mandant_id
FROM kfl_production_dbp_view.v_aktion_1 AS V01;