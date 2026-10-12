CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BEDIENKONZEPT_AUSPR_1
-- AL 12.10.2011 neu erstellt
(

bedienkonzept_id
,bedienkonzept_auspr_id

)
AS


   SELECT
   bedienkonzept_id, bedienkonzept_auspr_id

   FROM dbp_view.v_l_bedienkonzept_auspr_1;