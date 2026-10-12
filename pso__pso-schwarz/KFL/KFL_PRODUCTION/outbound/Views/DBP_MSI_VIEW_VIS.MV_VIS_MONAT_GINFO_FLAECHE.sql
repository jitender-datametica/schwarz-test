CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_ginfo_flaeche (mandant_id, nb_id, wup_id,
techn_platz_id, land_id, ginfo_flaeche_typ_id, ginfo_flaeche_id, ginfo_flaeche_brutto, ginfo_achse_typ_id,
ginfo_achse_wert, kjmo) AS SELECT v01.mandant_id,
 v01.nb_id,
 v01.wup_id,
 v02.techn_platz_id,
 v02.land_id,
 v03.ginfo_flaeche_typ_id,
 v03.ginfo_flaeche_id,
 v03.ginfo_flaeche_brutto,
 v03.ginfo_achse_typ_id,
 v03.ginfo_achse_wert,
 v03.kjmo
FROM (SELECT mandant_id,
   nb_id,
   wup_id
  FROM kfl_production_dbp_view.v_wup
  WHERE nb_id IN (0)
   AND dat_eroeffnung > DATE '1900-01-01'
   AND aktuell_wup_id = wup_id) AS v01
 INNER JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id,
   land_id
  FROM kfl_production_dbp_view.v_techn_platz_per
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE '9999-12-31') AS v02 ON v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
 INNER JOIN (SELECT S01.mandant_id,
   S01.techn_platz_id,
   S01.ginfo_flaeche_typ_id,
   S01.ginfo_flaeche_id,
   S01.ginfo_flaeche_brutto,
   S01.ginfo_achse_typ_id,
   S01.ginfo_achse_wert,
   s02.kjmo
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per AS S01
   INNER JOIN (SELECT kjmo,
     max_dat
    FROM kfl_production_dbp_view.v_monat
    WHERE akt_gj IN (- 1, 0)) AS s02 ON s02.max_dat BETWEEN S01.dat_von AND S01.dat_bis) AS v03 ON v02.techn_platz_id =
  v03.techn_platz_id;