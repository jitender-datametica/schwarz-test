--==============================================================
-- Table: besch_faktura_det_kmo_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_det_kmo_1
   generated from Powerdesigner on Donnerstag, 29. September 2022 10:57:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_det_kmo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
faktura_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln'),
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr'),
dat_faktura_sap DATE NOT NULL
OPTIONS(description='Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck. Aus fkdat vbrk. Wird in dieser Tabelle kuenstlich gehalten, um eine_1 Partitionierung durchführen zu können.'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
menge_faktura_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Tatsaechlich fakturierte Menge aus fkimg'),
betrag_verrechnung NUMERIC(18,4)
OPTIONS(description='Verrechnungswert in Belegwährung aus wavwr. Verschlüsselt. Kann GLD oder Standardpreis sein'),
betrag_netto NUMERIC(18,4) NOT NULL
OPTIONS(description='Nettowert der Fakturaposition in Belegwährung aus netwr (Umsatz zu VKnetto)'),
zwsum_1_betrag NUMERIC(18,4) NOT NULL
OPTIONS(description='Konditionszwischensumme 1 aus dem Kalkulationsschema aus kzwi1'),
betrag_mwst NUMERIC(18,4) NOT NULL OPTIONS(description='Steuerbetrag in Belegwaehrung aus mwsbp'),
retoure_pos_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichnung von Retouren-Positionen mit X. Weitere Kennzeichen moeglich. Aus shkzg'),
basismenge_einh_id STRING(3) NOT NULL
OPTIONS(description='Alternative Mengenheinheit für den Artikel_1 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per. Aus meins '),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsmengeneinheit aus vrkme'),
menge_faktura_lme NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge in Lagermengeneinheiten aus fklmg'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnet, ob der Beleg innerhalb einer Abverkaufsaktion erzeugt wurde. Denormalisiert, angereichert aus Performancegruenden.'),
steuer_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Steuertyp (sales_1 tax, federal sales_1 tax,...) aus tatyp. Hier sollte immer der Steuertyp für Mehrwertsteuer enthalten sein.Referenz zur Tabelle l_sap_steuersatz_1'),
sap_mwst_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Steuerkennzeichen aus taxkm. Referenz zur Tabelle l_sap_steuersatz_1'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
vk_aktion_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Aktionsverkaufspreis brutto. Angereichert aus Performancegruenden'),
vk_vor_aktion_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Aktionsverkaufspreis brutto unmittelbar vor der Aktion. Angereichert aus Performancegruenden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat_faktura_sap
OPTIONS(description='WWC  - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für KMO. Die dazugehoerigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA_kmo');