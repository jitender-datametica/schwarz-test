CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_TEAM_1
(
geku_team_id
,geku_team_name
,geku_teamleiter_id
,geku_team_typ_uid
,geku_vorgesetzter_id
)
AS
   SELECT
   geku_team_id
   , geku_team_name
   , geku_teamleiter_id
   , geku_team_typ_uid
   , geku_vorgesetzter_id
   FROM dbp_view.v_l_geku_team_1;