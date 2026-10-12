CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_einh_spr_zu_2 (einh_id, mandant_id, spr_id, einh_bez_kaufm
, einh_bez, td_update, td_insert) AS SELECT einh_id,
 mandant_id,
 spr_id,
 einh_bez_kaufm,
 einh_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.einh_spr_zu_2;