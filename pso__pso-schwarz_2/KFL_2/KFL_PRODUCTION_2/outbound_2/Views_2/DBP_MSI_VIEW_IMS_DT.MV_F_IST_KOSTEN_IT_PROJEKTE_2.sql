-- 12.06.2014 twie: kostenart_id 48011 ausschließen
 -- 15.07.2014 twie: ref_beleg_id ausgeben

-- 11.10.2013 AL  Korrektur Analyse Projekte psp Ermittlung

-- 26.11.2013 AL berichts_position_invest_id    hinzugefügt, um AiB abzubilden

-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
 -- 28.04.2013 AL it_plan_ebene_id

-- 22.04.2013 AL Einschränkung auf PSP Element aufgenommen

-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_2 vorhanden

-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern

-- 03.06.2013 AL Abbildung Analyseprojekte- Kosten Analyseprojekte werden in Hauptprojekt uaf die Berichtsposition 11 gemappt

-- 22.08.2013 twie: kostenstelle_id ausgeben

-- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)

-- 27.08.2014 twie: bestell_text, ref_buchungskreis_id, belegart_id neu

-- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id, auskommentierte Bereiche gelöscht

-- 17.09.2013 AL Umsetzung Berichtsposition für RWI, Korrektur Geschäftsbereich Dummy_2

-- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet

-- 17.04.2013 AL Anpassen verwendern aktueller Kurs_2
 -- 29.08.2014 twie: Dummy_2 für buchungskreis_id

-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen

-- 02.04.2013 AL Init
 -- 02.12.2014 twie: krk_id DE02 in DE ausschließen

-- 06.12.2013 twie: Gegenkonto '' falls es nicht als Kostenart_2 existiert (analog it_kosten_det)

-- 10.07.2013 AL COALESCE auf Gegenkoto hinzugefügt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_ist_kosten_it_projekte_2 (mandant_id, it_plan_ebene_id,
it_psp_id, it_psp_id_char, gj, buchungsperiode_id, buchungskreis_id, dat_buch, dat_beleg, beleg_id, beleg_pos_id,
in_art_id, krk_id, geschaeftsbereich_id, in_lief_id, ref_beleg_id, it_projekt_kosten, kostenart_id, anlage_id,
anlage_sub_id, anlage_buchungskreis_id, berichts_position_it_id, berichts_position_invest_id,
berichts_position_it_rwi_id, sparte_id, kostenstelle_id, gegenkonto_id, beleg_bez, best_beleg_id, best_beleg_pos_id,
bestell_text, ref_buchungskreis_id, belegart_id, hb2_fg, bedarf_nr) AS -- Ermittlung der eingestellter Währung

-- Ermittlung Kurstyp
 SELECT V01.mandant_id,
 V01.it_plan_ebene_id,
 V01.it_psp_id,
 V01.it_psp_id_char,
 V01.gj,
 V01.buchungsperiode_id,
 V01.buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.beleg_id,
 V01.beleg_pos_id,
 V01.in_art_id,
 V01.krk_id,
 V01.geschaeftsbereich_id,
 V01.in_lief_id,
 V01.ref_beleg_id,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS it_projekt_kosten,
 V01.kostenart_id,
 V01.anlage_id,
 V01.anlage_sub_id,
 V01.anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
 -- Sicht Rechnungswesen international
 V01.berichts_position_it_rwi_id,
 V01.sparte_id,
 V01.kostenstelle_id,
 V01.gegenkonto_id,
 V01.beleg_bez,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.bestell_text,
 V01.ref_buchungskreis_id,
 V01.belegart_id,
 V01.hb2_fg,
 V01.bedarf_nr
FROM kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_ist_kosten_it_projekte_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis;