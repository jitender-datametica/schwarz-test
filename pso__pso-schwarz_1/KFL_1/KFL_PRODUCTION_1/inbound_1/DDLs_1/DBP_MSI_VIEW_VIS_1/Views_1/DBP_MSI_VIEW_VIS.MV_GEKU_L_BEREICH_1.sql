CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_BEREICH_1
(
geku_bereich_uid
,geku_bereich_id
,KDC_fg
,MZK_fg
,WMD_fg
)
AS
   SELECT
   geku_bereich_uid, geku_bereich_id, KDC_fg, MZK_fg, WMD_fg
   FROM dbp_view.v_l_geku_bereich_1;