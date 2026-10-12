CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_FLAECHE_TYP_SPR_ZU_EN_1
(
	GINFO_FLAECHE_TYP_ID,
	MANDANT_ID,
	GINFO_FLAECHE_TYP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 12.04.2013 twie: Sprachtabelle für Flächentyp
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 21.08.2013/Gia

   SELECT
   de.ginfo_flaeche_typ_id,
   de.mandant_id,
   COALESCE(ls.ginfo_flaeche_typ_bez, de.ginfo_flaeche_typ_bez) AS ginfo_flaeche_typ_bez

   FROM dbp_view.v_ginfo_flaeche_typ_spr_zu_1   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_ginfo_flaeche_typ_spr_zu_1
   WHERE spr_id = 24
   ) ls
   ON de.ginfo_flaeche_typ_id = ls.ginfo_flaeche_typ_id
   AND  de.mandant_id = ls.mandant_id

   WHERE de.spr_id = 22
   ;