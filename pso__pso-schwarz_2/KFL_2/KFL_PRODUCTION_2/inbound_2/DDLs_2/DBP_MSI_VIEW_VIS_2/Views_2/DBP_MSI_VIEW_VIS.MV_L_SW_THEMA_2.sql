CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SW_THEMA_2
(
sw_thema_id
,sw_thema_bez
)
AS
   SELECT
   sw_thema_id, sw_thema_bez
   FROM dbp_view.v_l_sw_thema_2;