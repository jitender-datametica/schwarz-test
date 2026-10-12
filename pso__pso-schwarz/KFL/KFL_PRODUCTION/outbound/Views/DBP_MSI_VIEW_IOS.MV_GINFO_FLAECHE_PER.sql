CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_flaeche_per AS SELECT GINFO_FL.mandant_id,
 GINFO_FL.techn_platz_id,
 GINFO_FL.ginfo_flaeche_id,
 t.kjmo,
 GINFO_FL.ginfo_flaeche_netto,
 GINFO_FL.ginfo_flaeche_brutto,
 GINFO_FL.ginfo_achse_wert,
 GINFO_FL.ginfo_achse_typ_id,
 GINFO_FL.ginfo_flaeche_typ_id
FROM kfl_production_dbp_view.v_ginfo_flaeche_per AS GINFO_FL
 INNER JOIN (SELECT MAX(dat) AS max_tag,
   kjmo
  FROM kfl_production_dbp_view.v_tag
  WHERE dat BETWEEN DATE '2008-07-01' AND (CURRENT_DATE)
  GROUP BY kjmo) AS t ON t.max_tag BETWEEN GINFO_FL.dat_von AND GINFO_FL.dat_bis;