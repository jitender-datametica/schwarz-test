--==============================================================
-- Table: l_preis_aenderung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_preis_aenderung
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:31:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_preis_aenderung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
preis_aend_grund_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Preisänderungsgrunds, z-Bsp. 12'),
abschriftgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, preis_aend_grund_id) NOT ENFORCED
) OPTIONS(description='WWC - Lookup-Tabelle der Preisänderungsgründe aus der Quelle TWBNT');