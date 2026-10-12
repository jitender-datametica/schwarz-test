--==============================================================
-- Table: abschriftgruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_2
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:43:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftgruppe_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.'),
abschriftgruppe_ebene_kz STRING(100) NOT NULL
OPTIONS(description='Kennzeichen der Ebene innerhalb der Abschriftgruppen-Hierarchie.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftgruppe_id) NOT ENFORCED
)
OPTIONS(description='Tabelle beinhaltet Abschriftgruppen jeglicher Hierarchie-Ebenen. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.');