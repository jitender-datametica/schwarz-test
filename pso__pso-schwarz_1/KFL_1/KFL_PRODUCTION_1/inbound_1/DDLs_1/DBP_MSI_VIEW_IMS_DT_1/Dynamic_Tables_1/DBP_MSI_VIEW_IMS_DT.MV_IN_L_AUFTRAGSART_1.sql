CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_L_AUFTRAGSART_1
(
	AUFTRAGSART_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 10.06.2013 AL init

   SELECT auftragsart_id
   FROM dbp_view.v_in_l_auftragsart_1
   GROUP BY auftragsart_id
;