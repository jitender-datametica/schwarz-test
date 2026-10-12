--==============================================================
-- Table: abschriftgruppe_hierarchie_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_hierarchie_zu
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:45:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTGRUPPE_HIERARCHIE_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   abschriftgruppe_id                  INTEGER     NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
   uebergeordnete_abschriftgruppe_id   INTEGER     NOT NULL COMMENT 'ID der übergeordneten Abschriftgruppe in der Hierarchie. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTGRUPPE_HIERARCHIE_ZU PRIMARY KEY (mandant_id, abschriftgruppe_id, uebergeordnete_abschriftgruppe_id) NOT ENFORCED
)  COMMENT = 'Beziehungstabelle zwischen den Abschriftgruppen verschiedener Hierarchieebenen. Eine Abschriftgruppe wird einer in der Hierarchie übergeordneten Abschriftgruppe zugeordnet.';
