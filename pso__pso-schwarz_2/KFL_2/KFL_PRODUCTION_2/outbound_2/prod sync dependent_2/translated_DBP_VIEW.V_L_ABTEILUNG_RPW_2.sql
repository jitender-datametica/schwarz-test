CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_abteilung_rpw_2 (system_id, mandant_id, abteilung_id) AS SELECT
 system_id,
 mandant_id,
 abteilung_id
FROM kfl_production_dbp_data.l_abteilung_rpw_2;