--==============================================================
-- Table: amx_teilbereich_mcx_invers_kategorie_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_teilbereich_mcx_invers_kategorie_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_teilbereich_mcx_invers_kategorie_zu_1 (
invers_kat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kategorie ID aus Maritz'),
teilbereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (invers_kat_id, teilbereich_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle Teilbereich (AMX) zu interser Kategorie (MCX). Verwendung: um die Kategorie Sprachtabelle aus Maritz für die Audimex Teilbereiche zu nutzen');