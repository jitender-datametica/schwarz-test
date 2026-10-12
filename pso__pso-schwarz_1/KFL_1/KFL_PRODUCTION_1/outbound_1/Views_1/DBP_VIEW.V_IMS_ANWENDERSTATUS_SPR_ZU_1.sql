CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_anwenderstatus_spr_zu_1 AS SELECT mandant_id,
 anwenderstatus_id,
 spr_id,
 anwenderstatus_bez_kurz,
 anwenderstatus_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ims_anwenderstatus_spr_zu_1;