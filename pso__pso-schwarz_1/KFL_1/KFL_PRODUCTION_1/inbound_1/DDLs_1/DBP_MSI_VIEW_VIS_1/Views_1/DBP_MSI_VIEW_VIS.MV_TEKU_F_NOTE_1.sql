CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_F_NOTE_1
AS
   SELECT
   tb.teku_bericht_id, tb.dat_besuchs_beginn, tb.zeit_besuchs_beginn, tb.dat_besuchs_ende, tb.zeit_besuchs_ende, tb.dat_erfasst AS dat_aenderung, tb.mandant_id, tb.wup_id, tb.testkunde_id, tb.teku_checkliste_id, tfc.teku_frage_id, tc.frische_fg, ta.teku_antwort_id                         AS teku_antwort_id, ta.teku_antwort_note::DEC(3,2)          AS detail_note, ta.teku_antwort_bez, ltk.teku_kategorie_nr, tfk.teku_frage_gewicht, tfk.teku_frage_gewicht * detail_note       AS detail_note_gew

   FROM dbp_view.v_teku_bericht_per_1 tb
   INNER JOIN dbp_view.v_l_teku_checkliste_1 tc
   ON tb.teku_checkliste_id = tc.teku_checkliste_id
   INNER JOIN dbp_view.v_teku_bericht_det_per_1  ta
   ON  tb.teku_bericht_id = ta.teku_bericht_id
   -- analog READ
   AND ((CASE WHEN tb.dat_bis = '9999-12-31' THEN tb.dat_bis ELSE tb.dat_bis + 1 END) >= (ta.dat_von) OR (CASE WHEN ta.dat_bis = '9999-12-31' THEN ta.dat_bis ELSE ta.dat_bis + 1 END) >= (tb.dat_von))
   INNER JOIN dbp_view.v_teku_frage_checkliste_zu_1 tfc
   ON ta.teku_fragestellung_id = tfc.teku_fragestellung_id
   INNER JOIN dbp_view.v_teku_frage_kategorie_zu_per_1  tfk
   ON tfc.teku_frage_id  = tfk.teku_frage_id
   -- RITM0093100
   --AND tfk.dat_bis = '9999-12-31'
   AND tb.dat_besuchs_beginn BETWEEN tfk.dat_von AND tfk.dat_bis
   INNER JOIN dbp_view.v_l_teku_kategorie_1 ltk
   ON tfk.teku_kategorie_id = ltk.teku_kategorie_id

   -- zeitliche Abgrenzung auf die aktuelle gültigen Teku-Berichte, analog mv_teku_f_bericht_1
   WHERE tb.dat_bis  = '9999-12-31'
   AND (ta.teku_antwort_note > 0
   -- Für kategorie_id = 309 gibt es keine BWZ (note = 0), die Antwort-Texte werden aber dennoch benötigt.
   OR tfk.teku_kategorie_id = 309)
   -- gelöschte TeKu-Berichte werden in den DWH Berichten nicht ausgewertet
   AND tb.loeschung_fg = 0
   -- Es gibt TeKu-Berichte, die nicht in die DWH Auswertung einfließen dürfen. In READ gibt es flexible Berichte, die alle Daten anzeigen dürfen.
   -- Daher ist in DWH-READ ein entsprechender Berichtsfilter verbaut und nicht in der View-Where Bedingung enthalten
   AND tb.nicht_auswerten_fg = 0;