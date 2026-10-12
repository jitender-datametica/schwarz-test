CREATE OR REPLACE TABLE kfl_production_dbp_data.ekc_planwerte_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
hwg_id INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abschriftsbetrag_werbung_netto NUMERIC(18,3) OPTIONS(description='Planwert für Werbeabschriften netto'),
umsatz_netto_sa NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz SA netto'),
umsatz_netto_af NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz AF netto'),
abschriftsbetrag_ohne_werbung_netto NUMERIC(18,3) OPTIONS(description='Planwert Abschriften_1 ohne Werbung netto'),
wa_kalk_netto NUMERIC(18,3) OPTIONS(description='Planwert WA Kalk netto'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wa_kalk_netto_af NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto AF'),
wa_kalk_netto_sa NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto SA')
);