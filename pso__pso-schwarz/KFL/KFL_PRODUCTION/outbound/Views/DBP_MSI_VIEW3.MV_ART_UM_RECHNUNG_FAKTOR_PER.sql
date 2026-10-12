CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_art_um_rechnung_faktor_per (mandant_id, alt_menge_einh_id, art_id
, dat_von, bruttogew, umrech_faktor, gew_einh_id, dat_bis, laenge, breite, hoehe) AS SELECT T1.mandant_id,
 T1.altnv_menge_einh_id AS alt_menge_einh_id,
 T1.art_id,
 T1.dat_von,
 T1.bruttogew,
  CAST(T1.umrech_zaehler AS BIGNUMERIC) / CAST(T1.umrech_nenner AS BIGNUMERIC) AS umrech_faktor,
 T1.gew_einh_id,
 T1.dat_bis,
 T1.laenge,
 T1.breite,
 T1.hoehe
FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per AS T1
 LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS T2 ON T1.art_id = T2.art_id AND T1.mandant_id = T2.mandant_id
     AND T1.altnv_menge_einh_id = T2.paletten_faktor_einh_id
WHERE T1.dat_bis = DATE '9999-12-31'
 AND T2.dat_bis = DATE '9999-12-31';