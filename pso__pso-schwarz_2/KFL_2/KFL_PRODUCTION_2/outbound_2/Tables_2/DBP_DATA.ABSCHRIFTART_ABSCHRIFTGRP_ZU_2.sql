--==============================================================
-- Table: abschriftart_abschriftgrp_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_abschriftgrp_zu_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_abschriftgrp_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Merkmal zur Gruppierung der Abschriften_2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, abschriftgruppe_id) NOT ENFORCED
) OPTIONS(description='VIS - Gruppierung von Abschriftenarten');