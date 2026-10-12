--==============================================================
-- Table: abschriftgruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_1
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:43:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTGRUPPE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   abschriftgruppe_id                  INTEGER     NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.',
   abschriftgruppe_ebene_kz            VARCHAR(100)     NOT NULL COMMENT 'Kennzeichen der Ebene innerhalb der Abschriftgruppen-Hierarchie.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTGRUPPE PRIMARY KEY (mandant_id, abschriftgruppe_id) NOT ENFORCED
)  COMMENT = 'Tabelle beinhaltet Abschriftgruppen jeglicher Hierarchie-Ebenen. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.';
