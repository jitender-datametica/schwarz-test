CREATE OR REPLACE TABLE kfl_production_dbp_data.marktbestand_erp_zu_1 (
bestand_id INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel zur Referenztabelle.'),
ek_netto NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis. Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
vk_netto NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Verkaufspreis netto.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
ek_nettonetto NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
einstandspreis NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
PRIMARY KEY (mandant_id, bestand_id) NOT ENFORCED
) OPTIONS(description='AIS - Referenztabelle mit Mengen und Preisen zur marktbestand_erp. Quelle SAP MARD.');