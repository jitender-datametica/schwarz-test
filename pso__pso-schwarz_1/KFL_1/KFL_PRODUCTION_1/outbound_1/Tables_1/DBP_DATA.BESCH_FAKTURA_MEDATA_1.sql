--==============================================================
-- Table: besch_faktura_medata_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_medata_1
   generated from Powerdesigner on Montag, 21. Juli 2025 05:50:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_medata_1 (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
faktura_markt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='bezieht sich auf den empfangenden wup_1'),
dat_faktura DATE NOT NULL
OPTIONS(description='Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='in diesem Fall der beliefernde wup_1 - Medatalager'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
zwsum_3_betrag NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto  bzw. EK-Aktion_1 netto vermindert um die Reklapauschale.'),
menge_fakturiert NUMERIC(18,3)
OPTIONS(description='Fakturierte Menge in Verkaufseinheiten, Displays werden als 1 gerechnet'),
ek_netto_bnk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'),
ek_mep NUMERIC(18,4) OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'),
logistikkostenzuschlag NUMERIC(18,4)
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).'),
betrag_ek_mep_vor_fwu BIGNUMERIC(38,5)
OPTIONS(description='Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, faktura_markt, dat_faktura) NOT ENFORCED
) CLUSTER BY dat_faktura
OPTIONS(description='TP2 AIS - Fakturadaten aus Medata - Lägern (nicht in SAP)');