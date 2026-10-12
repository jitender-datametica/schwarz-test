create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_TEAM_1(
	GEKU_TEAM_ID,
	GEKU_TEAM_NAME,
	GEKU_TEAMLEITER_ID,
	GEKU_TEAM_TYP_UID,
	GEKU_VORGESETZTER_ID
) as
   SELECT
   geku_team_id
   , geku_team_name
   , geku_teamleiter_id
   , geku_team_typ_uid
   , geku_vorgesetzter_id
   FROM dbp_view.v_l_geku_team_1;