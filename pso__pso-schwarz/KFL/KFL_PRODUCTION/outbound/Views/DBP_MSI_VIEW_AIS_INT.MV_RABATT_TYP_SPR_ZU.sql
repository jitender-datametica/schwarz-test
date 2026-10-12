CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rabatt_typ_spr_zu (mandant_id, rabatt_typ_id,
rabatt_typ_bez) AS SELECT mandant_id,
 rabatt_typ_id,
 rabatt_typ_bez
FROM kfl_production_dbp_data.rabatt_typ_spr_zu
WHERE spr_id = 22;