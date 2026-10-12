CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_SPARTE_SPR_ZU_2
(
	SPARTE_ID,
	SPARTE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Sprachzuordung für Sparten

   SELECT
   sparte_id,
   sparte_bez

   FROM dbp_view.v_sparte_spr_zu_2

   WHERE  spr_id=22
;