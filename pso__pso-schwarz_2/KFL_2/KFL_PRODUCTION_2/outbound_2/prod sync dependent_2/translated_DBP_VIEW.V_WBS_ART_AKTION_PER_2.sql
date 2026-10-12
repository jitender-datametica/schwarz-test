CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_art_aktion_per_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
wup_id OPTIONS(description='Filiale-ID (6906, 3000, ...).'), nb_id
OPTIONS(description='Nebenbetrieb-ID (Lager, Filiale, ...).'), art_id OPTIONS(description='Artikelnummer.'), aktion_id
OPTIONS(description='Aktionsnummer.'), kjwo_von
OPTIONS(description='Start-Kalenderwoche der Aktion_2, entsprechend dat_von.'), dat_von
OPTIONS(description='Aktion_2 gültig von: Datum im Format JJJJ-MM_2-TT.'), dat_bis
OPTIONS(description='Aktion_2 gültig bis: Datum im Format JJJJ-MM_2-TT.'), aktion_dauer
OPTIONS(description='Dauer der Aktion.'), wtag_id_von OPTIONS(description='Wochentag des Werbestarts.'), mutter_wb_id
OPTIONS(description='Artikelnummer des Werbemutterartikels.'), mandant_id_vz
OPTIONS(description='Mandant_2 VZ. Das Auslieferungsland kann sich in gewissen Fällen vom Markt unterscheiden, z.B. wird Moldau (mandant_id 4) aus Rumänien (mandant_id 7) beliefert. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern (es wird ein Join mit WBS_WERBEAENDERUNGEN_2 vermieden).'),
wup_id_vz
OPTIONS(description='WUP_2 ID VZ. Marktnummer des Verteilzentrums. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern.'),
menge_sa_bme
OPTIONS(description='Tatsächlich verkaufte Promotion Menge in der historischen Aktion_2 in BME (wurde gefiltert auf bewart_2 = 1002, SonderAktion, beinhaltet auch BBY),'),
menge_gesamt_bme
OPTIONS(description='Die Summe der gesamten Promotionsmenge, die während des Aktionszeitraums verkauft wurde, unabhängig davon, ob sie durch die Promotion oder aus anderen Gründen, z.B. Kundenkartenrabatt verkauft wurde, in BME (für bewart_2 = Sonderaktion und aktionsfrei, z.B. Kundenkarte, Bonusrabatt, etc.).'),
zeitraum_korrigierte_menge OPTIONS(description='Korrigierte Menge in BME.'), zeitraum_menge_af_4wo
OPTIONS(description='Menge Abverkauf AF 4 Wochen vor Aktion.'), sales_fg
OPTIONS(description='Flag: Zeigt an, ob in einer Woche_2 Absätze vorhanden waren.'), in_gruppe_fg
OPTIONS(description='Flag: Gibt an, ob ein Artikel_2 Teil einer Serie war.'), anz_art_in_gruppe
OPTIONS(description='Gibt die Anzahl der Artikel_2 in einer Serie der aktuellen Aktion_2 an.'), tv_fg
OPTIONS(description='Flag: Zeigt an, ob der Artikel_2 TV-Werbung hatte.'), titelseite_fg
OPTIONS(description='Flag: Gibt an, ob der Artikel_2 auf der Titelseite der Werbung abgebildet war.'), rueckseite_fg
OPTIONS(description='Flag: Gibt an, ob der Artikel_2 auf der Rückseite der Werbung abgebildet war.'), gk_fg
OPTIONS(description='Flag: Zeigt an, ob der Artikel_2 eine_2 Gondelkopfplatzierung hatte.'), vk_aktion_brutto
OPTIONS(description='VK_2-Preis Aktion_2 Brutto.'), vk_vor_aktion_brutto OPTIONS(description='VK_2-Preis vor Aktion_2 Brutto.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), multi_offer_id_fg
OPTIONS(description='Flag zur Markierung von Aktionszeiträumen mit multiplen Angeboten. Im selben Zeitraum können für einen Artikel_2 mehrere Angebote existieren, z.B. über den Prospekt und über die K-Card.'),
bonuskauf_fg
OPTIONS(description='Flag zur Markierung von Bonusbuy-Aktionen. Zuordnung von BONUSKAUF_ID und AKTION_ID steht in L_BONUSKAUF.'),
lokale_geschaeftsvorfall_bez
OPTIONS(description='Bezeichnung des Bonusbuy-Geschäftsvorfalls in lokaler Sprache. Zuordnung von BONUSKAUF_ID und GESCHAEFTSVORFALL_ID steht in L_BONUSKAUF.'),
berechnete_menge_gesamt_bme
OPTIONS(description='Gibt die urspruenglich berechnete Werbemenge fuer diese Artikel_2-Markt-Aktion_2-Kombination aus.'),
lief_menge_initial_bme
OPTIONS(description='Liefermenge, die für die Erstlieferung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge in der initialen Belieferung an (nach Fair Share).'),
lief_menge_hochrechnung_bme
OPTIONS(description='Liefermenge, die nach der Anpassungsberechnung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge aus der Hochrechnung an (nach Fair Share). WBS führt eine_2 Berechnung nach der Initialen Belieferung durch (Hochrechnung), was dann die nachgelieferte Menge in der betrachteten Spalte beinflusst (kann auch 0 sein). Die Summe von lief_menge_initial_bme_ref und lief_menge_hochrechnung_bme_ref kann sich unterscheiden von berechnete_menge_gesamt_bme_ref.'),
lief_menge_anteil_prozent
OPTIONS(description='Gibt an, wieviel % der Werbeware im Vergleich zur urspruenglich berechneten Werbemenge ausgeliefert wurde. Dies dient dem User dazu zu bewerten, ob der Werbeabsatz eventuell zu gering war, weil Ware nicht im Markt vorhanden war.\n\""(MENGE_INITIAL_BME + MENGE_WBS [nach Umrechnung von AME zu BME]) / MENGE_GESAMT_BME\""'),
nur_online_fg OPTIONS(description='Flag: Zeigt an, ob die Werbung nur online geschaltet wurde.'),
kundenkarte_personalisiert_fg
OPTIONS(description='Flag: Zeigt an, ob die Werbung ein personalisierter Kundenkarten-Coupon ist.'), stille_aktion_fg
OPTIONS(description='Flag: Stille Aktion_2 Typ:\""In Store Promotions\"" (ohne Mengenberechnung) - Identifikation, um Artikel_2 mit dieser FG aus der Berechnung auszuschließen.\nStille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine_2 Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion_2 werden keine Mengenberechnungen durchgeführt.'),
stille_aktion_mit_menge_fg
OPTIONS(description='Flag: Stille Aktion_2 Typ:\""In Store Promotions mit Menge\"" - für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50. Artikel_2 wird nur in Filiale beworben, erhält aber Mengenberechnung.\nStille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine_2 Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion_2 werden Mengenberechnungen durchgeführt.'),
werbeflaeche_abschnitt_name
OPTIONS(description='Gibt an, in welchem Abschnitt eines Bereichs (in einer Werbeflyerseite) das Angebot_2 abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put.'),
werbeflaeche_thema_bez
OPTIONS(description='Bezeichnung für die WERBEFLAECHE_THEMA_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme.'),
fixmenge_fg
OPTIONS(description='Fixmenge EK Flag gibt an, ob vom Einkauf eine_2 Fixmenge für diese Aktion_2 festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
fixmenge_wfl_fg
OPTIONS(description='Fixmenge WFL Flag gibt an, ob vom Warenfluss eine_2 Fixmenge für diese Aktion_2 festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
mindestplatzierung_fg
OPTIONS(description='Flag gibt an, ob vom Warenfluss eine_2 Mindestplatzierung für diese Aktion_2 festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'))
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 aktion_id,
 kjwo_von,
 dat_von,
 dat_bis,
 aktion_dauer,
 wtag_id_von,
 mutter_wb_id,
 mandant_id_vz,
 wup_id_vz,
 menge_sa_bme,
 menge_gesamt_bme,
 zeitraum_korrigierte_menge,
 zeitraum_menge_af_4wo,
 sales_fg,
 in_gruppe_fg,
 anz_art_in_gruppe,
 tv_fg,
 titelseite_fg,
 rueckseite_fg,
 gk_fg,
 vk_aktion_brutto,
 vk_vor_aktion_brutto,
 wrg_id,
 multi_offer_id_fg,
 bonuskauf_fg,
 lokale_geschaeftsvorfall_bez,
 berechnete_menge_gesamt_bme,
 lief_menge_initial_bme,
 lief_menge_hochrechnung_bme,
 lief_menge_anteil_prozent,
 nur_online_fg,
 kundenkarte_personalisiert_fg,
 stille_aktion_fg,
 stille_aktion_mit_menge_fg,
 werbeflaeche_abschnitt_name,
 werbeflaeche_thema_bez,
 fixmenge_fg,
 fixmenge_wfl_fg,
 mindestplatzierung_fg
FROM kfl_production_dbp_data.wbs_art_aktion_per_2;