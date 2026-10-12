CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_INV_SPR_ZU_2
(
	BERICHTS_POSITION_INVEST_ID,
	BERICHTS_POSITION_INVEST_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Sprachzuordung für Berichtspositionen Investitionen

   SELECT
   berichts_position_invest_id,
   berichts_position_invest_bez

   FROM dbp_view.v_berichts_pos_invest_spr_zu_2

   WHERE  spr_id=22
   ;