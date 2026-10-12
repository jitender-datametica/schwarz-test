--==============================================================
-- Table: art_auslieferungsgruppe_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_auslieferungsgruppe_per
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:41:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_auslieferungsgruppe_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
auslieferungsgruppe_id STRING(4) NOT NULL OPTIONS(description='Auslieferungsgruppe'),
dat_von DATE NOT NULL OPTIONS(description='gültig von'),
dat_bis DATE NOT NULL OPTIONS(description='gültig bis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='This table is used to define the Auslieferungsgruppe for an article and date');