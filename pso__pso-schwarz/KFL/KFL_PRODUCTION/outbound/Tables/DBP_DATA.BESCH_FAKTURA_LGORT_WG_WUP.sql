--==============================================================
-- Table: besch_faktura_lgort_wg_wup
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_lgort_wg_wup
   generated from Powerdesigner on Montag, 19. September 2022 08:03:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_lgort_wg_wup (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifiziert verschiedene Arten von Fakturabelegen, die eine unterschiedliche Verarbeitung durch das System erfordern.'),
dat_faktura DATE NOT NULL
OPTIONS(description='Hier ist abhängig von der Fakturaart entweder das Fakturadatum oder das Datum der Leistungserstellung enthalten'),
dat_erstellung DATE NOT NULL OPTIONS(description='Das Feld enthält das Erstelldatum des Datensatzes'),
dat_leist_erstellung DATE NOT NULL OPTIONS(description='Datum der Leistungserstellung.                 '),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
auftraggeber_id STRING(10) NOT NULL
OPTIONS(description='Kundennummer des Auftaggebers. Noch keine Referenz zu einer bestehenden DWH Tabelle möglich (SAP Quellel KNA1)'),
bestellart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Bestellart'),
dat_preisfindung DATE OPTIONS(description='Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen'),
auftrag_grund_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Grund für die Erstellung eines Verkaufsbelegs'),
verrechnung_betrag NUMERIC(18,2)
OPTIONS(description='Verrechnungswert einer Position in einem lieferbezogenen Fakturabeleg. Der Verrechnungswert wird bei der Buchung des Warenausgangs ermittelt.Format NUMERIC(18,2). Aus wavwr'),
zwsum_1_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 1 aus dem Kalkulationsschema. Dies entspricht dem End Betrag des Schemas. Format NUMERIC(18,2)'),
zwsum_2_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 2 aus dem Kalkulationsschema. Dies entspricht dem Verkaufspreis. Format NUMERIC(18,2)'),
zwsum_3_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 3 aus dem Kalkulationsschema. Dies entspricht dem Einkaufspreis Netto bei Reklamationen (Einkaufspreis netto  bzw. EK-Aktion netto vermindert um die Reklapauschale). Format NUMERIC(18,2)'),
zwsum_4_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 4 aus dem Kalkulationsschema. Dies entspricht dem Lagerwert bei Reklamationen (Reklapauschale) Format NUMERIC(18,2)'),
zwsum_5_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 5 aus dem Kalkulationsschema. Dies entspricht dem Verkaufswert bei Reklamationen. Format NUMERIC(18,2)'),
zwsum_6_betrag NUMERIC(18,2)
OPTIONS(description='Konditionszwischensumme 6 aus dem Kalkulationsschema. Dies entspricht dem Wert der Logistikvergütung für diese Position. Format NUMERIC(18,2)'),
zwsum_8_betrag NUMERIC(18,2)
OPTIONS(description='Enthält den Rabattbetrag  bezogen auf den VK im Fall von teilkostenloser Lieferung. Format NUMERIC(18,2)'),
zwsum_9_betrag NUMERIC(18,2)
OPTIONS(description='Enthält den Rabattbetrag - bezogen auf den EK - im Fall von teilkostenloser Lieferung. Format NUMERIC(18,2) Compress CD-47-AD-36-C7-B7-B2-2A-FF-C7-61-09-CC-15-E3-DD'),
vk_netto_betrag NUMERIC(18,2) OPTIONS(description='zwsum_2_betrag reduziert um MWSt-Betrag'),
vk_netto_rekl_tkl_betrag NUMERIC(18,2) OPTIONS(description='Summe aus zwsum2 + zwsum5 + zwsum8, reduziert um die MWSt'),
menge_faktura_kolli NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt'),
menge_faktura_palette NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt.'),
menge_faktura_bme NUMERIC(18,3) OPTIONS(description='Fakturierte Menge der Fakturabelegposition.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, dat_faktura, dat_erstellung, dat_leist_erstellung, arthiertyp_id,
 auftraggeber_id) NOT ENFORCED
) CLUSTER BY dat_faktura
OPTIONS(description='TP408_LVS - Diese Tabelle enthält die nach Warengruppe, VZ und Lagerort aggregierten Fakturabelege.');