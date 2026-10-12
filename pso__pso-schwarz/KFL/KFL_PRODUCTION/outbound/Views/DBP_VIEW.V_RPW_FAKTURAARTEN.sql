CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpw_fakturaarten AS SELECT mandant_id,
 fakturaart_id,
 vertriebbelegtyp_id,
 soll_haben_kz
FROM kfl_production_dbp_data.rpw_fakturaarten;