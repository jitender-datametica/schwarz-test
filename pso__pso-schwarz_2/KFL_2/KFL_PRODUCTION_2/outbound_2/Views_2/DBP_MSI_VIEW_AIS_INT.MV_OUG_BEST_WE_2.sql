CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_oug_best_we_2 (mandant_id, dat_lief_soll, wup_id, nb_id,
art_id, gp_id, lief_beleg_id, einstandspreis, ek_mep, logistikkostenzuschlag, bestellung_menge_kolli,
bestellung_menge_bme, we_menge_kolli, we_menge_bme, freitext_produzent_ist, freitext_marke_ist,
freitext_primaerverpackung_ist, freitext_transport_verpackung_de_ist, transport_verpackung_kmo_ist_kz,
transportverpackung_ist, ursprungsland_kbez_ist, zus_ursprungslaender_kbez_ist, handelsklasse_ist_kz, unbehandelt_ist_kz
, vertragsanbau_ist_fg, nationale_produktion_ist_fg, freitext_hinweis_fuer_qa_ist,
kontrollnotwendigkeit_vorerntenummer_ist_fg, freitext_qa_kommentar_ist, freitext_besonderheiten_ist,
freitext_spezifikation_ist, freitext_lieferanten_kommentar_ist, freitext_temperatur_check_ist,
freitext_fruchtfleischdruck_ist, freitext_fruchtgehalt_ist, freitext_saftgehalt_ist, lagernummer_id, zeit_antwort,
gtin_vorhanden_fg, qa_status, kaliber_kz_ist, kaliber_von_ist, kaliber_bis_ist, palettenfaktor_ist,
nettoinhalt_kolli_ist, anz_kolli, anz_gepruefte_kolli, anz_defekte_kolli, menge_strichprobe_frischemaengel,
menge_strichprobe_sonstiges, anz_kolli_ist, charge_id_ist, charge_vorhanden_ist_fg, charge_nr_qa, qa_mangel_id,
qa_deklarationsfehler_id, kommentar_qa_txt, kommentar_ek_txt, datzeit_eingang, dat_antwort, datzeit_abw, charge_id,
gp_charge_nr, charge_vorhanden_soll_fg, kaliber_kz_soll, kaliber_von_soll, kaliber_bis_soll, palettenfaktor_soll,
kollifaktor, nettoinhalt_kolli_soll, freitext_marke_soll, freitext_primaerverpackung_soll,
freitext_transport_verpackung_de_soll, transport_verpackung_kmo_soll_kz, transportverpackung_soll, gtin_fg,
ursprungsland_kbez_soll, zus_ursprungslaender_kbez_soll, handelsklasse_soll_kz, unbehandelt_soll_kz,
vertragsanbau_soll_fg, nationale_produktion_soll_fg, kontrollnotwendigkeit_vorerntenummer_soll_fg,
freitext_qa_kommentar_soll, freitext_besonderheiten_soll, freitext_spezifikation_soll,
freitext_lieferanten_kommentar_soll, freitext_temperatur_check_soll, freitext_fruchtfleischdruck_soll,
freitext_fruchtgehalt_soll, freitext_saftgehalt_soll, ursprungslaender_kbez_abw, palettenfaktor_abw, vertragsanbau_abw,
nationale_produktion_fg_abw, ursprungsland_kbez_abw, handelsklasse_kz_abw, unbehandelt_kz_abw, transportverpackung_abw,
kaliber_von_abw, kaliber_bis_abw, anz_kolli_abw, gtin_abw, freitext_besonderheiten_abw, freitext_spezifikation_abw,
freitext_temperatur_check_abw, freitext_fruchtfleischdruck_abw, freitext_saftgehalt_abw,
freitext_lieferanten_kommentar_abw, nettoinhalt_kolli_abw, freitext_primaerverpackung_abw, freitext_qa_kommentar_abw,
kontrollneintwendigkeit_vorerntenummer_fg_abw, freitext_marke_abw, charge_vorhanden_fg_abw, freitext_fruchtgehalt_abw,
qa_deklarationsfehler_bez, qa_deklarationsfehler_bez_de, qa_deklarationsfehler_bez_cz, qa_deklarationsfehler_bez_sk,
qa_deklarationsfehler_bez_hr, qa_deklarationsfehler_bez_pl, qa_deklarationsfehler_bez_ro, qa_deklarationsfehler_bez_bg,
qa_mangel_bez, qa_mangel_bez_de, qa_mangel_bez_cz, qa_mangel_bez_sk, qa_mangel_bez_hr, qa_mangel_bez_pl,
qa_mangel_bez_ro, qa_mangel_bez_bg) AS SELECT V01.mandant_id,
 V01.dat_lief_soll,
 v011.wup_id,
 v011.nb_id,
 v011.art_id,
 V01.gp_id,
 V01.lief_beleg_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v03.einstandspreis, v04.einstandspreis)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v03.einstandspreis, v04.einstandspreis) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v03.einstandspreis, v04.einstandspreis) * V400.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS einstandspreis,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v03.ek_mep, v04.ek_mep)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v03.ek_mep, v04.ek_mep) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v03.ek_mep, v04.ek_mep) * V400.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS ek_mep,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v03.logistikkostenzuschlag, v04.logistikkostenzuschlag)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v03.logistikkostenzuschlag, v04.logistikkostenzuschlag) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v03.logistikkostenzuschlag, v04.logistikkostenzuschlag) * V400.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS logistikkostenzuschlag,
 v05.anz_kolli_ist AS bestellung_menge_kolli,
  v05.anz_kolli * v05.anz_kolli_ist AS bestellung_menge_bme,
 CAST(CASE
   WHEN v05.qa_status = 'Verweigerung'
   THEN 0
   WHEN t15.qa_status_count > 1 AND t11.anzahl_kolli_ist > 0
   THEN v011.we_menge_kolli / t11.anzahl_kolli_ist * v05.anz_kolli_ist
   ELSE v011.we_menge_kolli
   END AS NUMERIC) AS we_menge_kolli,
 CAST(CASE
   WHEN v05.qa_status = 'Verweigerung'
   THEN 0
   WHEN t15.qa_status_count > 1 AND t11.anzahl_kolli_ist > 0
   THEN v011.we_menge_bme / t11.anzahl_kolli_ist * v05.anz_kolli_ist
   ELSE v011.we_menge_bme
   END AS NUMERIC) AS we_menge_bme,
 v05.freitext_produzent_ist,
 v05.freitext_marke_ist,
 v05.freitext_primaerverpackung_ist,
 v05.freitext_transport_verpackung_de_ist,
 v05.transport_verpackung_kmo_ist_kz,
 v05.transportverpackung_ist,
 v05.ursprungsland_kbez_ist,
 v05.zus_ursprungslaender_kbez_ist,
 v05.handelsklasse_ist_kz,
 v05.unbehandelt_ist_kz,
 v05.vertragsanbau_ist_fg,
 v05.nationale_produktion_ist_fg,
 v05.freitext_hinweis_fuer_qa_ist,
 v05.kontrollnotwendigkeit_vorerntenummer_ist_fg,
 v05.freitext_qa_kommentar_ist,
 v05.freitext_besonderheiten_ist,
 v05.freitext_spezifikation_ist,
 v05.freitext_lieferanten_kommentar_ist,
 v05.freitext_temperatur_check_ist,
 v05.freitext_fruchtfleischdruck_ist,
 v05.freitext_fruchtgehalt_ist,
 v05.freitext_saftgehalt_ist,
 v05.lagernummer_id,
 v05.zeit_antwort,
 v05.gtin_vorhanden_fg,
 v05.qa_status,
 v05.kaliber_kz_ist,
 v05.kaliber_von_ist,
 v05.kaliber_bis_ist,
 v05.palettenfaktor_ist,
 v05.nettoinhalt_kolli_ist,
 v05.anz_kolli,
 v05.anz_gepruefte_kolli,
 v05.anz_defekte_kolli,
 v05.menge_strichprobe_frischemaengel,
 v05.menge_strichprobe_sonstiges,
 v05.anz_kolli_ist,
 v05.charge_id AS charge_id_ist,
 v05.charge_vorhanden_ist_fg,
 v05.charge_nr_qa,
 v50.qa_mangel_id,
 v50.qa_deklarationsfehler_id,
 v50.kommentar_qa_txt,
 v50.kommentar_ek_txt,
 v50.datzeit_eingang,
 v50.dat_antwort,
  CASE
  WHEN COALESCE(v50.datzeit_eingang, v05.zeit_antwort) IS NOT NULL
  THEN LPAD(SUBSTR(CAST(MOD(DATETIME_DIFF(v05.zeit_antwort, v50.datzeit_eingang, DAY), 24) AS STRING), 1, 10), 2, '0')
        || ':' || LPAD(SUBSTR(CAST(MOD(DATETIME_DIFF(v05.zeit_antwort, v50.datzeit_eingang, HOUR), 24) AS STRING), 1, 10
         ), 2, '0') || ':' || LPAD(SUBSTR(CAST(MOD(DATETIME_DIFF(v05.zeit_antwort, v50.datzeit_eingang, MINUTE), 60) AS STRING)
       , 1, 10), 2, '0') || ':' || LPAD(SUBSTR(CAST(MOD(DATETIME_DIFF(v05.zeit_antwort, v50.datzeit_eingang, SECOND), 60) AS STRING)
     , 1, 10), 2, '0')
  ELSE NULL
  END AS datzeit_abw,
 V06.charge_id,
 V06.gp_charge_nr,
  CASE
  WHEN V06.charge_vorhanden_soll_fg = 1
  THEN 'X'
  ELSE ''
  END AS charge_vorhanden_soll_fg1,
 V06.kaliber_kz_soll,
 V06.kaliber_von_soll,
 V06.kaliber_bis_soll,
 V06.palettenfaktor_soll,
 V06.kollifaktor,
 V06.nettoinhalt_kolli_soll,
 V06.freitext_marke_soll,
 V06.freitext_primaerverpackung_soll,
 V06.freitext_transport_verpackung_de_soll,
 V06.transport_verpackung_kmo_soll_kz,
  CASE
  WHEN V01.mandant_id = 1
  THEN V06.freitext_transport_verpackung_de_soll
  ELSE V06.transport_verpackung_kmo_soll_kz
  END AS transportverpackung_soll,
 V06.gtin_fg,
 V06.ursprungsland_kbez_soll,
 V06.zus_ursprungslaender_kbez_soll,
 V06.handelsklasse_soll_kz,
 V06.unbehandelt_soll_kz,
 V06.vertragsanbau_soll_fg,
 V06.nationale_produktion_soll_fg,
 V06.kontrollnotwendigkeit_vorerntenummer_soll_fg,
 V06.freitext_qa_kommentar_soll,
 V06.freitext_besonderheiten_soll,
 V06.freitext_spezifikation_soll,
 V06.freitext_lieferanten_kommentar_soll,
 V06.freitext_temperatur_check_soll,
 V06.freitext_fruchtfleischdruck_soll,
 V06.freitext_fruchtgehalt_soll,
 V06.freitext_saftgehalt_soll,
  CASE
  WHEN v05.zus_ursprungslaender_kbez_ist <> V06.zus_ursprungslaender_kbez_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS ursprungslaender_kbez_abw,
  CASE
  WHEN v05.palettenfaktor_ist <> V06.palettenfaktor_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS palettenfaktor_abw,
  CASE
  WHEN v05.vertragsanbau_ist_fg <> V06.vertragsanbau_soll_fg
  THEN 'Ja'
  ELSE 'Nein'
  END AS vertragsanbau_abw,
  CASE
  WHEN v05.nationale_produktion_ist_fg <> V06.nationale_produktion_soll_fg
  THEN 'Ja'
  ELSE 'Nein'
  END AS nationale_produktion_fg_abw,
  CASE
  WHEN v05.ursprungsland_kbez_ist <> V06.ursprungsland_kbez_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS ursprungsland_kbez_abw,
  CASE
  WHEN v05.handelsklasse_ist_kz <> V06.handelsklasse_soll_kz
  THEN 'Ja'
  ELSE 'Nein'
  END AS handelsklasse_kz_abw,
  CASE
  WHEN v05.unbehandelt_ist_kz <> V06.unbehandelt_soll_kz
  THEN 'Ja'
  ELSE 'Nein'
  END AS unbehandelt_kz_abw,
  CASE
  WHEN v05.transportverpackung_ist <> CASE
    WHEN V01.mandant_id = 1
    THEN V06.freitext_transport_verpackung_de_soll
    ELSE V06.transport_verpackung_kmo_soll_kz
    END
  THEN 'Ja'
  ELSE 'Nein'
  END AS transportverpackung_abw,
  CASE
  WHEN v05.kaliber_von_ist <> V06.kaliber_von_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS kaliber_von_abw,
  CASE
  WHEN v05.kaliber_bis_ist <> V06.kaliber_bis_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS kaliber_bis_abw,
  CASE
  WHEN v05.anz_kolli <> V06.kollifaktor
  THEN 'Ja'
  ELSE 'Nein'
  END AS anz_kolli_abw,
  CASE
  WHEN v05.gtin_vorhanden_fg <> V06.gtin_fg
  THEN 'Ja'
  ELSE 'Nein'
  END AS gtin_abw,
  CASE
  WHEN v05.freitext_besonderheiten_ist <> V06.freitext_besonderheiten_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_besonderheiten_abw,
  CASE
  WHEN v05.freitext_spezifikation_ist <> V06.freitext_spezifikation_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_spezifikation_abw,
  CASE
  WHEN v05.freitext_temperatur_check_ist <> V06.freitext_temperatur_check_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_temperatur_check_abw,
  CASE
  WHEN v05.freitext_fruchtfleischdruck_ist <> V06.freitext_fruchtfleischdruck_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_fruchtfleischdruck_abw,
  CASE
  WHEN v05.freitext_saftgehalt_ist <> V06.freitext_saftgehalt_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_saftgehalt_abw,
  CASE
  WHEN v05.freitext_lieferanten_kommentar_ist <> V06.freitext_lieferanten_kommentar_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_lieferanten_kommentar_abw,
  CASE
  WHEN v05.nettoinhalt_kolli_ist <> V06.nettoinhalt_kolli_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS nettoinhalt_kolli_abw,
  CASE
  WHEN v05.freitext_primaerverpackung_ist <> V06.freitext_primaerverpackung_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_primaerverpackung_abw,
  CASE
  WHEN v05.freitext_qa_kommentar_ist <> V06.freitext_qa_kommentar_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_qa_kommentar_abw,
  CASE
  WHEN v05.kontrollnotwendigkeit_vorerntenummer_ist_fg <> V06.kontrollnotwendigkeit_vorerntenummer_soll_fg
  THEN 'Ja'
  ELSE 'Nein'
  END AS kontrollneintwendigkeit_vorerntenummer_fg_abw,
  CASE
  WHEN v05.freitext_marke_ist <> V06.freitext_marke_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_marke_abw,
  CASE
  WHEN v05.charge_vorhanden_ist_fg <> CASE
    WHEN V06.charge_vorhanden_soll_fg = 1
    THEN 'X'
    ELSE ''
    END
  THEN 'Ja'
  ELSE 'Nein'
  END AS charge_vorhanden_fg_abw,
  CASE
  WHEN v05.freitext_fruchtgehalt_ist <> V06.freitext_fruchtgehalt_soll
  THEN 'Ja'
  ELSE 'Nein'
  END AS freitext_fruchtgehalt_abw,
 v07.qa_deklarationsfehler_bez,
 v07.qa_deklarationsfehler_bez_de,
 v07.qa_deklarationsfehler_bez_cz,
 v07.qa_deklarationsfehler_bez_sk,
 v07.qa_deklarationsfehler_bez_hr,
 v07.qa_deklarationsfehler_bez_pl,
 v07.qa_deklarationsfehler_bez_ro,
 v07.qa_deklarationsfehler_bez_bg,
 v08.qa_mangel_bez,
 v08.qa_mangel_bez_de,
 v08.qa_mangel_bez_cz,
 v08.qa_mangel_bez_sk,
 v08.qa_mangel_bez_hr,
 v08.qa_mangel_bez_pl,
 v08.qa_mangel_bez_ro,
 v08.qa_mangel_bez_bg
FROM kfl_production_dbp_view.v_besch_lief_2 AS V01
 INNER JOIN (SELECT S1.mandant_id,
   S1.lief_beleg_id,
   S1.kj,
   S1.art_id,
   S1.wup_id,
   S1.nb_id,
   S1.vorlage_beleg_id,
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
   S1.vorlage_beleg_id,
   S1.dat_lief_soll) AS v011 ON V01.mandant_id = v011.mandant_id AND V01.lief_beleg_id = v011.lief_beleg_id AND V01.kj =
    v011.kj AND V01.dat_lief_soll = v011.dat_lief_soll
 INNER JOIN (SELECT S10.mandant_id,
   S10.best_beleg_id,
   S10.art_id,
   S10.wup_id,
   S10.nb_id,
   S10.dat_best_beleg,
   SUM(S10.menge_best_kolli) AS bestellung_menge_kolli,
   SUM(S10.menge_best_bme) AS bestellung_menge_bme
  FROM kfl_production_dbp_view.v_besch_best_det_2 AS S10
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS S20 ON S10.dat_best_beleg = S20.dat
  WHERE S20.akt_kj BETWEEN -2 AND 0
  GROUP BY S10.mandant_id,
   S10.best_beleg_id,
   S10.art_id,
   S10.wup_id,
   S10.nb_id,
   S10.dat_best_beleg) AS v022 ON v011.vorlage_beleg_id = v022.best_beleg_id AND v011.mandant_id = v022.mandant_id AND
   v011.art_id = v022.art_id
 INNER JOIN kfl_production_dbp_view.v_besch_best_2 AS V02 ON v022.best_beleg_id = V02.best_beleg_id AND v022.mandant_id =
    V02.mandant_id AND v022.dat_best_beleg = V02.dat_best_beleg
 LEFT JOIN (SELECT mandant_id,
   lief_beleg_id,
   art_id,
   wup_id,
   nb_id,
   gp_id,
   charge_id,
   freitext_produzent_ist,
   freitext_marke_ist,
   freitext_primaerverpackung_ist,
   freitext_transport_verpackung_de_ist,
   transport_verpackung_kmo_ist_kz,
    CASE
    WHEN mandant_id = 1
    THEN freitext_transport_verpackung_de_ist
    ELSE transport_verpackung_kmo_ist_kz
    END AS transportverpackung_ist,
   ursprungsland_kbez_ist,
   zus_ursprungslaender_kbez_ist,
   handelsklasse_ist_kz,
   unbehandelt_ist_kz,
   vertragsanbau_ist_fg,
   nationale_produktion_ist_fg,
   freitext_hinweis_fuer_qa_ist,
   kontrollnotwendigkeit_vorerntenummer_ist_fg,
   freitext_qa_kommentar_ist,
   freitext_besonderheiten_ist,
   freitext_spezifikation_ist,
   freitext_lieferanten_kommentar_ist,
   freitext_temperatur_check_ist,
   freitext_fruchtfleischdruck_ist,
   freitext_fruchtgehalt_ist,
   freitext_saftgehalt_ist,
   lagernummer_id,
   zeit_antwort,
   gtin_vorhanden_fg,
    CASE
    WHEN qa_status IN ('Q')
    THEN 'Query'
    WHEN qa_status IN ('R')
    THEN 'Verweigerung'
    WHEN qa_status IN ('S')
    THEN 'Annahme'
    WHEN qa_status IN ('K')
    THEN 'Annahme mit Abweichung'
    WHEN qa_status IN ('A')
    THEN 'Konzession'
    ELSE ' '
    END AS qa_status,
   kaliber_kz_ist,
   kaliber_von_ist,
   kaliber_bis_ist,
   palettenfaktor_ist,
   nettoinhalt_kolli_ist,
   charge_nr_qa,
    CASE
    WHEN charge_vorhanden_ist_fg = 1
    THEN 'X'
    ELSE ''
    END AS charge_vorhanden_ist_fg,
   SUM(anz_kolli) AS anz_kolli,
   SUM(anz_kolli_geprueft_ist) AS anz_gepruefte_kolli,
   SUM(defekte_kolli_ist) AS anz_defekte_kolli,
   SUM(menge_stichprobe_frischemaengel) AS menge_strichprobe_frischemaengel,
   SUM(menge_stichprobe_sonstiges) AS menge_strichprobe_sonstiges,
   SUM(anz_kolli_ist) AS anz_kolli_ist
  FROM kfl_production_dbp_view.v_charge_ist_qa_check_2
  GROUP BY mandant_id,
   lief_beleg_id,
   art_id,
   wup_id,
   nb_id,
   gp_id,
   charge_id,
   freitext_produzent_ist,
   freitext_marke_ist,
   freitext_primaerverpackung_ist,
   freitext_transport_verpackung_de_ist,
   transport_verpackung_kmo_ist_kz,
   transportverpackung_ist,
   ursprungsland_kbez_ist,
   zus_ursprungslaender_kbez_ist,
   handelsklasse_ist_kz,
   unbehandelt_ist_kz,
   vertragsanbau_ist_fg,
   nationale_produktion_ist_fg,
   freitext_hinweis_fuer_qa_ist,
   kontrollnotwendigkeit_vorerntenummer_ist_fg,
   freitext_qa_kommentar_ist,
   freitext_besonderheiten_ist,
   freitext_spezifikation_ist,
   freitext_lieferanten_kommentar_ist,
   freitext_temperatur_check_ist,
   freitext_fruchtfleischdruck_ist,
   freitext_fruchtgehalt_ist,
   freitext_saftgehalt_ist,
   lagernummer_id,
   zeit_antwort,
   gtin_vorhanden_fg,
   qa_status,
   kaliber_kz_ist,
   kaliber_von_ist,
   kaliber_bis_ist,
   palettenfaktor_ist,
   nettoinhalt_kolli_ist,
   charge_nr_qa,
   charge_vorhanden_ist_fg) AS v05 ON v011.mandant_id = v05.mandant_id AND v011.lief_beleg_id = v05.lief_beleg_id AND
     v011.art_id = v05.art_id AND v011.wup_id = v05.wup_id AND v011.nb_id = v05.nb_id
 LEFT JOIN (SELECT charge_nr_qa,
   mandant_id,
   wup_id,
   nb_id,
   lief_beleg_id,
   datzeit_eingang,
   dat_antwort,
   ARRAY_TO_STRING(ARRAY_AGG(DISTINCT qa_mangel_id ORDER BY qa_mangel_id), ' , ') AS qa_mangel_id,
   ARRAY_TO_STRING(ARRAY_AGG(DISTINCT qa_deklarationsfehler_id ORDER BY qa_deklarationsfehler_id), ' , ') AS
   qa_deklarationsfehler_id,
   STRING_AGG(DISTINCT kommentar_qa_txt, ' |,| ') AS kommentar_qa_txt,
   STRING_AGG(DISTINCT kommentar_ek_txt, ' |,| ') AS kommentar_ek_txt
  FROM (SELECT V010.charge_nr_qa,
     V010.mandant_id,
     V010.wup_id,
     V010.nb_id,
     V010.lief_beleg_id,
     V010.datzeit_eingang,
     V010.dat_antwort,
     COALESCE(V04.qa_mangel_id, '-1') AS qa_mangel_id,
     COALESCE(V04.qa_deklarationsfehler_id, '-1') AS qa_deklarationsfehler_id,
     V04.kommentar_qa_txt,
     V04.kommentar_ek_txt
    FROM kfl_production_dbp_view.v_charge_ist_qa_check_2 AS V010
     LEFT JOIN kfl_production_dbp_view.v_charge_ist_qa_check_det_2 AS V04 ON V010.charge_nr_qa = V04.charge_nr_qa AND V010
       .mandant_id = V04.mandant_id
    GROUP BY V010.charge_nr_qa,
     V010.mandant_id,
     V010.wup_id,
     V010.nb_id,
     V010.lief_beleg_id,
     V010.datzeit_eingang,
     V010.dat_antwort,
     qa_mangel_id,
     qa_deklarationsfehler_id,
     V04.kommentar_qa_txt,
     V04.kommentar_ek_txt) AS a
  GROUP BY charge_nr_qa,
   mandant_id,
   wup_id,
   nb_id,
   lief_beleg_id,
   datzeit_eingang,
   dat_antwort) AS v50 ON v05.mandant_id = v50.mandant_id AND v05.charge_nr_qa = v50.charge_nr_qa AND v05.wup_id = v50.wup_id
      AND v05.nb_id = v50.nb_id AND v05.lief_beleg_id = v50.lief_beleg_id
 LEFT JOIN (SELECT mandant_id,
   lief_beleg_id,
   art_id,
   wup_id,
   nb_id,
   SUM(anz_kolli_ist) AS anzahl_kolli_ist
  FROM kfl_production_dbp_view.v_charge_ist_qa_check_2
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   lief_beleg_id,
   art_id) AS t11 ON v011.mandant_id = t11.mandant_id AND v011.lief_beleg_id = t11.lief_beleg_id AND v011.art_id = t11.art_id
      AND v011.wup_id = t11.wup_id AND v011.nb_id = t11.nb_id
 LEFT JOIN (SELECT mandant_id,
   lief_beleg_id,
   art_id,
   wup_id,
   nb_id,
   COUNT(qa_status) AS qa_status_count
  FROM kfl_production_dbp_view.v_charge_ist_qa_check_2
  WHERE qa_status <> 'R'
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   lief_beleg_id,
   art_id
  HAVING qa_status_count > 1) AS t15 ON v011.mandant_id = t15.mandant_id AND v011.lief_beleg_id = t15.lief_beleg_id AND
     v011.art_id = t15.art_id AND v011.wup_id = t15.wup_id AND v011.nb_id = t15.nb_id
 LEFT JOIN kfl_production_dbp_view.v_charge_soll_2 AS V06 ON v05.mandant_id = V06.mandant_id AND v05.charge_id = V06.charge_id
      AND v05.gp_id = V06.gp_id AND v05.art_id = V06.art_id
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
    CASE
    WHEN mandant_id = 1
    THEN 'EUR'
    ELSE wrg_id
    END AS wrg_id,
   einstandspreis,
   ek_nettonetto,
   ek_mep,
   logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
  WHERE wup_id > -1) AS v03 ON V01.mandant_id = V02.mandant_id AND v011.wup_id = v03.wup_id AND V01.gp_id = v03.gp_id
   AND v011.art_id = v03.art_id AND V01.dat_lief_soll BETWEEN v03.dat_von AND v03.dat_bis
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
    CASE
    WHEN mandant_id = 1
    THEN 'EUR'
    ELSE wrg_id
    END AS wrg_id,
   einstandspreis,
   ek_nettonetto,
   ek_mep,
   logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
  WHERE wup_id = -1) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.gp_id = v04.gp_id AND v011.art_id = v04.art_id
  AND V01.dat_lief_soll BETWEEN v04.dat_von AND v04.dat_bis
 LEFT JOIN (SELECT mandant_id,
   charge_nr_qa,
   wup_id,
   nb_id,
   lief_beleg_id,
   ARRAY_TO_STRING(qa_deklarationsfehler_id, ' , ') AS qa_deklarationsfehler_id,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez, ' , ') AS qa_deklarationsfehler_bez,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_de, ' , ') AS qa_deklarationsfehler_bez_de,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_cz, ' , ') AS qa_deklarationsfehler_bez_cz,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_sk, ' , ') AS qa_deklarationsfehler_bez_sk,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_hr, ' , ') AS qa_deklarationsfehler_bez_hr,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_pl, ' , ') AS qa_deklarationsfehler_bez_pl,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_ro, ' , ') AS qa_deklarationsfehler_bez_ro,
   ARRAY_TO_STRING(qa_deklarationsfehler_bez_bg, ' , ') AS qa_deklarationsfehler_bez_bg
  FROM (SELECT t23.mandant_id0 AS mandant_id,
     t23.charge_nr_qa,
     t23.wup_id,
     t23.nb_id,
     t23.lief_beleg_id,
     ARRAY_AGG(DISTINCT t23.qa_deklarationsfehler_id0 ORDER BY t23.qa_deklarationsfehler_id0) AS
     qa_deklarationsfehler_id,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0, 'N/A') ORDER BY COALESCE(t23.a0, 'N/A')) AS qa_deklarationsfehler_bez,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0, 'N/A') ORDER BY COALESCE(t23.a0, 'N/A')) AS qa_deklarationsfehler_bez_de,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_0, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_0, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_cz,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_1, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_1, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_sk,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_2, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_2, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_hr,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_3, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_3, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_pl,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_4, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_4, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_ro,
     ARRAY_AGG(DISTINCT COALESCE(t23.a0_5, COALESCE(t23.a0, 'N/A')) ORDER BY COALESCE(t23.a0_5, COALESCE(t23.a0, 'N/A')
        )) AS qa_deklarationsfehler_bez_bg
    FROM (SELECT v02.mandant_id AS mandant_id0,
       v02.qa_deklarationsfehler_id AS qa_deklarationsfehler_id0,
       v02.charge_nr_qa,
       v02.wup_id,
       v02.nb_id,
       v02.lief_beleg_id,
       MAX(CASE
         WHEN V011.spr_id = 22
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0,
       MAX(CASE
         WHEN V011.spr_id = 124
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_0,
       MAX(CASE
         WHEN V011.spr_id = 108
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_1,
       MAX(CASE
         WHEN V011.spr_id = 65
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_2,
       MAX(CASE
         WHEN V011.spr_id = 90
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_3,
       MAX(CASE
         WHEN V011.spr_id = 95
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_4,
       MAX(CASE
         WHEN V011.spr_id = 18
         THEN V011.qa_deklarationsfehler_bez
         ELSE NULL
         END) AS a0_5
      FROM kfl_production_dbp_view.v_qa_deklarationsfehler_spr_zu_2 AS V011
       RIGHT JOIN (SELECT V03.mandant_id,
         COALESCE(V040.qa_deklarationsfehler_id, '-1') AS qa_deklarationsfehler_id,
         V040.charge_nr_qa,
         V03.wup_id,
         V03.nb_id,
         V03.lief_beleg_id
        FROM kfl_production_dbp_view.v_charge_ist_qa_check_2 AS V03
         LEFT JOIN kfl_production_dbp_view.v_charge_ist_qa_check_det_2 AS V040 ON V03.charge_nr_qa = V040.charge_nr_qa AND
           V03.mandant_id = V040.mandant_id
        GROUP BY V03.mandant_id,
         qa_deklarationsfehler_id,
         V040.charge_nr_qa,
         V03.wup_id,
         V03.nb_id,
         V03.lief_beleg_id) AS v02 ON V011.mandant_id = v02.mandant_id AND V011.qa_deklarationsfehler_id = v02.qa_deklarationsfehler_id
         
      GROUP BY mandant_id0,
       qa_deklarationsfehler_id0,
       v02.charge_nr_qa,
       v02.wup_id,
       v02.nb_id,
       v02.lief_beleg_id) AS t23
    GROUP BY mandant_id,
     t23.charge_nr_qa,
     t23.wup_id,
     t23.nb_id,
     t23.lief_beleg_id) AS v07) AS v07 ON V01.mandant_id = v07.mandant_id AND v011.wup_id = v07.wup_id AND v011.nb_id =
      v07.nb_id AND V01.lief_beleg_id = v07.lief_beleg_id AND v05.charge_nr_qa = v07.charge_nr_qa AND v50.qa_deklarationsfehler_id
    = v07.qa_deklarationsfehler_id
 LEFT JOIN (SELECT mandant_id,
   charge_nr_qa,
   wup_id,
   nb_id,
   lief_beleg_id,
   ARRAY_TO_STRING(qa_mangel_id, ' , ') AS qa_mangel_id,
   ARRAY_TO_STRING(qa_mangel_bez, ' , ') AS qa_mangel_bez,
   ARRAY_TO_STRING(qa_mangel_bez_de, ' , ') AS qa_mangel_bez_de,
   ARRAY_TO_STRING(qa_mangel_bez_cz, ' , ') AS qa_mangel_bez_cz,
   ARRAY_TO_STRING(qa_mangel_bez_sk, ' , ') AS qa_mangel_bez_sk,
   ARRAY_TO_STRING(qa_mangel_bez_hr, ' , ') AS qa_mangel_bez_hr,
   ARRAY_TO_STRING(qa_mangel_bez_pl, ' , ') AS qa_mangel_bez_pl,
   ARRAY_TO_STRING(qa_mangel_bez_ro, ' , ') AS qa_mangel_bez_ro,
   ARRAY_TO_STRING(qa_mangel_bez_bg, ' , ') AS qa_mangel_bez_bg
  FROM (SELECT t30.mandant_id0 AS mandant_id,
     t30.charge_nr_qa,
     t30.wup_id,
     t30.nb_id,
     t30.lief_beleg_id,
     ARRAY_AGG(DISTINCT t30.qa_mangel_id0 ORDER BY t30.qa_mangel_id0) AS qa_mangel_id,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0, 'N/A') ORDER BY COALESCE(t30.a0, 'N/A')) AS qa_mangel_bez,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0, 'N/A') ORDER BY COALESCE(t30.a0, 'N/A')) AS qa_mangel_bez_de,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_0, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_0, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_cz,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_1, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_1, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_sk,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_2, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_2, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_hr,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_3, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_3, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_pl,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_4, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_4, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_ro,
     ARRAY_AGG(DISTINCT COALESCE(t30.a0_5, COALESCE(t30.a0, 'N/A')) ORDER BY COALESCE(t30.a0_5, COALESCE(t30.a0, 'N/A')
        )) AS qa_mangel_bez_bg
    FROM (SELECT v02.mandant_id AS mandant_id0,
       v02.qa_mangel_id AS qa_mangel_id0,
       v02.charge_nr_qa,
       v02.wup_id,
       v02.nb_id,
       v02.lief_beleg_id,
       MAX(CASE
         WHEN V012.spr_id = 22
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0,
       MAX(CASE
         WHEN V012.spr_id = 124
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_0,
       MAX(CASE
         WHEN V012.spr_id = 108
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_1,
       MAX(CASE
         WHEN V012.spr_id = 65
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_2,
       MAX(CASE
         WHEN V012.spr_id = 90
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_3,
       MAX(CASE
         WHEN V012.spr_id = 95
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_4,
       MAX(CASE
         WHEN V012.spr_id = 18
         THEN V012.qa_mangel_bez
         ELSE NULL
         END) AS a0_5
      FROM kfl_production_dbp_view.v_qa_mangel_spr_zu_2 AS V012
       RIGHT JOIN (SELECT V030.mandant_id,
         COALESCE(V041.qa_mangel_id, '-1') AS qa_mangel_id,
         V041.charge_nr_qa,
         V030.wup_id,
         V030.nb_id,
         V030.lief_beleg_id
        FROM kfl_production_dbp_view.v_charge_ist_qa_check_2 AS V030
         LEFT JOIN kfl_production_dbp_view.v_charge_ist_qa_check_det_2 AS V041 ON V030.charge_nr_qa = V041.charge_nr_qa
          AND V030.mandant_id = V041.mandant_id
        GROUP BY V030.mandant_id,
         qa_mangel_id,
         V041.charge_nr_qa,
         V030.wup_id,
         V030.nb_id,
         V030.lief_beleg_id) AS v02 ON V012.mandant_id = v02.mandant_id AND V012.qa_mangel_id = v02.qa_mangel_id
      GROUP BY mandant_id0,
       qa_mangel_id0,
       v02.charge_nr_qa,
       v02.wup_id,
       v02.nb_id,
       v02.lief_beleg_id) AS t30
    GROUP BY mandant_id,
     t30.charge_nr_qa,
     t30.wup_id,
     t30.nb_id,
     t30.lief_beleg_id) AS v08) AS v08 ON V01.mandant_id = v08.mandant_id AND v011.wup_id = v08.wup_id AND v011.nb_id =
      v08.nb_id AND V01.lief_beleg_id = v08.lief_beleg_id AND v05.charge_nr_qa = v08.charge_nr_qa AND v50.qa_mangel_id =
   v08.qa_mangel_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON COALESCE(v03.wrg_id, v04.wrg_id) = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V400 ON V01.dat_lief_soll BETWEEN V400.dat_von AND V400.dat_bis AND
   COALESCE(v03.wrg_id, v04.wrg_id) = V400.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS F1 ON V01.mandant_id = F1.mandant_id AND v011.art_id = F1.art_id
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS F2 ON F1.mandant_id = F2.mandant_id AND F1.wg_id = F2.wg_id AND F1.arthiertyp_id
    = F2.arthiertyp_id
 INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS F3 ON F2.mandant_id = F3.mandant_id AND F2.owg_id = F3.owg_id AND F2.arthiertyp_id
    = F3.arthiertyp_id
WHERE F3.dat_bis = DATE '9999-12-31'
 AND F2.dat_bis = DATE '9999-12-31'
 AND V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND F3.hwg_id = 64
 AND F3.arthiertyp_id = 2
 AND F1.dat_bis = DATE '9999-12-31';