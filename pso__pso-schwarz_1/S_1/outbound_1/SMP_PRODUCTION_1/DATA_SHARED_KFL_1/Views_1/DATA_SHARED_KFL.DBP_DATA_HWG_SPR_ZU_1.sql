CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_hwg_spr_zu_1 (hwg_id, arthiertyp_id, mandant_id, spr_id,
hwg_bez, td_update, td_insert) AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 hwg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.hwg_spr_zu_1;