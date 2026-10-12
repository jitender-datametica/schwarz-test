CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_dispo_arttyp_1 AS SELECT mandant_id,
 dispo_arttyp_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_dispo_arttyp_1;