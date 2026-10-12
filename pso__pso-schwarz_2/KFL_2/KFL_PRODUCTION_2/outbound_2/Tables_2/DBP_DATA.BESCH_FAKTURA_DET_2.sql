--==============================================================
-- Table: besch_faktura_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_det_2
   generated from Powerdesigner on Montag, 21. Juli 2025 05:50:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
faktura_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Faktura und dient der eindeutigen Identifikation der Fakturabelege.'),
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup_2 eindeutig identifiziert werden. SAP RET - VBPA - KUNNR'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.                        '),
verrechnung_betrag NUMERIC(18,4)
OPTIONS(description='Verrechnungswert einer Position in einem lieferbezogenen Fakturabeleg. Der Verrechnungswert wird bei der Buchung des Warenausgangs ermittelt. Aus wavwr'),
zwsum_1_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 1 aus dem Kalkulationsschema. Dies entspricht dem End Betrag des Schemas.'),
zwsum_2_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 2 aus dem Kalkulationsschema. Dies entspricht dem Verkaufspreis.'),
zwsum_3_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 3 aus dem Kalkulationsschema. Dies entspricht dem Einkaufspreis Netto bei Reklamationen (Einkaufspreis netto  bzw. EK-Aktion_2 netto vermindert um die Reklapauschale).'),
zwsum_4_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 4 aus dem Kalkulationsschema. Dies entspricht dem Lagerwert bei Reklamationen (Reklapauschale)'),
zwsum_5_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 5 aus dem Kalkulationsschema. Dies entspricht dem Verkaufswert bei Reklamationen.'),
zwsum_6_betrag NUMERIC(18,4)
OPTIONS(description='Konditionszwischensumme 6 aus dem Kalkulationsschema. Dies entspricht dem Wert der Logistikvergütung für diese Position.'),
menge_faktura_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturierte Menge der Fakturabelegposition.'),
aktion_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Nummer zur Identifizierung einer Aktion_2, für die beschafft werden soll. Sie können pro Position eines Einkaufsbelegs eingeben, zu welcher Aktion_2 die Position gehört.'),
verk_menge_einh_id STRING(3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Mengenheiheit für die Berechnung der Basismenge in die alternative Mengeneinheit (Verkaufsmenge). Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per_2 pro Material zu ermitteln.'),
menge_faktura_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_2 ermittelt.'),
menge_faktura_palette NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_2 und art_umrechnung_faktor_per_2 ermittelt.'),
dat_leist_erstellung DATE NOT NULL OPTIONS(description='Datum der Leistungserstellung.                 '),
vorlage_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Vorlagebeleges'),
vorlage_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer des Vorlagebelegs'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.            (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbelet ID  der eindeutigen Identifikation der Bestellbelegpositionen.            (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen'),
dat_faktura_sap DATE NOT NULL
OPTIONS(description='Das Original - Fakturadatum aus SAP. Gehört logisch nur in die Kopftabelle und ist aus historischen Gründen hier gespeichert'),
auftrag_grund_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Dieses Attribut gibt den Grund für die Erstellung des Verkaufsbelegs an. Referenz zu der Tabelle l_auftrag_grund_2'),
dat_faktura DATE NOT NULL
OPTIONS(description='Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance!)'),
zwsum_8_betrag NUMERIC(18,4)
OPTIONS(description='Enthält den Rabattbetrag  bezogen auf den VK_2 im Fall von teilkostenloser Lieferung.'),
zwsum_9_betrag NUMERIC(18,4)
OPTIONS(description='Enthält den Rabattbetrag - bezogen auf den EK - im Fall von teilkostenloser Lieferung. Format NUMERIC(18,2) Compress CD-47-AD-36-C7-B7-B2-2A-FF-C7-61-09-CC-15-E3-DD'),
bestellart_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Die Bestellart wurde in diese Tabelle einbezogen, um teilkostenlose Lieferungen aus den Fakturen bestimmen zu können. Eigenstlich gehört die Bestellart zu den Bestellungen (besch_best_2)'),
menge_faktura_kg NUMERIC(18,3)
OPTIONS(description='Die fakturierte Mengen in Kilogramm. Entspricht bei Gewichtsware der Column menge_fakturiert, wird bei Stückware berechnet. Redundantes Feld aus Performancegründen für einen! Bericht Fakturaliste Wurst'),
dat_preisfindung DATE OPTIONS(description='Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen'),
mwst NUMERIC(9,2)
OPTIONS(description='Mehrwertsteuersatz. Wird aus Performancegründen hier redundant gespeichert. Datenformat mit Absicht abweichend von der Tabelle mwst'),
ek_netto_bnk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis.'),
ek_mep NUMERIC(18,4) OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_ek_mep_vor_fwu BIGNUMERIC(38,5)
OPTIONS(description='Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'),
betrag_logkostenzuschlag BIGNUMERIC(38,5) OPTIONS(description='Menge * Logistikkostenzuschlag (ZEKP.LOKAU).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id) NOT ENFORCED
) CLUSTER BY dat_faktura
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für Mandant_2 1. Die dazugehörigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA.');