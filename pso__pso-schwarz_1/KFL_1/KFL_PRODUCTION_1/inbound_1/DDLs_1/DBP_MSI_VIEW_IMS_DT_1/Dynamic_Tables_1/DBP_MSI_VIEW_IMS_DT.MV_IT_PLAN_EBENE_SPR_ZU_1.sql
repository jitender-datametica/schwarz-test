CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IT_PLAN_EBENE_SPR_ZU_1
(
	IT_PLAN_EBENE_ID,
	IT_PLAN_EBENE_KBEZ,
	IT_PLAN_EBENE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 08.04.2013 AL init

   SELECT
   it_plan_ebene_id,
   it_plan_ebene_kbez,
   it_plan_ebene_bez

  FROM dbp_view.v_it_plan_ebene_spr_zu_1
  WHERE spr_id=22
;