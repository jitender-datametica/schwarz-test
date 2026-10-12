-- 15.07.2013 AL: Ausschluss von nicht relevanten Konten, keine Unterscheidung HB1/HB2 erforderlich

-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern

-- darf in Berichten nicht angezeigt werden. ==> Einschränkung betrag <> 0.0

-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen

-- 08.07.2013 AL : Beim Abbau von Obligo gibt es keine Gegenbuchung, sondern der Belegwert wird auf 0 gesetzt und

-- 27.08.2014 twie: neu bestell_text, betrag_plan

-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt

-- 11.06.2013 twie: Viewerstellung analog zu mv_f_ist_kosten_det_2
 -- 24.09.2013 AL Ref Beleg ID in die View aufgenommen

-- 02.12.2014 twie: krk_id DE02 in DE ausschließen

-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_2 vorhanden

-- 22.08.2013 twie: kostenstelle_id ausgeben
 -- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr

-- 29.08.2014 twie: Dummy_2 für buchungskreis_id
 -- 12.09.2013 AL Umrechnung zum aktuellen Kurs_2

-- Umstellung auf obligo_per_2

-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_2 aufgenommen und direkt referenziert

-- 18.07.2013 AL auftrag_id aufgenommen
 -- 12.06.2014 twie: kostenart_id 48011 ausschließen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_obligo_2 (mandant_id, psp_id, projekt_typ_id, gj,
buchungsperiode_id, buchungskreis_id, dat_buch, dat_beleg, ref_beleg_id, ref_beleg_pos_id, krk_id, in_lief_id, betrag,
auftrag_id, kostenart_id, anlage_id, anlage_sub_id, anlage_buchungskreis_id, berichts_position_it_id,
berichts_position_invest_id, sparte_id, in_art_id, obligo_version_id, obligo_wrg_typ_id, dat_von, dat_bis,
kostenstelle_id, bestell_text, betrag_plan, bedarf_nr) AS -- Ermittlung der eingestellter Währung

-- Ermittlung Kurstyp
 SELECT V01.mandant_id,
 V01.psp_id,
 V01.projekt_typ_id,
 V01.gj,
 V01.buchungsperiode_id,
 V01.buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.ref_beleg_id,
 V01.ref_beleg_pos_id,
 V01.krk_id,
 V01.in_lief_id,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS betrag,
 V01.auftrag_id,
 V01.kostenart_id,
 V01.anlage_id,
 V01.anlage_sub_id,
 V01.anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
 V01.sparte_id,
 V01.in_art_id,
 V01.obligo_version_id,
 V01.obligo_wrg_typ_id,
 V01.dat_von,
 V01.dat_bis,
 V01.kostenstelle_id,
 V01.bestell_text,
 V01.betrag_plan,
 V01.bedarf_nr
FROM kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_obligo_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis;