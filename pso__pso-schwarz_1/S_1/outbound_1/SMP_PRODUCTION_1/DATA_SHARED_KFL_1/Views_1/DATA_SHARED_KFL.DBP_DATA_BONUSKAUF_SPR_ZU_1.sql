CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_bonuskauf_spr_zu_1 (bonuskauf_id, spr_id, mandant_id,
bonuskauf_bez, td_update, td_insert) AS SELECT bonuskauf_id,
 spr_id,
 mandant_id,
 bonuskauf_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bonuskauf_spr_zu_1;