--==============================================================
-- Table: belos_adresse
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_adresse
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_ADRESSE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   belos_adresse_id                    VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel zur Identifikation einer Belos Adresse',
   land_id                             VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen',
   adress_name                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Name der Belos Adresse',
   adress_name_zusatz                  VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Namenszusatz der Belos Adresse',
   strasse                             VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Strasse der Belos Adresse',
   be_entlade_stelle                   VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Be-/Entladestelle der Belos Adresse',
   plz                                 VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Postleitzahl',
   ansprechpartner                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Ansprechpartner der Belos Adresse. Compress blank',
   ort                                 VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Ort der Belos Adresse',
   spedition_fg                        INTEGER     NOT NULL COMMENT 'Flag - der Wert 1 bedeutet, dass es sich um eine Spedition handelt',
   belos_standort_typ_id               INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID des Belos_standorttyps. Wird im DWH vergeben',
   belos_adresse_num_id                INTEGER     NOT NULL COMMENT 'numerischer Wert für die belos_adresse. Bei Märkten/Lägern ist hier die wup_id hinterlegt, ansonsten ein negativer Wert. Wird für Join-Zwecke benötigt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_ADRESSE PRIMARY KEY (mandant_id, belos_adresse_id) NOT ENFORCED
)  COMMENT = 'LIS - Stammdaten fuer die Belos Adressen. Die Eintraege haben keine Referenz zu der DWH Stammdatentabelle GP weil Belos keine Kreditorennummer liefert.';

