CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_L_MASS_TYP_1 AS
-- 05.04.2013 twie: Lookup für Massnahmentyp

   SELECT
   in_massnahme_typ_id
   FROM dbp_view.v_in_l_mass_typ_1;