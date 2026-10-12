--==============================================================
-- Table: l_abschriftart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_abschriftart_2
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:34:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_abschriftart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
abschriftgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftart_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle der Abschriftenschlüssel');