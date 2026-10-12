CREATE OR REPLACE VIEW kfl_production_dbp_view.v_status_ladtraeger_spr_zu_2 AS SELECT status_ladtraeger,
 spr_id,
 mandant_id,
 status_ladtraeger_bez
FROM kfl_production_dbp_data.status_ladtraeger_spr_zu_2;