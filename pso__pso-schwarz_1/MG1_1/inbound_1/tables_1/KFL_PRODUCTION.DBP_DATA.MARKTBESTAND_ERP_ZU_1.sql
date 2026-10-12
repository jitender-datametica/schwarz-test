create or replace TABLE KFL_PRODUCTION.DBP_DATA.MARKTBESTAND_ERP_ZU_1 (
	BESTAND_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Schlüssel zur Referenztabelle.',
	EK_NETTO NUMBER(38,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).',
	EK_NETTO_BNK NUMBER(38,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis. Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).',
	VK_NETTO NUMBER(38,4) NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto.',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	EK_NETTONETTO NUMBER(38,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).',
	EINSTANDSPREIS NUMBER(38,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	constraint PK_MARKTBESTAND_ERP_ZU primary key (MANDANT_ID, BESTAND_ID)
)COMMENT='AIS - Referenztabelle mit Mengen und Preisen zur marktbestand_erp. Quelle SAP MARD.'
;