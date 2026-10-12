CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_BERICHTS_POS_INV_GRP_1
(
	BERICHTS_POS_INVEST_GRP_ID,
	AHK_AUFWAND_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Gruppe_1 Berichtspositionen Investition
-- 07.08.2013 twie: neue Gruppe_1 80 (AIB) zugeordnet
-- 06.04.2016 twie: ahk_aufwand_id aus Tabelle, nicht mehr in View ermitteln
--   Viewlogik bisher CASE WHEN berichts_pos_invest_grp_id in (-1,10,20,30,40,50) then 1
--   WHEN berichts_pos_invest_grp_id in (60,70) then 0
--   WHEN berichts_pos_invest_grp_id in (80) then 2
--   ELSE -1 END AS ahk_aufwand_id

   SELECT
   berichts_pos_invest_grp_id,
   ahk_aufwand_id

   FROM dbp_view.v_l_berichts_pos_inv_grp_1
;