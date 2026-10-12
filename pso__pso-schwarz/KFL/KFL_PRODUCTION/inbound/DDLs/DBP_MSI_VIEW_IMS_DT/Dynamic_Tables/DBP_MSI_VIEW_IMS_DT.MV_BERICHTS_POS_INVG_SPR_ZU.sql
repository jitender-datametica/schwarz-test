CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_INVG_SPR_ZU
(
	BERICHTS_POS_INVEST_GRP_ID,
	BERICHTS_POS_INVEST_GRP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 04.04.2013 twie: Sprachzuordung für Gruppe Berichtspositionen Investitionen

   SELECT
   berichts_pos_invest_grp_id,
   berichts_pos_invest_grp_bez

   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu

   WHERE  spr_id=22
   ;