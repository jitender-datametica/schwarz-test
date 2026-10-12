CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_det (mandant_id
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
faktura_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Faktura und dient der eindeutigen Identifikation der Fakturabelege.'),
faktura_beleg_pos_id
OPTIONS(description='Das Feld enthält die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen.'),
art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id
OPTIONS(description='Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup eindeutig identifiziert werden. SAP RET - VBPA - KUNNR'),
nb_id
OPTIONS(description='Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).'),
lagerort_id OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.\n\n'), verrechnung_betrag
OPTIONS(description='Verrechnungswert einer Position in einem lieferbezogenen Fakturabeleg. Der Verrechnungswert wird bei der Buchung des Warenausgangs ermittelt. Aus wavwr'),
zwsum_1_betrag
OPTIONS(description='Konditionszwischensumme 1 aus dem Kalkulationsschema. Dies entspricht dem End Betrag des Schemas.'),
zwsum_2_betrag
OPTIONS(description='Konditionszwischensumme 2 aus dem Kalkulationsschema. Dies entspricht dem Verkaufspreis.'),
zwsum_3_betrag
OPTIONS(description='Konditionszwischensumme 3 aus dem Kalkulationsschema. Dies entspricht dem Einkaufspreis Netto bei Reklamationen (Einkaufspreis netto  bzw. EK-Aktion netto vermindert um die Reklapauschale).'),
zwsum_4_betrag
OPTIONS(description='Konditionszwischensumme 4 aus dem Kalkulationsschema. Dies entspricht dem Lagerwert bei Reklamationen (Reklapauschale)'),
zwsum_5_betrag
OPTIONS(description='Konditionszwischensumme 5 aus dem Kalkulationsschema. Dies entspricht dem Verkaufswert bei Reklamationen.'),
zwsum_6_betrag
OPTIONS(description='Konditionszwischensumme 6 aus dem Kalkulationsschema. Dies entspricht dem Wert der Logistikvergütung für diese Position.'),
menge_faktura_bme OPTIONS(description='Fakturierte Menge der Fakturabelegposition.'), aktion_id
OPTIONS(description='Nummer zur Identifizierung einer Aktion, für die beschafft werden soll. Sie können pro Position eines Einkaufsbelegs eingeben, zu welcher Aktion die Position gehört.'),
verk_menge_einh_id
OPTIONS(description='Dieses Feld enthält die Mengenheiheit für die Berechnung der Basismenge in die alternative Mengeneinheit (Verkaufsmenge). Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per pro Material zu ermitteln.'),
menge_faktura_kolli
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt.'),
menge_faktura_palette
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt.'),
dat_leist_erstellung OPTIONS(description='Datum der Leistungserstellung.\n'), vorlage_beleg_id
OPTIONS(description='Belegnummer des Vorlagebeleges'), vorlage_beleg_pos_id
OPTIONS(description='Positionsnummer des Vorlagebelegs'), best_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.\n(Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)'),
best_beleg_pos_id
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbelet ID  der eindeutigen Identifikation der Bestellbelegpositionen.\n(Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen'),
dat_faktura_sap
OPTIONS(description='Das Original - Fakturadatum aus SAP. Gehört logisch nur in die Kopftabelle und ist aus historischen Gründen hier gespeichert'),
auftrag_grund_id
OPTIONS(description='Dieses Attribut gibt den Grund für die Erstellung des Verkaufsbelegs an. Referenz zu der Tabelle l_auftrag_grund'),
dat_faktura
OPTIONS(description='Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt Das Feld wird aus der Kopftabelle\""vererbt\"", um einen PPI darüber bilden zu können (Performance!)'),
zwsum_8_betrag
OPTIONS(description='Enthält den Rabattbetrag  bezogen auf den VK im Fall von teilkostenloser Lieferung.'),
zwsum_9_betrag
OPTIONS(description='Enthält den Rabattbetrag - bezogen auf den EK - im Fall von teilkostenloser Lieferung. Format NUMERIC(29,2) Compress CD-47-AD-36-C7-B7-B2-2A-FF-C7-61-09-CC-15-E3-DD'),
bestellart_id
OPTIONS(description='Die Bestellart wurde in diese Tabelle einbezogen, um teilkostenlose Lieferungen aus den Fakturen bestimmen zu können. Eigenstlich gehört die Bestellart zu den Bestellungen (besch_best)'),
menge_faktura_kg
OPTIONS(description='Die fakturierte Mengen in Kilogramm. Entspricht bei Gewichtsware der Column menge_fakturiert, wird bei Stückware berechnet. Redundantes Feld aus Performancegründen für einen! Bericht Fakturaliste Wurst'),
dat_preisfindung OPTIONS(description='Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen'), mwst
OPTIONS(description='Mehrwertsteuersatz. Wird aus Performancegründen hier redundant gespeichert. Datenformat mit Absicht abweichend von der Tabelle mwst'),
ek_netto_bnk
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis.'),
ek_mep OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), betrag_ek_mep_vor_fwu
OPTIONS(description='Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'),
betrag_logkostenzuschlag OPTIONS(description='Menge * Logistikkostenzuschlag (ZEKP.LOKAU).')) AS SELECT mandant_id,
 faktura_beleg_id,
 faktura_beleg_pos_id,
 art_id,
 wup_id,
 nb_id,
 lagerort_id,
 verrechnung_betrag,
 zwsum_1_betrag,
 zwsum_2_betrag,
 zwsum_3_betrag,
 zwsum_4_betrag,
 zwsum_5_betrag,
 zwsum_6_betrag,
 menge_faktura_bme,
 aktion_id,
 verk_menge_einh_id,
 menge_faktura_kolli,
 menge_faktura_palette,
 dat_leist_erstellung,
 vorlage_beleg_id,
 vorlage_beleg_pos_id,
 best_beleg_id,
 best_beleg_pos_id,
 dat_faktura_sap,
 auftrag_grund_id,
 dat_faktura,
 zwsum_8_betrag,
 zwsum_9_betrag,
 bestellart_id,
 menge_faktura_kg,
 dat_preisfindung,
 mwst,
 ek_netto_bnk,
 ek_mep,
 wrg_id,
 betrag_ek_mep_vor_fwu,
 betrag_logkostenzuschlag
FROM kfl_production_dbp_data.besch_faktura_det;