CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ersteller_rpw_gruppe_zu_per_2 AS SELECT system_id,
 mandant_id,
 ersteller_id,
 gruppe_id,
 abteilung_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.ersteller_rpw_gruppe_zu_per_2;