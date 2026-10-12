CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MARKTBESTAND_ERP_ZU_1 (
BESTAND_ID INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel zur Referenztabelle.'),
EK_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
EK_NETTO_BNK NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis. Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
VK_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Verkaufspreis netto.'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
EK_NETTONETTO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
EINSTANDSPREIS NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
PRIMARY KEY (MANDANT_ID, BESTAND_ID) NOT ENFORCED
) OPTIONS(description='AIS - Referenztabelle mit Mengen und Preisen zur marktbestand_erp. Quelle SAP MARD.');