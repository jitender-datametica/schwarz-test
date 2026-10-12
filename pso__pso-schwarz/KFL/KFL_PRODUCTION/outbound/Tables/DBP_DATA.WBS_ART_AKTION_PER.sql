--==============================================================
-- Table: wbs_art_aktion_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_aktion_per
   generated from Powerdesigner on Freitag, 27. Dezember 2024 11:25:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_art_aktion_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale-ID (6906, 3000, ...).'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb-ID (Lager, Filiale, ...).'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer.'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktionsnummer.'),
kjwo_von BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Start-Kalenderwoche der Aktion, entsprechend dat_von.'),
dat_von DATE NOT NULL OPTIONS(description='Aktion gültig von: Datum im Format JJJJ-MM-TT.'),
dat_bis DATE NOT NULL OPTIONS(description='Aktion gültig bis: Datum im Format JJJJ-MM-TT.'),
aktion_dauer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Dauer der Aktion.'),
wtag_id_von BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag des Werbestarts.'),
mutter_wb_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer des Werbemutterartikels.'),
mandant_id_vz BIGNUMERIC(38,0)
OPTIONS(description='Mandant VZ. Das Auslieferungsland kann sich in gewissen Fällen vom Markt unterscheiden, z.B. wird Moldau (mandant_id 4) aus Rumänien (mandant_id 7) beliefert. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern (es wird ein CROSS JOIN mit WBS_WERBEAENDERUNGEN vermieden).'),
wup_id_vz BIGNUMERIC(38,0)
OPTIONS(description='WUP ID VZ. Marktnummer des Verteilzentrums. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern.'),
menge_sa_bme BIGNUMERIC(38,3)
OPTIONS(description='Tatsächlich verkaufte Promotion Menge in der historischen Aktion in BME (wurde gefiltert auf bewart = 1002, SonderAktion, beinhaltet auch BBY),'),
menge_gesamt_bme BIGNUMERIC(38,3)
OPTIONS(description='Die Summe der gesamten Promotionsmenge, die während des Aktionszeitraums verkauft wurde, unabhängig davon, ob sie durch die Promotion oder aus anderen Gründen, z.B. Kundenkartenrabatt verkauft wurde, in BME (für bewart = Sonderaktion und aktionsfrei, z.B. Kundenkarte, Bonusrabatt, etc.).'),
zeitraum_korrigierte_menge BIGNUMERIC(38,3) OPTIONS(description='Korrigierte Menge in BME.'),
zeitraum_menge_af_4wo BIGNUMERIC(38,3) OPTIONS(description='Menge Abverkauf AF 4 Wochen vor Aktion.'),
sales_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Zeigt an, ob in einer Woche Absätze vorhanden waren.'),
in_gruppe_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Gibt an, ob ein Artikel Teil einer Serie war.'),
anz_art_in_gruppe BIGNUMERIC(38,0)
OPTIONS(description='Gibt die Anzahl der Artikel in einer Serie der aktuellen Aktion an.'),
tv_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Zeigt an, ob der Artikel TV-Werbung hatte.'),
titelseite_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Gibt an, ob der Artikel auf der Titelseite der Werbung abgebildet war.'),
rueckseite_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Gibt an, ob der Artikel auf der Rückseite der Werbung abgebildet war.'),
gk_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Zeigt an, ob der Artikel eine Gondelkopfplatzierung hatte.'),
vk_aktion_brutto BIGNUMERIC(38,2) OPTIONS(description='VK-Preis Aktion Brutto.'),
vk_vor_aktion_brutto BIGNUMERIC(38,2) OPTIONS(description='VK-Preis vor Aktion Brutto.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
multi_offer_id_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag zur Markierung von Aktionszeiträumen mit multiplen Angeboten. Im selben Zeitraum können für einen Artikel mehrere Angebote existieren, z.B. über den Prospekt und über die K-Card.'),
bonuskauf_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag zur Markierung von Bonusbuy-Aktionen. Zuordnung von BONUSKAUF_ID und AKTION_ID steht in L_BONUSKAUF.'),
lokale_geschaeftsvorfall_bez STRING(40)
OPTIONS(description='Bezeichnung des Bonusbuy-Geschäftsvorfalls in lokaler Sprache. Zuordnung von BONUSKAUF_ID und GESCHAEFTSVORFALL_ID steht in L_BONUSKAUF.'),
berechnete_menge_gesamt_bme BIGNUMERIC(38,3)
OPTIONS(description='Gibt die urspruenglich berechnete Werbemenge fuer diese Artikel-Markt-Aktion-Kombination aus.'),
lief_menge_initial_bme BIGNUMERIC(38,3)
OPTIONS(description='Liefermenge, die für die Erstlieferung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge in der initialen Belieferung an (nach Fair Share).'),
lief_menge_hochrechnung_bme BIGNUMERIC(38,3)
OPTIONS(description='Liefermenge, die nach der Anpassungsberechnung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge aus der Hochrechnung an (nach Fair Share). WBS führt eine Berechnung nach der Initialen Belieferung durch (Hochrechnung), was dann die nachgelieferte Menge in der betrachteten Spalte beinflusst (kann auch 0 sein). Die Summe von lief_menge_initial_bme_ref und lief_menge_hochrechnung_bme_ref kann sich unterscheiden von berechnete_menge_gesamt_bme_ref.'),
lief_menge_anteil_prozent BIGNUMERIC(38,2)
OPTIONS(description='Gibt an, wieviel % der Werbeware im Vergleich zur urspruenglich berechneten Werbemenge ausgeliefert wurde. Dies dient dem User dazu zu bewerten, ob der Werbeabsatz eventuell zu gering war, weil Ware nicht im Markt vorhanden war.            "(MENGE_INITIAL_BME + MENGE_WBS [nach Umrechnung von AME zu BME]) / MENGE_GESAMT_BME"'),
nur_online_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Zeigt an, ob die Werbung nur online geschaltet wurde.'),
kundenkarte_personalisiert_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Zeigt an, ob die Werbung ein personalisierter Kundenkarten-Coupon ist.'),
stille_aktion_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Stille Aktion Typ: "In Store Promotions" (ohne Mengenberechnung) - Identifikation, um Artikel mit dieser FG aus der Berechnung auszuschließen.            Stille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden keine Mengenberechnungen durchgeführt.'),
stille_aktion_mit_menge_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Stille Aktion Typ: "In Store Promotions mit Menge" - für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50. Artikel wird nur in Filiale beworben, erhält aber Mengenberechnung.            Stille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden Mengenberechnungen durchgeführt.'),
werbeflaeche_abschnitt_name STRING(100)
OPTIONS(description='Gibt an, in welchem Abschnitt eines Bereichs (in einer Werbeflyerseite) das Angebot abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put.'),
werbeflaeche_thema_bez STRING(100)
OPTIONS(description='Bezeichnung für die WERBEFLAECHE_THEMA_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme.'),
fixmenge_fg BIGNUMERIC(38,0)
OPTIONS(description='Fixmenge EK Flag gibt an, ob vom Einkauf eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
fixmenge_wfl_fg BIGNUMERIC(38,0)
OPTIONS(description='Fixmenge WFL Flag gibt an, ob vom Warenfluss eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
mindestplatzierung_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an, ob vom Warenfluss eine Mindestplatzierung für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, aktion_id, dat_von) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - Operational data for WBS tool. This table contains data for the historry of articles and promotions. It is not actually a historization table that tracks changes but just the occurences of articles in promotions over time.');