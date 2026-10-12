CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_art_2 (mandant_id, art_id, kl_art_id, zek_id, zek_vat_id,
eigenmarke_id) AS SELECT mandant_id,
 art_id,
 kl_art_id,
 zek_id,
 zek_vat_id,
 eigenmarke_id
FROM kfl_production_dbp_view.v_art_2 AS V01;