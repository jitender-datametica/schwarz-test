CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.TBL_MV_F_IST_KOSTEN_IT_PROJEKTE AS
   -- 02.04.2013 AL Init
   -- 17.04.2013 AL Anpassen verwendern aktueller Kurs
   -- 22.04.2013 AL Einschränkung auf PSP Element aufgenommen
   -- 28.04.2013 AL it_plan_ebene_id
   -- 03.06.2013 AL Abbildung Analyseprojekte- Kosten Analyseprojekte werden in Hauptprojekt uaf die Berichtsposition 11 gemappt
   -- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage vorhanden
   -- 10.07.2013 AL COALESCE auf Gegenkoto hinzugefügt
   -- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen
   -- 22.08.2013 twie: kostenstelle_id ausgeben
   -- 17.09.2013 AL Umsetzung Berichtsposition für RWI, Korrektur Geschäftsbereich Dummy
   -- 11.10.2013 AL  Korrektur Analyse Projekte psp Ermittlung
   -- 26.11.2013 AL berichts_position_invest_id    hinzugefügt, um AiB abzubilden
   -- 06.12.2013 twie: Gegenkonto '' falls es nicht als Kostenart existiert (analog it_kosten_det)
   -- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
   -- 12.06.2014 twie: kostenart_id 48011 ausschließen
   -- 15.07.2014 twie: ref_beleg_id ausgeben
   -- 27.08.2014 twie: bestell_text, ref_buchungskreis_id, belegart_id neu
   -- 29.08.2014 twie: Dummy für buchungskreis_id
   -- 02.12.2014 twie: krk_id DE02 in DE ausschließen
   -- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)
   -- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id, auskommentierte Bereiche gelöscht
   -- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
   -- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
   -- 01.07.2025 pkra: new data type for BELEG_ID column

   SELECT

   v01.mandant_id,
   --Falls Sparte Zentrale Int (KI) oder KIS, dann bei Länder unter KI (Kaufland International ohne Land Zuordnung)
   CASE
   WHEN v01.sparte_id  IN (6,8)  THEN 1
   WHEN v01.mandant_id =1 THEN 2
   WHEN v01.mandant_id =2 THEN 3
   WHEN v01.mandant_id =3 THEN 6
   WHEN v01.mandant_id =5 THEN 4
   WHEN v01.mandant_id =6 THEN 5
   WHEN v01.mandant_id =7 THEN 7
   WHEN v01.mandant_id=8 THEN 8
   END it_plan_ebene_id,
   v01.psp_id AS it_psp_id,
   psp_id_char AS it_psp_id_char,
   v01.gj,
   v01.buchungsperiode_id,
   COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.beleg_id,
   v01.beleg_pos_id,
   COALESCE(v01.in_art_id, -1) in_art_id,
   v01.krk_id,
   COALESCE(v01.geschaeftsbereich_id, '-1') AS geschaeftsbereich_id,
   COALESCE(v01.in_lief_id,-1) AS in_lief_id,
   COALESCE(v01.ref_beleg_id, 0) AS ref_beleg_id,
   LTRIM(COLLATE(v01.kostenart_id,''),'0') AS kostenart_id,
   COALESCE(v01.anlage_id, '') AS anlage_id,
   COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
   CAST(CASE WHEN v01.anlage_id IS NULL THEN -1
   ELSE v01.buchungskreis_id
   END AS SMALLINT) AS anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   v01.berichts_position_invest_id,
   --Sicht Rechnungswesen international
   CASE
   --Aktivierte Fremdleistung ext. Personalkosten
   WHEN LTRIM(COLLATE(v01.kostenart_id,''),'0') = '506005' THEN 4
   --Aktivierte Fremdleistung EDV-Beratung
   WHEN LTRIM(COLLATE(v01.kostenart_id,''),'0') = '580405' THEN 5
   --Aktivierte Eigenleistungen Projekte
   WHEN LTRIM(COLLATE(v01.kostenart_id,''),'0') = '880100' THEN 7
   ELSE berichts_position_it_id
   END berichts_position_it_rwi_id,
   -- KI zu der Zentrale hinzufügen
   CASE WHEN  v01.sparte_id = 8 THEN 5
   ELSE sparte_id
   END sparte_id,
   COALESCE(kostenstelle_id, '') AS kostenstelle_id,
   COALESCE(LTRIM(COLLATE(gegenkonto_id_,''), '0'), '') AS gegenkonto_id,
   COALESCE (beleg_bez, '') beleg_bez,
   COALESCE(best_beleg_id, 0)     AS best_beleg_id,
   COALESCE(best_beleg_pos_id, 0)  AS best_beleg_pos_id,
   v01.bestell_text,
   v01.ref_buchungskreis_id,
   v01.belegart_id,
   v01.hb2_fg,
   v01.bedarf_nr,
   v01.betrag,
   v01.wrg_id
   
   FROM  dbp_view.v_ist_kosten_det v01

   JOIN  dbp_view.v_in_psp_element v02
   ON v01.psp_id = v02.psp_id
   AND v01.mandant_id = v02.mandant_id

   --zur Ermittlung Projekttyp
   JOIN dbp_view.v_in_projekt v03
   ON v02.in_projekt_id = v03.in_projekt_id
   AND v02.mandant_id = v03.mandant_id
   
   --Falls Gegenkonto als Kostenart nicht existiert ==> als '' anzeigen
   LEFT JOIN (SELECT kostenart_id AS gegenkonto_id_
   FROM  dbp_view.v_kostenart v04
   WHERE        v04.mandant_id = 1 AND
   v04.krk_id='XX01'
   ) v04
   ON  v01.gegenkonto_id = v04.gegenkonto_id_

   JOIN  dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   
   
   WHERE
   --KRK DE02 in DE ausschließen
   (v01.krk_id <> 'DE02' OR v01.mandant_id <> 1) AND

   -- IT Projekte
   v03.ims_projekt_typ_id = 'P'  AND

   --Neue Projekte nur statistisch
   v02.statistisch_fg  = 1 AND 
   
   ---- HB3 und Steuerliche Sichten werden ausgeschlossen -> oblsolet durch neues Hauptbuch
   --NOT v01.kostenart_id  LIKE ANY ('I%', 'S%')  AND
   --Auszuschliessenden Kostenarten
   TRIM(COLLATE(v01.kostenart_id,''),'0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '940003')  AND

   -- nur HB2 Buchungen anzeigen für Altdaten (ab 09.2015 ist das flag immer 1)
   hb2_fg = 1;