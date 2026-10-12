CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_GINFO_BAUFORM_SPR_ZU_BG_1
(
	GINFO_BAUFORM_ID,
	GINFO_BAUFORM_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie: Sprachzuordung für GINFO Bauform
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013/Gia

   SELECT
   de.ginfo_bauform_id,
   COALESCE(ls.ginfo_bauform_bez, de.ginfo_bauform_bez) AS ginfo_bauform_bez

   FROM dbp_view.v_ginfo_bauform_spr_zu_1   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_ginfo_bauform_spr_zu_1
   WHERE spr_id = 18
   ) ls
   ON de.ginfo_bauform_id = ls.ginfo_bauform_id

   WHERE de.spr_id = 22
   ;