create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTBEW_WG_SUM_2 cluster by (
     MANDANT_ID,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	DAT DATE NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
	UMSATZ_BRUTTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz incl. Mehrwertsteuerbetrag\n            ',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag\n            ',
	UMSATZ_WRG VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR',
	UMSATZ_BRUTTO_KONZ NUMBER(18,4) NOT NULL COMMENT 'Umsatz brutto in der Konzernwährung',
	UMSATZ_NETTO_KONZ NUMBER(18,4) NOT NULL COMMENT 'Umsatz netto in der Konzernwährung',
	QUELLE NUMBER(38,0) DEFAULT 0,
	MENGE NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	UMRECHNUNGSKURS_HIST NUMBER(38,5) NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 ',
	constraint PK_ARTBEW_WG_SUM primary key (MANDANT_ID, NB_ID, ARTHIERTYP_ID, WG_ID, DAT, WUP_ID, BEWART_ID)
)COMMENT='TP1 MIS - Aggregationstabelle artbew_2 auf Ebene Warengruppe/Markt/Datum - MULTISET'
;
