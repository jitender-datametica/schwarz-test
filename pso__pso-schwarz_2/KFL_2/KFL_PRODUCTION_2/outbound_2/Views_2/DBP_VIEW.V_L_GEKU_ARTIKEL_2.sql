CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_artikel_2 AS SELECT geku_artikel_uid,
 geku_artikel_id,
 geku_grund_uid,
 land_iso,
 geku_dwh_artikel_id,
 aktiv_fg,
 alt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_artikel_2;