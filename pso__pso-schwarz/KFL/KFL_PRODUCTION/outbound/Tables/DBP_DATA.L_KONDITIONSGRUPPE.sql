--==============================================================
-- Table: l_konditionsgruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_konditionsgruppe
   generated from Powerdesigner on Freitag, 27. Oktober 2023 13:37:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_konditionsgruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
konditionsgruppe_id STRING(10) NOT NULL OPTIONS(description='Eindeutiger Schlüssel der Konditionsgruppen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, konditionsgruppe_id) NOT ENFORCED
)
OPTIONS(description='RPW - Lookuptabelle für die Gruppierung der Konditionsarten. Diese Tabelle wird per Initialisierung befüllt.');