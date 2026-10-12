CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_MASS_TYP_SPR_ZU_2 AS
-- 05.04.2013 twie: Sprachzuordnung für Massnahmentyp

   SELECT
   in_massnahme_typ_id,
   in_massnahme_typ_bez
   FROM dbp_view.v_in_mass_typ_spr_zu_2
   WHERE  spr_id=22;