CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_FLAECHE_TYP_SPR_ZU_SK_1 AS
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
   WHERE spr_id = 108
   ) ls
   ON de.ginfo_flaeche_typ_id = ls.ginfo_flaeche_typ_id
   AND  de.mandant_id = ls.mandant_id

   WHERE de.spr_id = 22
   ;