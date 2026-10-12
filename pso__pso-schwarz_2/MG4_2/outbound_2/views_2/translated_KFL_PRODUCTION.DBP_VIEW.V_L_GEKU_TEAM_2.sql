CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_team_2 (geku_team_id, geku_team_name, geku_teamleiter_id,
geku_team_typ_uid, geku_vorgesetzter_id, td_update, td_insert) AS SELECT geku_team_id,
 geku_team_name,
 geku_teamleiter_id,
 geku_team_typ_uid,
 geku_vorgesetzter_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_team_2;