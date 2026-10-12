CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_MASS_TYP_SPR_ZU_SK_1 AS
-- 05.04.2013 twie: Sprachzuordnung für Massnahmentyp
-- 20.08.2013/gia

   SELECT
   de.in_massnahme_typ_id,
   COALESCE(ls.in_massnahme_typ_bez, de.in_massnahme_typ_bez) AS in_massnahme_typ_bez

   FROM dbp_view.v_in_mass_typ_spr_zu_1 de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_in_mass_typ_spr_zu_1
   WHERE spr_id = 108
   ) ls
   ON de.in_massnahme_typ_id = ls.in_massnahme_typ_id

   WHERE de.spr_id=22
   ;