--==============================================================
-- Table: flw_besch_faktura_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_faktura_det_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_faktura_det_1 (
faktura_beleg_id INTEGER NOT NULL OPTIONS(description='Faktura Belegnummer aus vbeln'),
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition aus posnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
flw_art_id BIGNUMERIC(38,0) OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
vorlage_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Vorlagebelegs aus SAP vgbel'),
menge_faktura_vkme NUMERIC(18,3) NOT NULL
OPTIONS(description='Tatsächlich fakturierte Menge in Verkaufsmengeneinheit aus fkimg'),
menge_faktura_lme NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge in Lagermenheneinheiten aus fklmg'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Einheit der Verkaufsmenge aus vrkme'),
gewicht_netto NUMERIC(18,3) NOT NULL OPTIONS(description='Nettogewicht aus ntgew'),
wert_ek_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Nettowert der Fakturaposition in Belegwährung aus netwr'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
lief_pos_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Positionstyp Vertriebsbeleg z.Bsp. kostenlose Lieferung aus pstyv'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_preisfindung DATE NOT NULL
OPTIONS(description='Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
vk_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Normal-Verkaufspreis Brutto für den Artikel. Denormalisiert, wird im VE-Prozess angereichert aus art_wup_zu_per_1'),
vk_aktion_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Aktions-Verkaufspreis Brutto für den Artikel. Denormalisiert, wird im VE-Prozess angereichert aus Aktionsdaten'),
dat_leist_erstellung DATE OPTIONS(description='Datum der Leistungserstellung aus dem Feld fbuda'),
zwsum_2_betrag NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Konditionszwischensumme 2 aus dem Kalkulationsschema aus kzwi2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (faktura_beleg_id, faktura_beleg_pos_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Fakturabelege Detaildaten aus der SAP-Tabelle vbrp');