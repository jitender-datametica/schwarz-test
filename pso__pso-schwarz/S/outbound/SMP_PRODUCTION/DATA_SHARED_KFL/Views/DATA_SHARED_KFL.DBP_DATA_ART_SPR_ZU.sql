CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_art_spr_zu (mandant_id, art_id, spr_id, art_bez,
td_update, td_insert) AS SELECT mandant_id,
 art_id,
 spr_id,
 art_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_spr_zu;