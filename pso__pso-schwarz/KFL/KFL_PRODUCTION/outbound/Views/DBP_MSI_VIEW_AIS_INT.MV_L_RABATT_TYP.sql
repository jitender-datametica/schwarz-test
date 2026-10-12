CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_rabatt_typ (mandant_id, rabatt_typ_id) AS SELECT
 mandant_id,
 rabatt_typ_id
FROM kfl_production_dbp_data.l_rabatt_typ;