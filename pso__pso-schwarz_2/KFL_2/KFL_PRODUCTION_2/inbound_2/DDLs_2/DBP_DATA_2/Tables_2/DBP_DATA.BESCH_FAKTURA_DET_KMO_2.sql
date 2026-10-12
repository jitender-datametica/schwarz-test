--==============================================================
-- Table: besch_faktura_det_kmo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_det_kmo_2
   generated from Powerdesigner on Donnerstag, 29. September 2022 10:57:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_DET_KMO_2 CLUSTER BY (
     MANDANT_ID,
     DAT_FAKTURA_SAP 
)(
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   faktura_beleg_id                    NUMBER(18,0)    NOT NULL COMMENT 'Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln',
   faktura_beleg_pos_id                NUMBER(38,0)    NOT NULL COMMENT 'Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr',
   dat_faktura_sap                     DATE            NOT NULL COMMENT 'Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck. Aus fkdat vbrk. Wird in dieser Tabelle kuenstlich gehalten, um eine_2 Partitionierung durchführen zu können.',
   art_id                              NUMBER(38,0)    COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   wup_id                              NUMBER(38,0)    COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   menge_faktura_bme                   NUMBER(18,3)    NOT NULL COMMENT 'Tatsaechlich fakturierte Menge aus fkimg',
   betrag_verrechnung                  NUMBER(18,4)    COMMENT 'Verrechnungswert in Belegwährung aus wavwr. Verschlüsselt. Kann GLD oder Standardpreis sein',
   betrag_netto                        NUMBER(18,4)    NOT NULL COMMENT 'Nettowert der Fakturaposition in Belegwährung aus netwr (Umsatz zu VKnetto)',
   zwsum_1_betrag                      NUMBER(18,4)    NOT NULL COMMENT 'Konditionszwischensumme 1 aus dem Kalkulationsschema aus kzwi1',
   betrag_mwst                         NUMBER(18,4)    NOT NULL COMMENT 'Steuerbetrag in Belegwaehrung aus mwsbp',
   retoure_pos_kz                      VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Kennzeichnung von Retouren-Positionen mit X. Weitere Kennzeichen moeglich. Aus shkzg',
   basismenge_einh_id                  VARCHAR(3)      NOT NULL COMMENT 'Alternative Mengenheinheit für den Artikel_2 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per. Aus meins ',
   verk_menge_einh_id                  VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Verkaufsmengeneinheit aus vrkme',
   menge_faktura_lme                   NUMBER(18,3)    NOT NULL COMMENT 'Fakturamenge in Lagermengeneinheiten aus fklmg',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Kennzeichnet, ob der Beleg innerhalb einer Abverkaufsaktion erzeugt wurde. Denormalisiert, angereichert aus Performancegruenden.',
   steuer_typ_id                       VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Steuertyp (sales_2 tax, federal sales_2 tax,...) aus tatyp. Hier sollte immer der Steuertyp für Mehrwertsteuer enthalten sein.Referenz zur Tabelle l_sap_steuersatz_2',
   sap_mwst_id                         VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Steuerkennzeichen aus taxkm. Referenz zur Tabelle l_sap_steuersatz_2',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   vk_aktion_brutto                    NUMBER(9,2)     DEFAULT 0 NOT NULL COMMENT 'Aktionsverkaufspreis brutto. Angereichert aus Performancegruenden',
   vk_vor_aktion_brutto                NUMBER(9,2)     DEFAULT 0 NOT NULL COMMENT 'Aktionsverkaufspreis brutto unmittelbar vor der Aktion. Angereichert aus Performancegruenden',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_DET_KMO PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'WWC  - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für KMO. Die dazugehoerigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA_kmo';
