CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_GINFO_BAUFORM_SPR_ZU_EN_2 AS
-- 11.04.2013 twie: Sprachzuordung für GINFO Bauform
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.ginfo_bauform_id,
   COALESCE(ls.ginfo_bauform_bez, de.ginfo_bauform_bez) AS ginfo_bauform_bez

   FROM dbp_view.v_ginfo_bauform_spr_zu_2   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_ginfo_bauform_spr_zu_2
   WHERE spr_id = 24
   ) ls
   ON de.ginfo_bauform_id = ls.ginfo_bauform_id

   WHERE de.spr_id = 22;