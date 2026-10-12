CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_art_aktion_ref (mandant_id OPTIONS(description='Mandant im DWH.'),
wup_id OPTIONS(description='Filiale-ID (6906, 3000, ...).'), nb_id
OPTIONS(description='Nebenbetrieb-ID (Lager, Filiale, ...).'), art_id OPTIONS(description='Artikelnummer.'), aktion_id
OPTIONS(description='Aktionsnummer, Promotion-ID.'), kjwo_von
OPTIONS(description='Start-Kalenderwoche der Aktion entsprechend dat_von.'), dat_von
OPTIONS(description='Aktuelle Aktion gültig von: Datum im Format JJJJ-MM-TT.'), dat_bis
OPTIONS(description='Aktuelle Aktion gültig bis: Datum im Format JJJJ-MM-TT.'), aktion_dauer
OPTIONS(description='Dauer der Aktion.'), wtag_id_von OPTIONS(description='Werbestart Wochentag.'), mandant_id_vz
OPTIONS(description='Mandant VZ. Das Auslieferungsland kann sich in gewissen Fällen vom Markt unterscheiden, z.B. wird Moldau (mandant_id 4) aus Rumänien (mandant_id 7) beliefert. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern (es wird ein Join mit WBS_WERBEAENDERUNGEN vermieden).'),
wup_id_vz
OPTIONS(description='WUP ID VZ. Marktnummer des Verteilzentrums. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern.'),
mutter_wb_id OPTIONS(description='Artikelnummer des Werbemutterartikels.'), wup_id_ref
OPTIONS(description='Der Referenzmarkt, der fuer den Aktionsvergleich gespeichert wird. Fuer eine zukuenftige Aktion eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel und Markt der geplanten Aktion sein. Der Referenztyp sagt aus um welche Art von Vergleich es sich handelt.\nFuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.\nFuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
nb_id_ref OPTIONS(description='NB_ID_REF, welche zur WUP_ID_REF gehört.'), art_id_ref
OPTIONS(description='Der Referenzartikel, der für den Artikelvergleich gespeichert wurde. Fuer eine zukuenftige Aktion eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel und Markt der geplanten Aktion sein. Der Referenztyp sagt aus um welche Art von Vergleich es sich handelt.\nFuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.\nFuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
faktor_ref
OPTIONS(description='Faktor für die Gewichtung der Referenzmetriken.\nFuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.\nFuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
aktion_id_ref OPTIONS(description='Aktionsnummer (historische Aktion), Promotion-ID.'), dat_von_ref
OPTIONS(description='Historische Aktion gültig von: Datum im Format JJJJ-MM-TT.'), dat_bis_ref
OPTIONS(description='Historische Aktion gültig bis: Datum im Format JJJJ-MM-TT.'), aktion_reihenfolge
OPTIONS(description='Position in der Zeitlichen Reihenfolge der vergangenen Aktionen. Bei 0 gibt es keine vergleichbare historische Aktion.'),
anz_akt_selbe_dauer OPTIONS(description='Anzahl Aktionen mit selber Dauer.'), menge_sa_bme_ref
OPTIONS(description='Tatsächlich verkaufte Promotion Menge in der historischen Aktion in BME (wurde gefiltert auf bewart = 1002, SonderAktion, beinhaltet auch BBY),'),
menge_gesamt_bme_ref
OPTIONS(description='Die Summe der gesamten Promotionsmenge, die während des Aktionszeitraums verkauft wurde, unabhängig davon, ob sie durch die Promotion oder aus anderen Gründen, z.B. Kundenkartenrabatt verkauft wurde, in BME (für bewart = Sonderaktion und aktionsfrei, z.B. Kundenkarte, Bonusrabatt, etc.).'),
zeitraum_korrigierte_menge_ref OPTIONS(description='Korrigierte Menge in BME (historische Referenzperiode).'),
zeitraum_menge_af_4wo_ref OPTIONS(description='Menge Abverkauf AF 4 Wochen vor Aktion (historische Referenzperiode).'),
sales_fg_ref
OPTIONS(description='Flag: Zeigt an, ob in einer Woche Absätze vorhanden waren (historische Referenzperiode).'),
in_gruppe_fg OPTIONS(description='Flag: Zeigt an, ob ein Artikel zu einer Serie gehört.'), anz_art_in_gruppe
OPTIONS(description='Anzahl Artikel in Serie.'), anz_art_in_gruppe_ref
OPTIONS(description='Anzahl Artikel in Serie (historische Referenzperiode).'), tv_fg_ref
OPTIONS(description='Flag: Zeigt an, ob der Artikel TV-Werbung hatte (historische Referenzperiode).'), titelseite_fg_ref
OPTIONS(description='Flag: Zeigt an, ob der Artikel Titelseiten-Werbung hatte (historische Referenzperiode).'),
rueckseite_fg_ref
OPTIONS(description='Flag: Zeigt an, ob der Artikel Rückseiten-Werbung hatte (historische Referenzperiode).'), gk_fg_ref
OPTIONS(description='Flag: Zeigt an, ob der Artikel eine Gondelkopfplatzierung hatte (historische Referenzperiode).'),
vk_aktion_brutto_ref OPTIONS(description='VK-Preis Aktion Brutto (historische Referenzperiode).'),
vk_vor_aktion_brutto_ref OPTIONS(description='VK-Preis vor Aktion Brutto (historische Referenzperiode).'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'), multi_offer_id_fg_ref
OPTIONS(description='Flag zur Markierung von Aktionszeiträumen mit multiplen Angeboten. Im selben Zeitraum können für einen Artikel mehrere Angebote existieren, z.B. über den Prospekt und über die K-Card.'),
bonuskauf_fg_ref
OPTIONS(description='Flag zur Markierung von Bonusbuy-Aktionen. Zuordnung von BONUSKAUF_ID und AKTION_ID steht in L_BONUSKAUF.'),
lokale_geschaeftsvorfall_bez_ref
OPTIONS(description='Bezeichnung des Bonusbuy-Geschäftsvorfalls in lokaler Sprache. Zuordnung von BONUSKAUF_ID und GESCHAEFTSVORFALL_ID steht in L_BONUSKAUF.'),
wbs_art_wup_ref_typ_id
OPTIONS(description='Artikel_WUP (MARKT) Referenztyp id ,(zeigt die Art des vergleich an bezüglich   Art_ID mit  ART_ID_REF und  WUP_ID mit WUP_ID_REF)\n\""1\tgleicher Artikel, gleicher Markt\n2\tanderer Artikel, gleicher Markt\n3\tgleicher Artikel, anderer Markt\n4\tanderer Artikel, anderer Markt\""'),
berechnete_menge_gesamt_bme_ref
OPTIONS(description='Gibt die urspruenglich berechnete Werbemenge fuer diese Artikel-Markt-Aktion-Kombination aus.'),
lief_menge_initial_bme_ref
OPTIONS(description='Liefermenge, die für die Erstlieferung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge in der initialen Belieferung an (nach Fair Share).'),
lief_menge_hochrechnung_bme_ref
OPTIONS(description='Liefermenge, die nach der Anpassungsberechnung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge aus der Hochrechnung an (nach Fair Share). WBS führt eine Berechnung nach der Initialen Belieferung durch (Hochrechnung), was dann die nachgelieferte Menge in der betrachteten Spalte beinflusst (kann auch 0 sein). Die Summe von lief_menge_initial_bme_ref und lief_menge_hochrechnung_bme_ref kann sich unterscheiden von berechnete_menge_gesamt_bme_ref.'),
lief_menge_anteil_prozent_ref
OPTIONS(description='Gibt an, wieviel % der Werbeware im Vergleich zur urspruenglich berechneten Werbemenge ausgeliefert wurde. Dies dient dem User dazu zu bewerten, ob der Werbeabsatz eventuell zu gering war, weil Ware nicht im Markt vorhanden war.\n\""(MENGE_INITIAL_BME + MENGE_WBS [nach Umrechnung von AME zu BME]) / MENGE_GESAMT_BME\""'),
nur_online_fg_ref OPTIONS(description='Flag: Zeigt an, ob die Werbung nur online geschaltet wurde.'),
kundenkarte_personalisiert_fg_ref
OPTIONS(description='Flag: Zeigt an, ob die Werbung ein personalisierter Kundenkarten-Coupon ist.'),
stille_aktion_fg_ref
OPTIONS(description='Flag: Stille Aktion Typ:\""In Store Promotions\"" (ohne Mengenberechnung) - Identifikation, um Artikel mit dieser FG aus der Berechnung auszuschließen.\nStille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden keine Mengenberechnungen durchgeführt.'),
stille_aktion_mit_menge_fg_ref
OPTIONS(description='Flag: Stille Aktion Typ:\""In Store Promotions mit Menge\"" - für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50. Artikel wird nur in Filiale beworben, erhält aber Mengenberechnung.\nStille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden Mengenberechnungen durchgeführt.'),
werbeflaeche_abschnitt_name_ref
OPTIONS(description='Gibt an, in welchem Abschnitt eines Bereichs (in einer Werbeflyerseite) das Angebot abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put.'),
werbeflaeche_thema_bez_ref
OPTIONS(description='Bezeichnung für die WERBEFLAECHE_THEMA_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme.'),
fixmenge_fg_ref
OPTIONS(description='Fixmenge EK Flag gibt an, ob vom Einkauf eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
fixmenge_wfl_fg_ref
OPTIONS(description='Fixmenge WFL Flag gibt an, ob vom Warenfluss eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
mindestplatzierung_fg_ref
OPTIONS(description='Flag gibt an, ob vom Warenfluss eine Mindestplatzierung für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'))
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
 mandant_id_vz,
 wup_id_vz,
 mutter_wb_id,
 wup_id_ref,
 nb_id_ref,
 art_id_ref,
 faktor_ref,
 aktion_id_ref,
 dat_von_ref,
 dat_bis_ref,
 aktion_reihenfolge,
 anz_akt_selbe_dauer,
 menge_sa_bme_ref,
 menge_gesamt_bme_ref,
 zeitraum_korrigierte_menge_ref,
 zeitraum_menge_af_4wo_ref,
 sales_fg_ref,
 in_gruppe_fg,
 anz_art_in_gruppe,
 anz_art_in_gruppe_ref,
 tv_fg_ref,
 titelseite_fg_ref,
 rueckseite_fg_ref,
 gk_fg_ref,
 vk_aktion_brutto_ref,
 vk_vor_aktion_brutto_ref,
 wrg_id,
 multi_offer_id_fg_ref,
 bonuskauf_fg_ref,
 lokale_geschaeftsvorfall_bez_ref,
 wbs_art_wup_ref_typ_id,
 berechnete_menge_gesamt_bme_ref,
 lief_menge_initial_bme_ref,
 lief_menge_hochrechnung_bme_ref,
 lief_menge_anteil_prozent_ref,
 nur_online_fg_ref,
 kundenkarte_personalisiert_fg_ref,
 stille_aktion_fg_ref,
 stille_aktion_mit_menge_fg_ref,
 werbeflaeche_abschnitt_name_ref,
 werbeflaeche_thema_bez_ref,
 fixmenge_fg_ref,
 fixmenge_wfl_fg_ref,
 mindestplatzierung_fg_ref
FROM kfl_production_dbp_data.wbs_art_aktion_ref;