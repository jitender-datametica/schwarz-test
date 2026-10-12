CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_dwh_artikel_2 AS SELECT geku_dwh_artikel_id,
 geku_grund_uid,
 geku_artikel_uid,
 geku_artikel_id,
 wmd_fg,
 aktiv_fg,
 alt_fg,
 geku_artikel_id_alt,
 fipo_pruefpunkt_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_dwh_artikel_2;