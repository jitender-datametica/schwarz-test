CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_OBLIGO_2
-- 11.06.2013 twie: Viewerstellung analog zu mv_f_ist_kosten_det_2
-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_2 vorhanden
-- 08.07.2013 AL : Beim Abbau von Obligo gibt es keine Gegenbuchung, sondern der Belegwert wird auf 0 gesetzt und
--                            darf in Berichten nicht angezeigt werden. ==> Einschränkung betrag <> 0.0
-- 15.07.2013 AL: Ausschluss von nicht relevanten Konten, keine Unterscheidung HB1/HB2 erforderlich
--                           Umstellung auf obligo_per_2

-- 18.07.2013 AL auftrag_id aufgenommen
-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen
-- 22.08.2013 twie: kostenstelle_id ausgeben
-- 12.09.2013 AL Umrechnung zum aktuellen Kurs_2
-- 24.09.2013 AL Ref Beleg ID in die View aufgenommen
-- 12.06.2014 twie: kostenart_id 48011 ausschließen
-- 27.08.2014 twie: neu bestell_text, betrag_plan
-- 29.08.2014 twie: Dummy_2 für buchungskreis_id
-- 02.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_2 aufgenommen und direkt referenziert
-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt
(
  mandant_id
, psp_id
, projekt_typ_id
, gj
, buchungsperiode_id
, buchungskreis_id
, dat_buch
, dat_beleg
, ref_beleg_id
, ref_beleg_pos_id
, krk_id
, in_lief_id
, betrag
, auftrag_id
, kostenart_id
, anlage_id
, anlage_sub_id
, anlage_buchungskreis_id
, berichts_position_it_id
, berichts_position_invest_id
, sparte_id
, in_art_id
, obligo_version_id
, obligo_wrg_typ_id
, dat_von
, dat_bis
, kostenstelle_id
, bestell_text
, betrag_plan
, bedarf_nr
)
AS
    SELECT v01.mandant_id,
           v01.psp_id,
           projekt_typ_id,
           v01.gj,
           v01.buchungsperiode_id,
           buchungskreis_id,
           v01.dat_buch,
           v01.dat_beleg,
           v01.ref_beleg_id,
           v01.ref_beleg_pos_id,
           v01.krk_id,
           in_lief_id,
           CASE WHEN v400.wrg_typ_id = 1 THEN v01.betrag ELSE v01.betrag * umrechnungskurs END AS betrag,
           v01.auftrag_id,
           kostenart_id,
           anlage_id,
           anlage_sub_id,
           anlage_buchungskreis_id,
           v01.berichts_position_it_id,
           v01.berichts_position_invest_id,
           sparte_id,
           in_art_id,
           v01.obligo_version_id,
           v01.obligo_wrg_typ_id,
           v01.dat_von,
           v01.dat_bis,
           kostenstelle_id,
           v01.bestell_text,
           v01.betrag_plan,
           v01.bedarf_nr
           
  FROM  DBP_MSI_VIEW_IMS.TBL_MV_F_OBLIGO_2 v01

  -- Ermittlung der eingestellter Währung
  CROSS JOIN  dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

  -- Ermittlung Kurstyp
  CROSS JOIN  dbp_msi.akt_msi_user_kurstyp_zu_2 v300

  JOIN  dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
  JOIN   dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id   
   AND v01.wrg_id = v500.von_wrg_id   
   AND v500.nach_wrg_id ='EUR'   
   AND CURRENT_DATE BETWEEN v500.dat_von 
   AND v500.dat_bis
;