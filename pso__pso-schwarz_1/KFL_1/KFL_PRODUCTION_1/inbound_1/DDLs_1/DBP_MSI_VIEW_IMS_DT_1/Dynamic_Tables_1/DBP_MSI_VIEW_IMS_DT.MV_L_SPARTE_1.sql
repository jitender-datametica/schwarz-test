CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_SPARTE_1
(
	SPARTE_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Sparten

   SELECT
   sparte_id

   FROM dbp_view.v_l_sparte_1
;