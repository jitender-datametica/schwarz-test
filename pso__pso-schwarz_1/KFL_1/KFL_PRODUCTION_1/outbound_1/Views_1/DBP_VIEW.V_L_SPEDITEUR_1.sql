CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_spediteur_1 AS SELECT mandant_id,
 spediteur_id,
 spediteur_name,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_spediteur_1;