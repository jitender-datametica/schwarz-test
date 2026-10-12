CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rech_erfassung_spr_zu_2 AS SELECT system_id,
 mandant_id,
 spr_id,
 erfassung_id,
 erfassung_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rech_erfassung_spr_zu_2;