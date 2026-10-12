CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_art_herst_zu_1 (mandant_id, in_art_id, art_id, herst_id,
gp_art_id, mhd_zeitraum_dz) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.art_id,
 COALESCE(V02.herst_id, -1) AS herst_id,
 COALESCE(V02.gp_art_id, '-1') AS gp_art_id,
 COALESCE(V02.mhd_zeitraum_dz, -1) AS mhd_zeitraum_dz
FROM kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
     AND V02.dat_bis = DATE '9999-12-31';