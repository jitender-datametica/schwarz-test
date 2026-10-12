--==============================================================
-- Table: l_pruefgrund_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_pruefgrund_1
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:29:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_PRUEFGRUND_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprachschluessel',
   z_arbeitsgebiet_id                  NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'ID der Arbeitsgebiete. Ein Arbeitsgebiet steht für die Nachrichtenklasse zu der die Nachricht gehört. Aktuell gibt es folgende Arbeitsgebiete: 0 = Z_FRE,  1 = Z_EMON und 4 = EWM. ',
   pruef_id                            VARCHAR(3)       NOT NULL COMMENT 'Arbeitsgebiet. Pruefungsgrund ID',
   pruef_bez                           VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Pruefungsgrundes innerhalb des Arbeitsgebietes.',
   vis_pruef_bez                       VARCHAR(80)      COMMENT 'Sprachabhängige Bezeichnung des Pruefungsgrundes innerhalb des Arbeitsgebietes.. Kann für VIS angepasst werden und von der eigentlichen Bezeichnung abweichen um ein besseres Verständnis der Endanwender innerhalb von VIS zu erzeugen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_PRUEFGRUND PRIMARY KEY (pruef_id, mandant_id, z_arbeitsgebiet_id, spr_id) NOT ENFORCED
)  COMMENT = 'F&R Look-Up für die Pruefgruende der Ausnahmen';
