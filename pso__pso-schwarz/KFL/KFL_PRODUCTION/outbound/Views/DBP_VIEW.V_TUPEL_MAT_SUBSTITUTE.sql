CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tupel_mat_substitute AS SELECT tupel_mat_substitute_id,
 mandant_id,
 kjwo_update,
 matching_id_parent,
 matching_id_substitute,
 rank_substitute
FROM kfl_production_dbp_data.tupel_mat_substitute;