CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BEDIENKONZEPT_1
-- AL 12.10.2011 neu erstellt
(
bedienkonzept_id
,bedienkonzept_bez

)
AS


   SELECT
   bedienkonzept_id, bedienkonzept_bez
   FROM dbp_view.v_l_bedienkonzept_1;