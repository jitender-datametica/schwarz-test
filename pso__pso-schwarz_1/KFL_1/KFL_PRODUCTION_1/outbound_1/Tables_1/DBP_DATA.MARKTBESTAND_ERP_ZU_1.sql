--==============================================================
-- Table: marktbestand_erp_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: marktbestand_erp_zu_1
   generated from Powerdesigner on Dienstag, 15. November 2022 16:31:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktbestand_erp_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
bestand_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger Schlüssel zur Referenztabelle.'),
ek_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
ek_netto_bnk BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis. Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).'),
vk_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Verkaufspreis netto.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
ek_nettonetto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).'),
einstandspreis BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestand_id) NOT ENFORCED
) OPTIONS(description='AIS - Referenztabelle mit Mengen und Preisen zur marktbestand_erp. Quelle SAP MARD.');