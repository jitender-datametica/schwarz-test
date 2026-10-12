DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.BESCH_FAKTURA_DET_KMO_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_FAKTURA_DET_KMO_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
FAKTURA_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln'),
FAKTURA_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr'),
DAT_FAKTURA_SAP DATE NOT NULL
OPTIONS(description='Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck. Aus fkdat vbrk. Wird in dieser Tabelle kuenstlich gehalten, um eine_1 Partitionierung durchführen zu können.'),
ART_ID INTEGER
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
WUP_ID INTEGER OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MENGE_FAKTURA_BME NUMERIC(18,3) NOT NULL OPTIONS(description='Tatsaechlich fakturierte Menge aus fkimg'),
BETRAG_VERRECHNUNG NUMERIC(18,4)
OPTIONS(description='Verrechnungswert in Belegwährung aus wavwr. Verschlüsselt. Kann GLD oder Standardpreis sein'),
BETRAG_NETTO NUMERIC(18,4) NOT NULL
OPTIONS(description='Nettowert der Fakturaposition in Belegwährung aus netwr (Umsatz zu VKnetto)'),
ZWSUM_1_BETRAG NUMERIC(18,4) NOT NULL
OPTIONS(description='Konditionszwischensumme 1 aus dem Kalkulationsschema aus kzwi1'),
BETRAG_MWST NUMERIC(18,4) NOT NULL OPTIONS(description='Steuerbetrag in Belegwaehrung aus mwsbp'),
RETOURE_POS_KZ STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichnung von Retouren-Positionen mit X. Weitere Kennzeichen moeglich. Aus shkzg'),
BASISMENGE_EINH_ID STRING(3) NOT NULL
OPTIONS(description='Alternative Mengenheinheit für den Artikel_1 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per. Aus meins '),
VERK_MENGE_EINH_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsmengeneinheit aus vrkme'),
MENGE_FAKTURA_LME NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge in Lagermengeneinheiten aus fklmg'),
AKTION_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnet, ob der Beleg innerhalb einer Abverkaufsaktion erzeugt wurde. Denormalisiert, angereichert aus Performancegruenden.'),
STEUER_TYP_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Steuertyp (sales_1 tax, federal sales_1 tax,...) aus tatyp. Hier sollte immer der Steuertyp für Mehrwertsteuer enthalten sein.Referenz zur Tabelle l_sap_steuersatz_1'),
SAP_MWST_ID STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Steuerkennzeichen aus taxkm. Referenz zur Tabelle l_sap_steuersatz_1'),
VK_AKTION_BRUTTO NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Aktionsverkaufspreis brutto. Angereichert aus Performancegruenden'),
VK_VOR_AKTION_BRUTTO NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Aktionsverkaufspreis brutto unmittelbar vor der Aktion. Angereichert aus Performancegruenden'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, FAKTURA_BELEG_ID, FAKTURA_BELEG_POS_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT_FAKTURA_SAP
OPTIONS(description='WWC  - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für KMO. Die dazugehoerigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA_kmo');