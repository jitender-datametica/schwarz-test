--==============================================================
-- Table: flw_pruefmerkmal_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefmerkmal_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRUEFMERKMAL_SPR_ZU_2 (
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   stp_merkmal_id                      NUMBER(38,0)     NOT NULL COMMENT 'Stammprüfmerkmal aus mkmnr',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   merkmal_bez                         VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Merkmals. Quelle ist sortfeld für Landessprache, kurztext für deutsche Übersetzung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRUEFMERKMAL_SPR_ZU PRIMARY KEY (werk_id, stp_merkmal_id, spr_id, mandant_id, system_id) NOT ENFORCED
)  COMMENT = 'FLW - Bezeichnungen zum Prüfmerkmalsstamm aus qpmk';

