CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gruppe_rpw_spr_zu (system_id, mandant_id, gruppe_id, abteilung_id,
spr_id, gruppe_rpw_bez) AS SELECT system_id,
 mandant_id,
 gruppe_id,
 abteilung_id,
 spr_id,
 gruppe_rpw_bez
FROM kfl_production_dbp_data.gruppe_rpw_spr_zu;