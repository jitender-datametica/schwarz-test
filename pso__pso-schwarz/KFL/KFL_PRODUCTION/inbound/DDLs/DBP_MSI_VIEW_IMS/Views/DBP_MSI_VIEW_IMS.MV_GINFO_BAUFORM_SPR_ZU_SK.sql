CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_GINFO_BAUFORM_SPR_ZU_SK AS
-- 11.04.2013 twie: Sprachzuordung für GINFO Bauform
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013/Gia

   SELECT
   de.ginfo_bauform_id,
   COALESCE(ls.ginfo_bauform_bez, de.ginfo_bauform_bez) AS ginfo_bauform_bez

   FROM dbp_view.v_ginfo_bauform_spr_zu   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_ginfo_bauform_spr_zu
   WHERE spr_id = 108
   ) ls
   ON de.ginfo_bauform_id = ls.ginfo_bauform_id

   WHERE de.spr_id = 22
   ;