CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_cpr_suchfeld_2 (cpr_suchfeld_id, cpr_suchfeld, cpr_suchfeld_akt_fg) AS
SELECT cpr_suchfeld_id,
 cpr_suchfeld,
 cpr_suchfeld_akt_fg
FROM kfl_production_dbp_data.l_cpr_suchfeld_2;