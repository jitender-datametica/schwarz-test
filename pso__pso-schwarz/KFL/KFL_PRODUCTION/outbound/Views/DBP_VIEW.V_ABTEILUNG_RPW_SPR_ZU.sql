CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abteilung_rpw_spr_zu AS SELECT system_id,
 mandant_id,
 abteilung_id,
 spr_id,
 abteilung_rpw_bez
FROM kfl_production_dbp_data.abteilung_rpw_spr_zu;