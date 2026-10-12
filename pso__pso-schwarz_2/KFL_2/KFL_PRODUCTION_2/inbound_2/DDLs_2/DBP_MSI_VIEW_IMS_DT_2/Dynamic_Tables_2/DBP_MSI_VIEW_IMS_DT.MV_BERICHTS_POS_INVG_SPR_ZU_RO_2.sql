CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_INVG_SPR_ZU_RO_2
(
	BERICHTS_POS_INVEST_GRP_ID,
	BERICHTS_POS_INVEST_GRP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 04.04.2013 twie: Sprachzuordung für Gruppe_2 Berichtspositionen Investitionen
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.berichts_pos_invest_grp_id,
   COALESCE(ls.berichts_pos_invest_grp_bez, de.berichts_pos_invest_grp_bez) AS berichts_pos_invest_grp_bez

   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu_2 de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu_2
   WHERE spr_id = 95
   ) ls
   ON de.berichts_pos_invest_grp_id = ls.berichts_pos_invest_grp_id

   WHERE de.spr_id = 22
   ;