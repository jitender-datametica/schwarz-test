CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_BERICHTS_POS_IT_1
(
	BERICHTS_POSITION_IT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS

-- 22.03.2013 twie: Lookup für Berichtspositionen IT

   SELECT
   berichts_position_it_id

   FROM dbp_view.v_l_berichts_pos_it_1
;