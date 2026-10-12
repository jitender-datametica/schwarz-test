CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_charge_ist_soll_qa_check_2 (wup_id, nb_id,
mandant_id, dat_lief_soll, art_id, gp_id, charge_id, gtin_vorhanden_fg, gp_charge_nr, lagernummer_id, tour_id,
lief_beleg_id, charge_nr_qa, dat_aenderung, anz_kolli_ist, qa_status, freitext_hinweis_fuer_qa_ist,
freitext_produzent_ist, ursprungsland_kbez_soll, ursprungsland_kbez_ist, ursprungsland_kbez_dev, handelsklasse_soll_kz,
handelsklasse_ist_kz, handelsklasse_kz_dev, unbehandelt_soll_kz, unbehandelt_ist_kz, unbehandelt_kz_dev,
transport_verpackung_kmo_soll_kz, transport_verpackung_kmo_ist_kz, transport_verpackung_km_dev, kaliber_von_soll,
kaliber_von_ist, kaliber_von_dev, kaliber_bis_soll, kaliber_bis_ist, kaliber_bis_dev, kollifaktor, anz_kolli,
kollifaktor_dev, freitext_besonderheiten_soll, freitext_besonderheiten_ist, freitext_besonderheiten_dev,
freitext_spezifikation_soll, freitext_spezifikation_ist, freitext_spezifikation_dev, charge_vorhanden_soll_fg,
charge_vorhanden_ist_fg, charge_vorhanden_fg_dev, freitext_temperatur_check_soll, freitext_temperatur_check_ist,
freitext_temperatur_check_dev, freitext_fruchtfleischdruck_soll, freitext_fruchtfleischdruck_ist,
freitext_fruchtfleischdruck_dev, freitext_saftgehalt_soll, freitext_saftgehalt_ist, freitext_saftgehalt_dev,
freitext_lieferanten_kommentar_soll, freitext_lieferanten_kommentar_ist, freitext_lieferanten_kommentar_dev,
nettoinhalt_kolli_soll, nettoinhalt_kolli_ist, nettoinhalt_kolli_dev, freitext_primaerverpackung_soll,
freitext_primaerverpackung_ist, freitext_primaerverpackung_dev, freitext_qa_kommentar_soll, freitext_qa_kommentar_ist,
freitext_qa_kommentar_dev, kontrollnotwendigkeit_vorerntenummer_soll_fg, kontrollnotwendigkeit_vorerntenummer_ist_fg,
kontrollnotwendigkeit_vorerntenummer_fg_dev, freitext_marke_soll, freitext_marke_ist, freitext_marke_dev,
freitext_fruchtgehalt_soll, freitext_fruchtgehalt_ist, freitext_fruchtgehalt_dev, dat_empfang, datzeit_eingang,
dat_antwort, datzeit_antwort, anz_kolli_geprueft_ist, defekte_kolli_ist, menge_stichprobe_frischemaengel,
menge_stichprobe_sonstiges, dev_fg) AS SELECT v011.wup_id,
 v011.nb_id,
 v011.mandant_id,
 V01.dat_lief_soll,
 v011.art_id,
 V01.gp_id,
 V02.charge_id,
 V02.gtin_vorhanden_fg,
 V03.gp_charge_nr,
 V02.lagernummer_id,
 V02.tour_id,
 V01.lief_beleg_id,
 V02.charge_nr_qa,
 V02.dat_aenderung,
 V02.anz_kolli_ist,
 V02.qa_status,
 V02.freitext_hinweis_fuer_qa_ist,
 V02.freitext_produzent_ist,
 V03.ursprungsland_kbez_soll,
 V02.ursprungsland_kbez_ist,
  CASE
  WHEN V03.ursprungsland_kbez_soll <> V02.ursprungsland_kbez_ist
  THEN 'YES'
  ELSE 'NO'
  END AS ursprungsland_kbez_dev,
 V03.handelsklasse_soll_kz,
 V02.handelsklasse_ist_kz,
  CASE
  WHEN V03.handelsklasse_soll_kz <> V02.handelsklasse_ist_kz
  THEN 'YES'
  ELSE 'NO'
  END AS handelsklasse_kz_dev,
 V03.unbehandelt_soll_kz,
 V02.unbehandelt_ist_kz,
  CASE
  WHEN V03.unbehandelt_soll_kz <> V02.unbehandelt_ist_kz
  THEN 'YES'
  ELSE 'NO'
  END AS unbehandelt_kz_dev,
 V03.transport_verpackung_kmo_soll_kz,
 V02.transport_verpackung_kmo_ist_kz,
  CASE
  WHEN V03.transport_verpackung_kmo_soll_kz <> V02.transport_verpackung_kmo_ist_kz
  THEN 'YES'
  ELSE 'NO'
  END AS transport_verpackung_km_dev,
 V03.kaliber_von_soll,
 V02.kaliber_von_ist,
  CASE
  WHEN V03.kaliber_von_soll <> V02.kaliber_von_ist
  THEN 'YES'
  ELSE 'NO'
  END AS kaliber_von_dev,
 V03.kaliber_bis_soll,
 V02.kaliber_bis_ist,
  CASE
  WHEN V03.kaliber_bis_soll <> V02.kaliber_bis_ist
  THEN 'YES'
  ELSE 'NO'
  END AS kaliber_bis_dev,
 V03.kollifaktor,
 SUM(V02.anz_kolli) OVER (PARTITION BY v011.wup_id, v011.nb_id, v011.mandant_id, V01.dat_lief_soll, v011.art_id, V01.gp_id
    , V02.charge_id, V02.charge_nr_qa RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_kolli,
  CASE
  WHEN V03.kollifaktor <> V02.anz_kolli
  THEN 'YES'
  ELSE 'NO'
  END AS kollifaktor_dev,
 V03.freitext_besonderheiten_soll,
 V02.freitext_besonderheiten_ist,
  CASE
  WHEN V03.freitext_besonderheiten_soll <> V02.freitext_besonderheiten_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_besonderheiten_dev,
 V03.freitext_spezifikation_soll,
 V02.freitext_spezifikation_ist,
  CASE
  WHEN V03.freitext_spezifikation_soll <> V02.freitext_spezifikation_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_spezifikation_dev,
 V03.charge_vorhanden_soll_fg,
 V02.charge_vorhanden_ist_fg,
  CASE
  WHEN V03.charge_vorhanden_soll_fg <> V02.charge_vorhanden_ist_fg
  THEN 'YES'
  ELSE 'NO'
  END AS charge_vorhanden_fg_dev,
 V03.freitext_temperatur_check_soll,
 V02.freitext_temperatur_check_ist,
  CASE
  WHEN V03.freitext_temperatur_check_soll <> V02.freitext_temperatur_check_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_temperatur_check_dev,
 V03.freitext_fruchtfleischdruck_soll,
 V02.freitext_fruchtfleischdruck_ist,
  CASE
  WHEN V03.freitext_fruchtfleischdruck_soll <> V02.freitext_fruchtfleischdruck_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_fruchtfleischdruck_dev,
 V03.freitext_saftgehalt_soll,
 V02.freitext_saftgehalt_ist,
  CASE
  WHEN V03.freitext_saftgehalt_soll <> V02.freitext_saftgehalt_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_saftgehalt_dev,
 V03.freitext_lieferanten_kommentar_soll,
 V02.freitext_lieferanten_kommentar_ist,
  CASE
  WHEN V03.freitext_lieferanten_kommentar_soll <> V02.freitext_lieferanten_kommentar_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_lieferanten_kommentar_dev,
 V03.nettoinhalt_kolli_soll,
 V02.nettoinhalt_kolli_ist,
  CASE
  WHEN V03.nettoinhalt_kolli_soll <> V02.nettoinhalt_kolli_ist
  THEN 'YES'
  ELSE 'NO'
  END AS nettoinhalt_kolli_dev,
 V03.freitext_primaerverpackung_soll,
 V02.freitext_primaerverpackung_ist,
  CASE
  WHEN V03.freitext_primaerverpackung_soll <> V02.freitext_primaerverpackung_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_primaerverpackung_dev,
 V03.freitext_qa_kommentar_soll,
 V02.freitext_qa_kommentar_ist,
  CASE
  WHEN V03.freitext_qa_kommentar_soll <> V02.freitext_qa_kommentar_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_qa_kommentar_dev,
 V03.kontrollnotwendigkeit_vorerntenummer_soll_fg,
 V02.kontrollnotwendigkeit_vorerntenummer_ist_fg,
  CASE
  WHEN V03.kontrollnotwendigkeit_vorerntenummer_soll_fg <> V02.kontrollnotwendigkeit_vorerntenummer_ist_fg
  THEN 'YES'
  ELSE 'NO'
  END AS kontrollnotwendigkeit_vorerntenummer_fg_dev,
 V03.freitext_marke_soll,
 V02.freitext_marke_ist,
  CASE
  WHEN V03.freitext_marke_soll <> V02.freitext_marke_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_marke_dev,
 V03.freitext_fruchtgehalt_soll,
 V02.freitext_fruchtgehalt_ist,
  CASE
  WHEN V03.freitext_fruchtgehalt_soll <> V02.freitext_fruchtgehalt_ist
  THEN 'YES'
  ELSE 'NO'
  END AS freitext_fruchtgehalt_dev,
 V02.dat_empfang,
 V02.datzeit_eingang,
 V02.dat_antwort,
 V02.zeit_antwort AS datzeit_antwort,
 V02.anz_kolli_geprueft_ist,
 V02.defekte_kolli_ist,
 V02.menge_stichprobe_frischemaengel,
 V02.menge_stichprobe_sonstiges,
  CASE
  WHEN GREATEST(CASE
     WHEN CASE
       WHEN V03.ursprungsland_kbez_soll <> V02.ursprungsland_kbez_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.handelsklasse_soll_kz <> V02.handelsklasse_ist_kz
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.unbehandelt_soll_kz <> V02.unbehandelt_ist_kz
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.transport_verpackung_kmo_soll_kz <> V02.transport_verpackung_kmo_ist_kz
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.kaliber_von_soll <> V02.kaliber_von_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.kaliber_bis_soll <> V02.kaliber_bis_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.kollifaktor <> V02.anz_kolli
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_besonderheiten_soll <> V02.freitext_besonderheiten_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_spezifikation_soll <> V02.freitext_spezifikation_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.charge_vorhanden_soll_fg <> V02.charge_vorhanden_ist_fg
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_temperatur_check_soll <> V02.freitext_temperatur_check_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_fruchtfleischdruck_soll <> V02.freitext_fruchtfleischdruck_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_saftgehalt_soll <> V02.freitext_saftgehalt_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_lieferanten_kommentar_soll <> V02.freitext_lieferanten_kommentar_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.nettoinhalt_kolli_soll <> V02.nettoinhalt_kolli_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_primaerverpackung_soll <> V02.freitext_primaerverpackung_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_qa_kommentar_soll <> V02.freitext_qa_kommentar_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.kontrollnotwendigkeit_vorerntenummer_soll_fg <> V02.kontrollnotwendigkeit_vorerntenummer_ist_fg
       THEN 'YES'
       ELSE 'NO'
       END = 'yes'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_marke_soll <> V02.freitext_marke_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END, CASE
     WHEN CASE
       WHEN V03.freitext_fruchtgehalt_soll <> V02.freitext_fruchtgehalt_ist
       THEN 'YES'
       ELSE 'NO'
       END = 'YES'
     THEN 1
     ELSE 0
     END) = 1
  THEN 1
  ELSE 0
  END AS flag
FROM kfl_production_dbp_view.v_besch_lief_2 AS V01
 INNER JOIN (SELECT S1.mandant_id,
   S1.lief_beleg_id,
   S1.kj,
   S1.art_id,
   S1.wup_id,
   S1.nb_id,
   S1.dat_lief_soll,
   SUM(S1.menge_lief_ist_kolli) AS we_menge_kolli,
   SUM(S1.menge_lief_ist_bme) AS we_menge_bme
  FROM kfl_production_dbp_view.v_besch_lief_det_2 AS S1
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS S2 ON S1.dat_lief_soll = S2.dat
  WHERE S2.akt_kj BETWEEN -2 AND 0
  GROUP BY S1.mandant_id,
   S1.lief_beleg_id,
   S1.kj,
   S1.art_id,
   S1.wup_id,
   S1.nb_id,
   S1.dat_lief_soll) AS v011 ON V01.mandant_id = v011.mandant_id AND V01.lief_beleg_id = v011.lief_beleg_id AND V01.kj =
    v011.kj AND V01.dat_lief_soll = v011.dat_lief_soll
 INNER JOIN kfl_production_dbp_view.v_charge_ist_qa_check_2 AS V02 ON v011.mandant_id = V02.mandant_id AND v011.lief_beleg_id
       = V02.lief_beleg_id AND v011.art_id = V02.art_id AND v011.wup_id = V02.wup_id AND v011.nb_id = V02.nb_id
 LEFT JOIN kfl_production_dbp_view.v_charge_soll_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.charge_id = V03.charge_id
      AND V02.gp_id = V03.gp_id AND V02.art_id = V03.art_id;