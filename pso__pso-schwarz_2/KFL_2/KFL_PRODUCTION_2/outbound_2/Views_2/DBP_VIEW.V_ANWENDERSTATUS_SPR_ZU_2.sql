CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anwenderstatus_spr_zu_2 AS SELECT mandant_id,
 anwenderstatus_id,
 spr_id,
 system_id,
 anwenderstatus_bez_kurz,
 anwenderstatus_bez
FROM kfl_production_dbp_data.anwenderstatus_spr_zu_2;