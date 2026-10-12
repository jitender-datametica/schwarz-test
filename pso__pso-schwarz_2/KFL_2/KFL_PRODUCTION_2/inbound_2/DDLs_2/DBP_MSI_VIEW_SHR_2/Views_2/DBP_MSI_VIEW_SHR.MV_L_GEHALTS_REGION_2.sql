CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_GEHALTS_REGION_2
(
mandant_id
,gehalts_region_id
)
AS
   SELECT
   v01.mandant_id, v01.gehalts_region_id

   FROM dbp_view.v_l_gehalts_region_2 v01

;