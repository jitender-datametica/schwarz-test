--==============================================================
-- Table: l_preis_aenderung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_preis_aenderung
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:31:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_PREIS_AENDERUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   preis_aend_grund_id                 INTEGER     NOT NULL COMMENT 'ID des Preisänderungsgrunds, z-Bsp. 12',
   abschriftgruppe_id                  INTEGER     COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_PREIS_AENDERUNG PRIMARY KEY (mandant_id, preis_aend_grund_id) NOT ENFORCED
)  COMMENT = 'WWC - Lookup-Tabelle der Preisänderungsgründe aus der Quelle TWBNT';
