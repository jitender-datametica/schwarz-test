CREATE OR REPLACE VIEW kfl_production_dbp_view.v_auslager_steuerung_spr_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 auslager_steuerung_id,
 spr_id,
 auslager_steuerung_bez
FROM kfl_production_dbp_data.auslager_steuerung_spr_zu_1;