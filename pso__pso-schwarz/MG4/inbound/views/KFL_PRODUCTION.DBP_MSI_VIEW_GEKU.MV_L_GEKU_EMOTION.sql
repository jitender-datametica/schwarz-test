create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_EMOTION(
	GEKU_EMOTION_ID
) as
   SELECT
   geku_emotion_id
   FROM dbp_view.v_l_geku_emotion;