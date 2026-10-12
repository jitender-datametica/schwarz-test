--==============================================================
-- Table: amx_hauptbereich_mcx_invers_bereich_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_hauptbereich_mcx_invers_bereich_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_hauptbereich_mcx_invers_bereich_zu_2 (
hauptbereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id'),
invers_ber_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bereich ID aus Maritz'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hauptbereich_id, invers_ber_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle Hauptbereich (AMX) zu inversem Bereich (MXC). Verwendung: um die Bereich Sprachtabelle aus Maritz für die Audimex Hauptbereiche zu nutzen');