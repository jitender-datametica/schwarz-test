CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_f_ginfo_flaeche_per_2 AS SELECT wp.mandant_id,
 wp.nb_id,
 wp.wup_id,
 tpl.techn_platz_id,
 FLP.ginfo_flaeche_id,
 FLP.ginfo_flaeche_typ_id,
 FLP.ginfo_flaeche_netto,
 FLP.ginfo_flaeche_brutto,
 FLP.ginfo_achse_wert,
 FLP.ginfo_achse_typ_id
FROM (SELECT mandant_id,
   nb_id,
   wup_id
  FROM kfl_production_dbp_view.v_wup_2) AS wp
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id
  FROM kfl_production_dbp_view.v_techn_platz_per_2
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE '9999-12-31') AS tpl ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
 LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS FLP ON tpl.techn_platz_id = FLP.techn_platz_id AND
   CURRENT_DATE BETWEEN FLP.dat_von AND FLP.dat_bis;