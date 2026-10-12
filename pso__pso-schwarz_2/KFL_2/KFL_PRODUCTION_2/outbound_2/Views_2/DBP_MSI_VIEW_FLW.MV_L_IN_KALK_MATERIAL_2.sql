CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_kalk_material_2 (mandant_id, kalk_id, kalkulationsart_id,
dat_kalk, kalk_version_id, bewertung_variante_id, in_art_id, werk_id, dat_kalk_ab, dat_kalk_bis) AS SELECT mandant_id,
 kalk_id,
 kalkulationsart_id,
 dat_kalk,
 kalk_version_id,
 bewertung_variante_id,
 flw_art_id AS in_art_id,
 werk_id,
 dat_kalk_ab,
 dat_kalk_bis
FROM kfl_production_dbp_view.v_flw_kalk_erzeugnis_2;