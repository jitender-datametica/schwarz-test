--==============================================================
-- Table: kampagne_kampagne_kunde_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kampagne_kunde_zu_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_kampagne_kunde_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagnendefinition, der der Kunde zugeordnet ist. Ein Kunde kann mehreren Kampagnen und eine_2 Kampagne_2 mehreren Kunden zugeordnet sein (Many-to-Many-Beziehung).'),
kampagne_kunde_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung des Kunden, welcher der Empfänger der von einer Kampagne_2 gesendeten Nachrichten ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_id, kampagne_kunde_id) NOT ENFORCED
)
OPTIONS(description='Zuordnungtabelle von Kunden zu bestimmten Kampagnendefinitionen. Sie dient dazu, die Zielgruppe einer Kampagne_2 zu definieren und die Interaktionen einzelner Kunden mit der Journey zu verfolgen.');