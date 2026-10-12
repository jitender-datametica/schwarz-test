CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_dwh_artikel_spr_zu (geku_dwh_artikel_id, spr_id, geku_artikel_uid
, geku_dwh_artikel_bez) AS SELECT geku_dwh_artikel_id,
 spr_id,
 geku_artikel_uid,
 geku_dwh_artikel_bez
FROM kfl_production_dbp_data.geku_dwh_artikel_spr_zu;