CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_WRG_2
(
wrg_id
,wrg_bez
)
AS
   SELECT

   v01.wrg_id, v01.wrg_bez

   FROM dbp_view.v_wrg_2 v01;