-- 27.08.2014 twie: belastungs_kz, bestell_text, ref_buchungskreis_id, belegart_id neu

-- 10.06.2013 AL psp_id <> -1 anstatt psp_id > -1 wegen generierten I PSP

-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen

-- 15.07.2013 AL HB1/HB2 Sicht Auswahl und Ausschluss definierten Kostenarten

-- 24.05.2013 twie: Ermittlung Planungselement

-- 25.03.2014 SH nochmal feinere Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten

-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt aufgenommen und direkt referenziert

-- 22.08.2013 twie: kostenstelle_id ausgeben

-- 25.07.2013 AL HB2 Sicht, falls kostenart mit H beginnt, unabhängig ob Anlage befühlt ist.

-- 29.08.2014 twie: Dummy für buchungskreis_id

-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt

-- 31.05.2013 twie: in_art_id hinzugefügt

-- 22.08.2013 AL Umrechnung zum aktuellen Kurs, Gegenkonto '' falls nicht als Kostenart existiert

-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
 -- 14.06.2013 twie: beleg_bez hinzugefügt

-- 01.04.2014 twie: Workaround: Filterung bei CS-Aufträgen (psp_id < -1) auf soll_haben_kz = S

-- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)

-- 12.06.2013 twie: Istdaten auf Projekten in Sparte 4 (TIP) auf Zentrale (PR_Z) zuordnen

-- 30.07.2013 AL leading 0 auf gegenkonto entfernt

-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage vorhanden

-- 29.05.2013 twie: Dummywert bei geschaeftsbereich_id

-- 08.07.2013 twie: weitere Felder wie best_beleg_id sowie Betrag in Landeswährung hinzugefügt

-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen

-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
 -- 21.05.2013 AL init

-- 24.03.2014 SH Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten
 -- 13.06.2013 AL soll_haben_kz

-- 08.03.2018 srom: NSR0112499 Zusammenfassen Werbung, (KIS, KI) zu Zentrale, KIS herausgenommen bei sparte_id

-- 02.12.2014 twie: krk_id DE02 in DE ausschließen

-- 19.09.2013 AL Kostenart 880100 ausgeschlossen, nur INV nicht bei IT Projekte

-- 12.06.2014 twie: kostenart_id 48011 ausschließen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_ist_kosten_det (mandant_id, psp_id, projekt_typ_id, gj,
buchungsperiode_id, buchungskreis_id, dat_buch, dat_beleg, soll_haben_kz, belastungs_kz, beleg_id, beleg_pos_id,
beleg_bez, krk_id, geschaeftsbereich_id, in_lief_id, best_beleg_id, best_beleg_pos_id, ref_beleg_id, ref_fi_beleg_id,
betrag_landeswrg, auftrag_id, kostenart_id, anlage_id, anlage_sub_id, anlage_buchungskreis_id, berichts_position_it_id,
berichts_position_invest_id, sparte_id, in_art_id, kostenstelle_id, bestell_text, ref_buchungskreis_id, belegart_id,
gegenkonto_id, hb2_fg, bedarf_nr, betrag) AS -- Ermittlung der eingestellter Währung
 -- Ermittlung Kurstyp
 SELECT V01
 .mandant_id,
 V01.psp_id,
 V01.projekt_typ_id,
 V01.gj,
 V01.buchungsperiode_id,
 V01.buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.soll_haben_kz,
 V01.belastungs_kz,
 V01.beleg_id,
 V01.beleg_pos_id,
 V01.beleg_bez,
 V01.krk_id,
 V01.geschaeftsbereich_id,
 V01.in_lief_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.ref_beleg_id,
 V01.ref_fi_beleg_id,
 V01.betrag_landeswrg,
 V01.auftrag_id,
 V01.kostenart_id,
 V01.anlage_id,
 V01.anlage_sub_id,
 V01.anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
 V01.sparte_id,
 V01.in_art_id,
 V01.kostenstelle_id,
 V01.bestell_text,
 V01.ref_buchungskreis_id,
 V01.belegart_id,
 V01.gegenkonto_id,
 V01.hb2_fg,
 V01.bedarf_nr,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS betrag
FROM kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_ist_kosten_det AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis
   -- WHERE Bedingung ist bereits in der materialisierten View enthalten
;