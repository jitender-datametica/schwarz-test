--==============================================================
-- Table: wg_auslieferungsgruppe_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_auslieferungsgruppe_per_1
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:40:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_auslieferungsgruppe_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1'),
auslieferungsgruppe_id STRING(4) NOT NULL OPTIONS(description='Auslieferungsgruppe'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe'),
sortimentslistenart_id STRING(1) NOT NULL OPTIONS(description='Sortimentslistenart'),
dat_von DATE NOT NULL OPTIONS(description='gültig von'),
dat_bis DATE NOT NULL OPTIONS(description='gültig bis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='This table is used to define the Auslieferungsgruppe for an item_1-group (wg) and date');