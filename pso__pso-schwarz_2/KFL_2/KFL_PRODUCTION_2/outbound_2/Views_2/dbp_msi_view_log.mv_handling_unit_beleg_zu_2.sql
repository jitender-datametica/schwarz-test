CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_handling_unit_beleg_zu_2 AS SELECT mandant_id,
 quelle,
 log_guid,
 handling_unit_guid,
 beleg_guid,
 belegtyp_id
FROM kfl_production_dbp_view.v_handling_unit_beleg_zu_2 AS V01;