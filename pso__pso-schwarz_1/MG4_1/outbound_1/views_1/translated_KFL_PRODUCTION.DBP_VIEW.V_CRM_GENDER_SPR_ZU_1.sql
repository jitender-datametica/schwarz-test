CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_gender_spr_zu_1 (gender_id, spr_id, gender_bez, td_insert, td_update
) AS SELECT gender_id,
 spr_id,
 gender_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_gender_spr_zu_1;