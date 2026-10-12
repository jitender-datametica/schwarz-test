CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_abt_spr_zu (abt_id, arthiertyp_id, spr_id, mandant_id,
abt_bez, td_update, td_insert) AS SELECT abt_id,
 arthiertyp_id,
 spr_id,
 mandant_id,
 abt_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.abt_spr_zu;