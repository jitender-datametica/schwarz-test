CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_PROFIT_CENTER_SPR_ZU_1
(
	PC_ID,
	KRK_ID,
	MANDANT_ID,
	PC_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.08.2013 twie_ Sprachzuordnung für Profit Center
   SELECT
  pc_id,
   krk_id,
   mandant_id,
   pc_bez

   FROM dbp_view.v_profit_center_spr_zu_1
   WHERE spr_id = 22
;