CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_ART_SPR_ZU_RO
(
	MANDANT_ID,
	IN_ART_ID,
	ART_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 31.05.2013 twie: Erstellung Sprachtabelle Material
-- 19.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden
-- 20.08.2013/Gia

   SELECT
   v01.mandant_id,
   v01.in_art_id,
   CASE WHEN v01.in_art_id = -1 THEN ''
  ELSE v01.art_bez
  END AS art_bez

  FROM dbp_view.v_in_art_spr_zu v01

   WHERE spr_id = 95
;