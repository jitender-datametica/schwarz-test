CREATE OR REPLACE VIEW kfl_production_dbp_view.v_einlager_steuerung_spr_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 einlager_steuerung_id,
 spr_id,
 einlager_steuerung_bez
FROM kfl_production_dbp_data.einlager_steuerung_spr_zu_1;