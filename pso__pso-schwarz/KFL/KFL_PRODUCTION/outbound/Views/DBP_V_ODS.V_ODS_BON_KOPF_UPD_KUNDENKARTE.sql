CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_kopf_upd_kundenkarte AS SELECT bon_id,
 bon_dat,
 wup_id,
 bon_end_date,
 kundenkarte_id,
 insert_date,
 mandant_id,
 bon_day
FROM kfl_production_dbp_ods.ods_bon_kopf_upd_kundenkarte;