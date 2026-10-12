create or replace TABLE KFL_PRODUCTION.DBP_DATA.EKC_PLANWERTE_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	ABSCHRIFTSBETRAG_WERBUNG_NETTO NUMBER(18,3) COMMENT 'Planwert für Werbeabschriften netto',
	UMSATZ_NETTO_SA NUMBER(18,3) COMMENT 'Planwert für Umsatz SA netto',
	UMSATZ_NETTO_AF NUMBER(18,3) COMMENT 'Planwert für Umsatz AF netto',
	ABSCHRIFTSBETRAG_OHNE_WERBUNG_NETTO NUMBER(18,3) COMMENT 'Planwert Abschriften_2 ohne Werbung netto',
	WA_KALK_NETTO NUMBER(18,3) WITH MASKING POLICY #unknown_policy COMMENT 'Planwert WA Kalk netto',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WA_KALK_NETTO_AF NUMBER(18,3) DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Planwert WA Kalk netto AF',
	WA_KALK_NETTO_SA NUMBER(18,3) DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Planwert WA Kalk netto SA'
);