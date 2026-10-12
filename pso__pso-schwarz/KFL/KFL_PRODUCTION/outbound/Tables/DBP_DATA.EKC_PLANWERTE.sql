--==============================================================
-- Table: ekc_planwerte
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ekc_planwerte
   generated from Powerdesigner on Wednesday, April 6, 2022 10:41:22 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ekc_planwerte (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen handelt'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abschriftsbetrag_werbung_netto NUMERIC(18,3) OPTIONS(description='Planwert für Werbeabschriften netto'),
umsatz_netto_sa NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz SA netto'),
umsatz_netto_af NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz AF netto'),
abschriftsbetrag_ohne_werbung_netto NUMERIC(18,3) OPTIONS(description='Planwert Abschriften ohne Werbung netto'),
wa_kalk_netto NUMERIC(18,3) OPTIONS(description='Planwert WA Kalk netto'),
wa_kalk_netto_af NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto AF'),
wa_kalk_netto_sa NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto SA'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, hwg_id, arthiertyp_id, dat) NOT ENFORCED
) OPTIONS(description='EK INTEGER  - COI bereitgestellte Planwerte für das EK Cockpit');