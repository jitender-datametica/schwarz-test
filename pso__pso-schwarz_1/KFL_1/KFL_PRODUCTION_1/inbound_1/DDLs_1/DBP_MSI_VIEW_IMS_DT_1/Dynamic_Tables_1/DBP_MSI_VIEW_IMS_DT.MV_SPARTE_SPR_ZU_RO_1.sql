CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_SPARTE_SPR_ZU_RO_1
(
	SPARTE_ID,
	SPARTE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS

-- 22.03.2013 twie: Sprachzuordung für Sparten
-- 03.04.2013 AL:  sparte KI in der View rausgenommen,
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.sparte_id,
   COALESCE(ls.sparte_bez, de.sparte_bez) AS sparte_bez

   FROM dbp_view.v_sparte_spr_zu_1    de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_sparte_spr_zu_1
   WHERE spr_id = 95
   ) ls
   ON de.sparte_id = ls.sparte_id

   WHERE de.spr_id = 22
   AND de.sparte_id <> 8
;