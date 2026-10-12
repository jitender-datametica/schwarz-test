CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vz_best_split (mandant_id OPTIONS(description='Mandant           '),
gp_dispo_id OPTIONS(description='Supplier ID   (surrogate key)    '), best_beleg_dispo_id
OPTIONS(description='Bestell-ID '), art_dispo_id
OPTIONS(description='Artikel ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
bestellart_id OPTIONS(description='Bestellart   '), einkaeufer_grp_id OPTIONS(description='Einkäufergruppe'), wup_id
OPTIONS(description='Betrieb'), nb_id OPTIONS(description='Nebenbetrieb'), gp_id
OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'), disponent_id OPTIONS(description='Disponent'),
gp_teilsortiment_id OPTIONS(description='Lieferantenteilsortiment       '), fremd_lagerort_id
OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung'), art_id OPTIONS(description='Artikelnummer       '),
menge_gesamt OPTIONS(description='Menge Gesamt  '), menge_iwt_gesamt OPTIONS(description='IWT Menge Gesamt  '),
menge_normal OPTIONS(description='Menge Normal     '), menge_iwt OPTIONS(description='Menge IWT'), menge_werbung_gesamt
OPTIONS(description='Werbung Menge Gesamt '), menge_werbung OPTIONS(description='Menge Werbung  '), menge_einh_id
OPTIONS(description='Bestellmengenheit'), dat_lief_wunsch OPTIONS(description='Lieferdatum der Position   '),
kontrakt_beleg_id OPTIONS(description='Kontrakt'), kontrakt_beleg_pos_id OPTIONS(description='Kontrakt Pos '),
best_beleg_id OPTIONS(description='Belegnummer des Einkaufsbelegs'), best_beleg_pos_id
OPTIONS(description='EinkBeleg Pos.   '), vz_dispo_status_id OPTIONS(description='VZ Dispo Status   '), palettenfaktor
OPTIONS(description='Palettenfaktor   '), gewicht_brutto_bme OPTIONS(description='Bruttogewicht BME '),
dat_verfuegbarkeit OPTIONS(description='Verfügb.Datum'), faktor_bestme_bme
OPTIONS(description='Umrechenfaktor Bestellmengeheit in Basismengeneinheit    '), gewicht_pal
OPTIONS(description='Gewicht volle PAL       '), gewicht_gesamt OPTIONS(description='Gesamtgewicht Position'),
anz_plaetze_max OPTIONS(description='Anzahl der maximalen Plätze   '), gewicht_ladung_max
OPTIONS(description='Maximal zulässiges Ladungsgewicht in KG'), planlieferzeit
OPTIONS(description='Planlieferzeit in Tagen '), autodispo_fg OPTIONS(description='Feld zum Ankreuzen    '), wg_id
OPTIONS(description='Warengruppe     '), menge_werbung_gesamt_pal OPTIONS(description='Gesamtmenge Werbung PAL '),
menge_best_pal OPTIONS(description='Bestellmenge PAL  '), menge_best_werbung_pal
OPTIONS(description='Werbe. BestellM PAL  '), menge_iwt_gesamt_pal OPTIONS(description='IWT Gesamtmenge PAL    '),
menge_iwt_pal OPTIONS(description='IWT BestellM PAL'), splitsource_id OPTIONS(description='Splitsource '),
menge_bevorratung OPTIONS(description='Menge Bevorratung    '), bedarfsnummer
OPTIONS(description='Bedarfsnummer             '), ursprungsprozess OPTIONS(description='Ursprungsprozess'),
best_vor_dispo_id
OPTIONS(description='ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'))
OPTIONS(DESCRIPTION = `Order-Split `) AS SELECT mandant_id,
 gp_dispo_id,
 best_beleg_dispo_id,
 art_dispo_id,
 bestellart_id,
 einkaeufer_grp_id,
 wup_id,
 nb_id,
 gp_id,
 disponent_id,
 gp_teilsortiment_id,
 fremd_lagerort_id,
 art_id,
 menge_gesamt,
 menge_iwt_gesamt,
 menge_normal,
 menge_iwt,
 menge_werbung_gesamt,
 menge_werbung,
 menge_einh_id,
 dat_lief_wunsch,
 kontrakt_beleg_id,
 kontrakt_beleg_pos_id,
 best_beleg_id,
 best_beleg_pos_id,
 vz_dispo_status_id,
 palettenfaktor,
 gewicht_brutto_bme,
 dat_verfuegbarkeit,
 faktor_bestme_bme,
 gewicht_pal,
 gewicht_gesamt,
 anz_plaetze_max,
 gewicht_ladung_max,
 planlieferzeit,
 autodispo_fg,
 wg_id,
 menge_werbung_gesamt_pal,
 menge_best_pal,
 menge_best_werbung_pal,
 menge_iwt_gesamt_pal,
 menge_iwt_pal,
 splitsource_id,
 menge_bevorratung,
 bedarfsnummer,
 ursprungsprozess,
 best_vor_dispo_id
FROM kfl_production_dbp_data.vz_best_split;