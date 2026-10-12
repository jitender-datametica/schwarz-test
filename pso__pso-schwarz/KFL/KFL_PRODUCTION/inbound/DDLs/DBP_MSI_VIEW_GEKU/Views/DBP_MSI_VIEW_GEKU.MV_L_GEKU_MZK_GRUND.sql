CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_MZK_GRUND
(
geku_mzk_grund_uid
,geku_mzk_thema_uid
)
AS
   SELECT
   geku_mzk_grund_uid
   , geku_mzk_thema_uid
   FROM dbp_view.v_l_geku_mzk_grund;