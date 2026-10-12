CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_WG_SPR_ZU_EN_1
(
	MANDANT_ID,
	IN_WG_ID,
	IN_WG_BEZ,
	IN_WG_BEZ_LANG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 31.05.2013 twie: Erstellung Sprachtabelle Warengruppe
-- 19.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden
-- 20.08.2013/Gia

   SELECT
   v01.mandant_id,
   v01.in_wg_id,
   v01.in_wg_bez,
   v01.in_wg_bez_lang

  FROM dbp_view.v_in_wg_spr_zu_1 v01

   WHERE spr_id = 24
;