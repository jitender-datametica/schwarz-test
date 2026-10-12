-- 11.04.2013 twie: Lookup für Markttyp, keine Sprachtabelle vorhanden

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ginfo_markt_typ AS SELECT ginfo_markt_typ,
  CASE
  WHEN ginfo_markt_typ = ''
  THEN ''
  ELSE ginfo_markt_typ_bez
  END AS ginfo_markt_typ_bez
FROM kfl_production_dbp_view.v_l_ginfo_markt_typ;
