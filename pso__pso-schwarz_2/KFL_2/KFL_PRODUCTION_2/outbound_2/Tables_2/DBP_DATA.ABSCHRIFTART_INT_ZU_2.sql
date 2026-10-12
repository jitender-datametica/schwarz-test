--==============================================================
-- Table: abschriftart_int_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_int_zu_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_int_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
abschriftart_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id, abschriftart_int_id) NOT ENFORCED
)
OPTIONS(description='VIS - Mapping-Tabelle nationale Abschrftenarten zu der iEinheitlichen Abschriftenarten KL international');