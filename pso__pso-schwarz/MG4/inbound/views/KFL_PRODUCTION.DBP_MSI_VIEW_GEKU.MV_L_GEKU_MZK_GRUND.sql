create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_MZK_GRUND(
	GEKU_MZK_GRUND_UID,
	GEKU_MZK_THEMA_UID
) as
   SELECT
   geku_mzk_grund_uid
   , geku_mzk_thema_uid
   FROM dbp_view.v_l_geku_mzk_grund;