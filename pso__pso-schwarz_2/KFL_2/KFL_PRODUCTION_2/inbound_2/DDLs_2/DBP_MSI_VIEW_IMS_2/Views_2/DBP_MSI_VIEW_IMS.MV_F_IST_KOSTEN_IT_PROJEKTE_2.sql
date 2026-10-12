CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_IST_KOSTEN_IT_PROJEKTE_2
   -- 02.04.2013 AL Init
   -- 17.04.2013 AL Anpassen verwendern aktueller Kurs_2
   -- 22.04.2013 AL Einschränkung auf PSP Element aufgenommen
   -- 28.04.2013 AL it_plan_ebene_id
   -- 03.06.2013 AL Abbildung Analyseprojekte- Kosten Analyseprojekte werden in Hauptprojekt uaf die Berichtsposition 11 gemappt
   -- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_2 vorhanden
   -- 10.07.2013 AL COALESCE auf Gegenkoto hinzugefügt
   -- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen
   -- 22.08.2013 twie: kostenstelle_id ausgeben
   -- 17.09.2013 AL Umsetzung Berichtsposition für RWI, Korrektur Geschäftsbereich Dummy_2
   -- 11.10.2013 AL  Korrektur Analyse Projekte psp Ermittlung
   -- 26.11.2013 AL berichts_position_invest_id    hinzugefügt, um AiB abzubilden
   -- 06.12.2013 twie: Gegenkonto '' falls es nicht als Kostenart_2 existiert (analog it_kosten_det)
   -- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
   -- 12.06.2014 twie: kostenart_id 48011 ausschließen
   -- 15.07.2014 twie: ref_beleg_id ausgeben
   -- 27.08.2014 twie: bestell_text, ref_buchungskreis_id, belegart_id neu
   -- 29.08.2014 twie: Dummy_2 für buchungskreis_id
   -- 02.12.2014 twie: krk_id DE02 in DE ausschließen
   -- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)
   -- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id, auskommentierte Bereiche gelöscht
   -- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
   -- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
   -- 01.07.2025 pkra: new data type for BELEG_ID column

AS 
   SELECT

   v01.mandant_id,
   it_plan_ebene_id,
   it_psp_id,
   it_psp_id_char,
   v01.gj,
   v01.buchungsperiode_id,
   buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.beleg_id,
   v01.beleg_pos_id,
   in_art_id,
   v01.krk_id,
   geschaeftsbereich_id,
   in_lief_id,
   ref_beleg_id,
   CASE WHEN v400.wrg_typ_id = 1
    THEN v01.betrag
    ELSE v01.betrag * umrechnungskurs
    END AS it_projekt_kosten,
   kostenart_id,
   anlage_id,
   anlage_sub_id,
   anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   v01.berichts_position_invest_id,
   --Sicht Rechnungswesen international
   berichts_position_it_rwi_id,
   sparte_id,
   kostenstelle_id,
   gegenkonto_id,
   beleg_bez,
   best_beleg_id,
   best_beleg_pos_id,
   v01.bestell_text,
   v01.ref_buchungskreis_id,
   v01.belegart_id,
   v01.hb2_fg,
   v01.bedarf_nr

   FROM dbp_msi_view_ims.TBL_MV_F_IST_KOSTEN_IT_PROJEKTE_2 v01

   -- Ermittlung der eingestellter Währung
   CROSS JOIN  dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

   -- Ermittlung Kurstyp
   CROSS JOIN  dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN  dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis
;
