CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_BERICHTS_POS_INVEST
(
	BERICHTS_POSITION_INVEST_ID,
	BERICHTS_POS_INVEST_GRP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Berichtspositionen Investitionen
-- 07.08.2013 twie: neue Gruppe 80 (AIB) zugeordnet
-- 14.07.2016 twie: Nachtrag AP0001938 ahk_aufwand_id nicht mehr manuell zuordnen, kommt aus Tabelle, siehe mv_l_berichts_pos_inv_grp

   SELECT
   berichts_position_invest_id,
   berichts_pos_invest_grp_id

   FROM dbp_view.v_l_berichts_pos_invest
;