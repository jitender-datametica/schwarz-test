CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BUDGET_TYP_SPR_ZU_EN_2
(
	IN_BUDGET_TYP_ID,
	IN_BUDGET_TYP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 08.07.2014 twie: Erstellung Sprachview Budget Typ

   SELECT

   in_budget_typ_id,
   in_budget_typ_bez

   FROM dbp_view.v_in_budget_typ_spr_zu_2

   WHERE spr_id = 24
   ;