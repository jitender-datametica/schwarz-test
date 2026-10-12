CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_artikelrolle_spr_zu AS SELECT mandant_id,
 artikelrolle_id,
 spr_id,
 artikelrolle_bez
FROM kfl_production_dbp_view.v_artikelrolle_spr_zu;