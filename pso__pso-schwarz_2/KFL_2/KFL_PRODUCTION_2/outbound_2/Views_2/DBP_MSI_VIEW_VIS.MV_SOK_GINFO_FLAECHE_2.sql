CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_ginfo_flaeche_2 (mandant_id, ginfo_flaeche_id,
ginfo_flaeche_typ_id, techn_platz_id, flaeche_quelle_id, wup_id, ginfo_flaeche_netto, ginfo_flaeche_brutto,
ginfo_achse_wert, ginfo_achse_typ_id, kjmo) AS SELECT FL.mandant_id,
 FL.ginfo_flaeche_id,
 FL.ginfo_flaeche_typ_id,
 FL.techn_platz_id,
 FL.flaeche_quelle_id,
 WUP.aktuell_wup_id AS wup_id,
 FLP.ginfo_flaeche_netto,
 FLP.ginfo_flaeche_brutto,
 FLP.ginfo_achse_wert,
 FLP.ginfo_achse_typ_id,
 kjmo0.kjmo
FROM kfl_production_dbp_view.v_l_ginfo_flaeche_2 AS FL
 INNER JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS FLP ON FL.mandant_id = FLP.mandant_id AND FL.ginfo_flaeche_id
      = FLP.ginfo_flaeche_id AND FL.ginfo_flaeche_typ_id = FLP.ginfo_flaeche_typ_id AND FL.techn_platz_id = FLP.techn_platz_id
   
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_wup_techn_platz_2 AS TPL ON FLP.techn_platz_id = TPL.techn_platz_id
 INNER JOIN (SELECT kjmo,
   mo_dat_von
  FROM kfl_production_dbp_msi_view_vis.mv_monat_2
  WHERE akt_mo = 0) AS kjmo0 ON kjmo0.mo_dat_von BETWEEN FLP.dat_von AND FLP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON TPL.mandant_id = WUP.mandant_id AND TPL.wup_id = WUP.wup_id;