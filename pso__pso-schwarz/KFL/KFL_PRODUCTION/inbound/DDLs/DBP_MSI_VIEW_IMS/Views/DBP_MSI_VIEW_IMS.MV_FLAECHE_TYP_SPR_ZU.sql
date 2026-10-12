CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_FLAECHE_TYP_SPR_ZU
-- 12.04.2013 twie: Sprachtabelle für Flächentyp
-- 19.08.2013 twie: nur deutsche View, keine Übersetzungen vorhanden, Attribut sprachunabhängig
-- 20.08.2013/Gia

AS
   SELECT
   ginfo_flaeche_typ_id,
   mandant_id,
   ginfo_flaeche_typ_bez
   FROM  dbp_view.v_ginfo_flaeche_typ_spr_zu

   WHERE  spr_id = 22
;