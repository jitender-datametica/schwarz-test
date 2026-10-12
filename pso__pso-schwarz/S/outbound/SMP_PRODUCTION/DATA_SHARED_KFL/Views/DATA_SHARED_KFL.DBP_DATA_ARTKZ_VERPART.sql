CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_artkz_verpart (verpart_id, mandant_id, spr_id,
verpart_bez, td_update, td_insert) AS SELECT verpart_id,
 mandant_id,
 spr_id,
 verpart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_verpart;