--==============================================================
-- Table: l_lager_bewart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lager_bewart
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:29:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGER_BEWART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung.',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   abschriftgruppe_id                  INTEGER     COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_LAGER_BEWART PRIMARY KEY (lager_bewart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP408 LVS - In dieser Tabelle sind die Bewegungsarten innerhalb des Lagers aus der SAP Quelle T156T enthalten';