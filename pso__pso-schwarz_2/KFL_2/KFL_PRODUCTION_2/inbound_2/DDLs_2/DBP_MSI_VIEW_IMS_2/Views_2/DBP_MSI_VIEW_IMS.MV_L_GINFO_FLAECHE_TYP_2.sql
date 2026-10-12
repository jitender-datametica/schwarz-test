CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GINFO_FLAECHE_TYP_2 AS
-- 12.04.2013 twie: Lookup für Flächentyp

   SELECT
   ginfo_flaeche_typ_id,
   mandant_id
   FROM dbp_view.v_l_ginfo_flaeche_typ_2  ;