CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fakturaart_1 AS SELECT mandant_id,
 fakturaart_id,
 soll_haben_kz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_fakturaart_1;