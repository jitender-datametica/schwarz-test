CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fakturastatus_2 AS SELECT mandant_id,
 faktura_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_fakturastatus_2;