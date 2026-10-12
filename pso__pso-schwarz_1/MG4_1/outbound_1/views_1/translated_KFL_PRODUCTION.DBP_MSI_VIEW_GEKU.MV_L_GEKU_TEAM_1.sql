CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_team_1 (geku_team_id, geku_team_name, geku_teamleiter_id
, geku_team_typ_uid, geku_vorgesetzter_id) AS SELECT geku_team_id,
 geku_team_name,
 geku_teamleiter_id,
 geku_team_typ_uid,
 geku_vorgesetzter_id
FROM kfl_production_dbp_view.v_l_geku_team_1;