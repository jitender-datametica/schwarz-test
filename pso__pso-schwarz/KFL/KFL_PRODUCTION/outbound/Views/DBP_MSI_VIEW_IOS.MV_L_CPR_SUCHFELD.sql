CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_cpr_suchfeld (cpr_suchfeld_id, cpr_suchfeld,
cpr_suchfeld_akt_fg) AS SELECT DISTINCT *
FROM kfl_production_dbp_view.v_l_cpr_suchfeld AS V01;