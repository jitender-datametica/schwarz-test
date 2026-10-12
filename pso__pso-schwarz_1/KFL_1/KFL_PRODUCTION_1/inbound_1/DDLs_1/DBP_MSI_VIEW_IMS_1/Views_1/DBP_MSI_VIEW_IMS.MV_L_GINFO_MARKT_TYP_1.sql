CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GINFO_MARKT_TYP_1 AS
-- 11.04.2013 twie: Lookup für Markttyp, keine Sprachtabelle vorhanden

   SELECT
   ginfo_markt_typ,
   CASE WHEN ginfo_markt_typ = '' THEN ''
ELSE ginfo_markt_typ_bez
END AS ginfo_markt_typ_bez

FROM dbp_view.v_l_ginfo_markt_typ_1;