--==============================================================
-- Table: abschriftart_abschriftgrp_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_abschriftgrp_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_abschriftgrp_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Merkmal zur Gruppierung der Abschriften'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, abschriftgruppe_id) NOT ENFORCED
) OPTIONS(description='VIS - Gruppierung von Abschriftenarten');