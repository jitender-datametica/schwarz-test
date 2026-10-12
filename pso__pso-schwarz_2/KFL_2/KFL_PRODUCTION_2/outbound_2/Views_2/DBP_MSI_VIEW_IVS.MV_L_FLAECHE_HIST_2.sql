CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_flaeche_hist_2 (mandant_id, flaeche_id, dat_von, dat_bis,
flaeche_status_id, immo_objekt_id, gebaeude_id, etage, nutzung_id, flaeche_groesse, flaecheart_id, dat_existiert_seit,
dat_existiert_bis) AS SELECT FL.mandant_id,
 FL.flaeche_id,
 FL.dat_von,
 FL.dat_bis,
 mfszp.flaeche_status_id_ AS flaeche_status_id,
 FL.immo_objekt_id,
 FL.gebaeude_id,
 FL.etage,
 FL.nutzung_id,
 FL.flaeche_groesse,
 FL.flaecheart_id,
 FL.dat_existiert_seit,
 FL.dat_existiert_bis
FROM kfl_production_dbp_view.v_ivs_flaeche_per_2 AS FL
 INNER JOIN (SELECT mandant_id,
   flaeche_id,
   MAX(flaeche_status_id) AS flaeche_status_id_
  FROM kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
  GROUP BY mandant_id,
   flaeche_id) AS mfszp ON FL.mandant_id = mfszp.mandant_id AND FL.flaeche_id = mfszp.flaeche_id
WHERE FL.dat_bis = DATE '9999-12-31';