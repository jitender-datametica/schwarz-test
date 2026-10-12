CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_AUFTRAGSART_SPR_ZU
(
	AUFTRAGSART_ID,
	AUFTRAGSART_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 10.06.2013 AL init

   SELECT
   auftragsart_id,
   auftragsart_bez
  FROM dbp_view.v_in_auftragsart_spr_zu
  WHERE spr_id=22
  QUALIFY RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id) =1
;