CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IT_PROJEKT_STATUS_SPR_ZU_BG_1
(
	IT_PROJEKT_STATUS_ID,
	IT_PROJEKT_STATUS_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 15.04.2013 AL Init

   SELECT
   it_projekt_status_id,
   it_projekt_status_bez
  FROM dbp_view.v_it_projekt_status_spr_zu_1
  WHERE spr_id=18
;