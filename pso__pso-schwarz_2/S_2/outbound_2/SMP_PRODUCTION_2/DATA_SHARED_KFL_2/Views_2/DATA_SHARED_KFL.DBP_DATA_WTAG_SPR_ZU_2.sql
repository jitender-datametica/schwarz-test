CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_wtag_spr_zu_2 (wtag_id, spr_id, wtag_bez, td_insert,
td_update) AS SELECT wtag_id,
 spr_id,
 wtag_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wtag_spr_zu_2;