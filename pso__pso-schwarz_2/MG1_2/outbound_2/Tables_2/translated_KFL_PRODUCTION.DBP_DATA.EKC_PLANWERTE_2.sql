CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EKC_PLANWERTE_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
HWG_ID INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
WRG_ID STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ABSCHRIFTSBETRAG_WERBUNG_NETTO NUMERIC(18,3) OPTIONS(description='Planwert für Werbeabschriften netto'),
UMSATZ_NETTO_SA NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz SA netto'),
UMSATZ_NETTO_AF NUMERIC(18,3) OPTIONS(description='Planwert für Umsatz AF netto'),
ABSCHRIFTSBETRAG_OHNE_WERBUNG_NETTO NUMERIC(18,3) OPTIONS(description='Planwert Abschriften_2 ohne Werbung netto'),
WA_KALK_NETTO NUMERIC(18,3) OPTIONS(description='Planwert WA Kalk netto'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WA_KALK_NETTO_AF NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto AF'),
WA_KALK_NETTO_SA NUMERIC(18,3) DEFAULT 0 OPTIONS(description='Planwert WA Kalk netto SA')
);