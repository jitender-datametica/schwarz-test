CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_owg_spr_zu_1 (owg_id, arthiertyp_id, mandant_id, spr_id,
owg_bez, td_update, td_insert) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 owg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.owg_spr_zu_1;