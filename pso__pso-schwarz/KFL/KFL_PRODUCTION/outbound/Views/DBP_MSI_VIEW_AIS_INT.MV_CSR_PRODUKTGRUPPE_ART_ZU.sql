CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_csr_produktgruppe_art_zu (mandant_id, art_id,
csr_produktgruppe_id) AS SELECT mandant_id,
 art_id,
 csr_produktgruppe_id
FROM kfl_production_dbp_view.v_csr_produktgruppe_art_zu;