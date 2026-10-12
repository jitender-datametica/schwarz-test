CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_l_rev_fachbereich AS SELECT rev_fb_id,
 aktiv_fg,
 rev_fb_bez,
 rev_fb_kbez
FROM kfl_production_dbp_data.fipo_l_rev_fachbereich;