create or replace TABLE KFL_PRODUCTION.DBP_DATA.BESCH_FAKTURA_DET_KMO_1 cluster by (
     MANDANT_ID,
     DAT_FAKTURA_SAP 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	FAKTURA_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln',
	FAKTURA_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr',
	DAT_FAKTURA_SAP DATE NOT NULL COMMENT 'Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck. Aus fkdat vbrk. Wird in dieser Tabelle kuenstlich gehalten, um eine_1 Partitionierung durchführen zu können.',
	ART_ID NUMBER(38,0) COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	WUP_ID NUMBER(38,0) COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MENGE_FAKTURA_BME NUMBER(18,3) NOT NULL COMMENT 'Tatsaechlich fakturierte Menge aus fkimg',
	BETRAG_VERRECHNUNG NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Verrechnungswert in Belegwährung aus wavwr. Verschlüsselt. Kann GLD oder Standardpreis sein',
	BETRAG_NETTO NUMBER(18,4) NOT NULL COMMENT 'Nettowert der Fakturaposition in Belegwährung aus netwr (Umsatz zu VKnetto)',
	ZWSUM_1_BETRAG NUMBER(18,4) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Konditionszwischensumme 1 aus dem Kalkulationsschema aus kzwi1',
	BETRAG_MWST NUMBER(18,4) NOT NULL COMMENT 'Steuerbetrag in Belegwaehrung aus mwsbp',
	RETOURE_POS_KZ VARCHAR(1) COLLATE 'en-ci' COMMENT 'Kennzeichnung von Retouren-Positionen mit X. Weitere Kennzeichen moeglich. Aus shkzg',
	BASISMENGE_EINH_ID VARCHAR(3) NOT NULL COMMENT 'Alternative Mengenheinheit für den Artikel_1 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per. Aus meins ',
	VERK_MENGE_EINH_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsmengeneinheit aus vrkme',
	MENGE_FAKTURA_LME NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge in Lagermengeneinheiten aus fklmg',
	AKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichnet, ob der Beleg innerhalb einer Abverkaufsaktion erzeugt wurde. Denormalisiert, angereichert aus Performancegruenden.',
	STEUER_TYP_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Steuertyp (sales_1 tax, federal sales_1 tax,...) aus tatyp. Hier sollte immer der Steuertyp für Mehrwertsteuer enthalten sein.Referenz zur Tabelle l_sap_steuersatz_1',
	SAP_MWST_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Steuerkennzeichen aus taxkm. Referenz zur Tabelle l_sap_steuersatz_1',
	VK_AKTION_BRUTTO NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Aktionsverkaufspreis brutto. Angereichert aus Performancegruenden',
	VK_VOR_AKTION_BRUTTO NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Aktionsverkaufspreis brutto unmittelbar vor der Aktion. Angereichert aus Performancegruenden',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	constraint PK_BESCH_FAKTURA_DET_KMO primary key (MANDANT_ID, FAKTURA_BELEG_ID, FAKTURA_BELEG_POS_ID)
)COMMENT='WWC  - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für KMO. Die dazugehoerigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA_kmo'
;