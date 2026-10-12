CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_bereich_2 (geku_bereich_uid, geku_bereich_id, kdc_fg,
mzk_fg, wmd_fg, sec_kz) AS SELECT geku_bereich_uid,
 geku_bereich_id,
 kdc_fg,
 mzk_fg,
 wmd_fg,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_l_geku_bereich_2
WHERE geku_bereich_uid IN (SELECT geku_bereich_uid
   FROM kfl_production_dbp_view.v_l_geku_grund_2);