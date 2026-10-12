--==============================================================
-- Table: abschriftgruppe_hierarchie_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_hierarchie_zu
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:45:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftgruppe_hierarchie_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'),
uebergeordnete_abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der übergeordneten Abschriftgruppe in der Hierarchie. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftgruppe_id, uebergeordnete_abschriftgruppe_id) NOT ENFORCED
)
OPTIONS(description='Beziehungstabelle zwischen den Abschriftgruppen verschiedener Hierarchieebenen. Eine Abschriftgruppe wird einer in der Hierarchie übergeordneten Abschriftgruppe zugeordnet.');