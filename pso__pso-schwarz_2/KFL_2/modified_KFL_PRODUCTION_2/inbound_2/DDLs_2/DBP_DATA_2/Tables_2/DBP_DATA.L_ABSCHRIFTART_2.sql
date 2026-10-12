--==============================================================
-- Table: l_abschriftart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_abschriftart_2
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:34:01
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ABSCHRIFTART_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   abschriftart_id                     INTEGER     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   abschriftgruppe_id                  INTEGER     COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ABSCHRIFTART PRIMARY KEY (mandant_id, abschriftart_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookup Tabelle der Abschriftenschlüssel';
