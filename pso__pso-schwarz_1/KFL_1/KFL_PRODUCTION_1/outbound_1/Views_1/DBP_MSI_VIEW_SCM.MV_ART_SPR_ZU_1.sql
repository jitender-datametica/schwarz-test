CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_spr_zu_1 (mandant_id, art_id, art_bez, art_bez_de,
art_bez_cz, art_bez_sk, art_bez_hr, art_bez_pl, art_bez_ro, art_bez_bg) AS SELECT *
FROM kfl_production_dbp_msi_view_scm.mv_dt_art_spr_zu_1;