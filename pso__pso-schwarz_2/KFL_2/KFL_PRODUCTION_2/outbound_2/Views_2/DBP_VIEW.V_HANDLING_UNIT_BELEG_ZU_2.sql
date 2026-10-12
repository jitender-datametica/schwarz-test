CREATE OR REPLACE VIEW kfl_production_dbp_view.v_handling_unit_beleg_zu_2 AS SELECT mandant_id,
 quelle,
 log_guid,
 handling_unit_guid,
 beleg_guid,
 belegtyp_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.handling_unit_beleg_zu_2;