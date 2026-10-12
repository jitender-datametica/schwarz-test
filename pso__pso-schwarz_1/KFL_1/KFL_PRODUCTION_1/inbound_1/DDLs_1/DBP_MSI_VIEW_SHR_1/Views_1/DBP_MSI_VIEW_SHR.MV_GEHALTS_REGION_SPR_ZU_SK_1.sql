CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_GEHALTS_REGION_SPR_ZU_SK_1
(
mandant_id
,gehalts_region_id
,spr_id
,gehalts_region_bez

)
AS
   SELECT
   v01.mandant_id, v01.gehalts_region_id, v01.spr_id, v01.gehalts_region_bez


   FROM dbp_view.v_gehalts_region_spr_zu_1 v01
   where spr_id = 108


;