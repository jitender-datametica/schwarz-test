--==============================================================
-- Table: abschriftgruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_spr_zu_1
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:47:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftgruppe_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.'),
abschriftgruppe_bez STRING(100) OPTIONS(description='Sprachabhängige Bezeichnung der Abschriftgruppe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, abschriftgruppe_id) NOT ENFORCED
) OPTIONS(description='Sprachtabelle der Abschriftgruppen.');