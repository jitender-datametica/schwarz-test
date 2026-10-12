CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gruppe_rpw (system_id, mandant_id, gruppe_id, abteilung_id) AS SELECT
 system_id,
 mandant_id,
 gruppe_id,
 abteilung_id
FROM kfl_production_dbp_data.l_gruppe_rpw;