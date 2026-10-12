CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_lief_fehlmengen_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
art_id OPTIONS(description='Artikel_1 aus BESCH_LIEF_DET_1 oder angereichert aus BESCH_BEST_DET_1(EKKO_1)'), wup_id
OPTIONS(description='Verteilzentrum aus BESCH_LIEF_1 bzw. BESCH_BEST_1'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), empfaenger_wup_id
OPTIONS(description='Empfangende Filiale aus BESCH_LIEF_1 bzw. BESCH_BEST_1'), empfaenger_nb_id
OPTIONS(description='Nebenbetriebs-ID des empfangenden Marktes. In der Tabelle nur deswegen enthalten, weil FrontEnd ein bestehendes Attribut aus mandant_1, wup_1, nb_1 verwendet'),
mandant_id_empfaenger
OPTIONS(description='Der Empfaenger kann zu einem anderen Mandanten als der liefernde WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
lagerort_id OPTIONS(description='Lagerort_id'), dat_lief_soll OPTIONS(description='Soll Lieferdatum'), bestellart_id
OPTIONS(description='Angereichert aus BESCH_BEST_1(EKKO_1)'), diff_id
OPTIONS(description='Wenn Eintrag in BESCH_LIEF_DET_1 vorhanden dann diff_id aus BESCH_LIEF_DET_1 ansonsten leer'),
kuerzung_fg OPTIONS(description='Wenn entsprechenden Eintrag in besch_lief_kuerzung_1 vorhanden dann 1 ansonsten 0'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), menge_lief_soll_kolli
OPTIONS(description='bestellte Menge in Kolli umgerechnet'), menge_lief_ist_kolli
OPTIONS(description='tatsächlich gelieferte Menge in Kolli'), ek_netto_bnk_soll
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.'), ek_netto_bnk_ist
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gelieferte Menge.'), vk_netto_ist
OPTIONS(description='Verkaufspreis netto  bezogen auf die gelieferte Menge'), vk_netto_soll
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge'), umrechnungskurs
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_1 angereichert'),
umrechnungskurs_hist OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_1 '), kuerz_menge_lief_soll_kolli
OPTIONS(description='Gekürzte Soll-Liefermenge in Kolli'), kuerz_menge_lief_ist_kolli
OPTIONS(description='Gekürzte Ist-Liefermenge in Kolli'), kuerz_ek_netto_bnk_soll
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'), kuerz_ek_netto_bnk_ist
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Ist-Menge'), kuerz_vk_netto_soll
OPTIONS(description='Verkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'), kuerz_vk_netto_ist
OPTIONS(description='Verkaufspreis  bezogen auf die gekürzte Ist-Menge'), best_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
best_beleg_pos_id
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp'))
OPTIONS(DESCRIPTION = `AIS KMO - AGGREGAT FÜR NICHT GELIEFERTE WARE IN KMO. WIRD AUS BESCH_LIEF_DET_1 UND BESCH_LIEF_KUERZUNG_1 VERSORGT UND MIT PREISEN ANGEREICHERT `)
AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 empfaenger_wup_id,
 empfaenger_nb_id,
 mandant_id_empfaenger,
 lagerort_id,
 dat_lief_soll,
 bestellart_id,
 diff_id,
 kuerzung_fg,
 wrg_id,
 menge_lief_soll_kolli,
 menge_lief_ist_kolli,
 ek_netto_bnk_soll,
 ek_netto_bnk_ist,
 vk_netto_ist,
 vk_netto_soll,
 umrechnungskurs,
 umrechnungskurs_hist,
 kuerz_menge_lief_soll_kolli,
 kuerz_menge_lief_ist_kolli,
 kuerz_ek_netto_bnk_soll,
 kuerz_ek_netto_bnk_ist,
 kuerz_vk_netto_soll,
 kuerz_vk_netto_ist,
 best_beleg_id,
 best_beleg_pos_id
FROM kfl_production_dbp_data.besch_lief_fehlmengen_1;