CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_gruppe_rpw (mandant_id, gruppe_id, abteilung_id, system_id)
AS SELECT mandant_id,
 gruppe_id,
 abteilung_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_gruppe_rpw
WHERE mandant_id = 1;