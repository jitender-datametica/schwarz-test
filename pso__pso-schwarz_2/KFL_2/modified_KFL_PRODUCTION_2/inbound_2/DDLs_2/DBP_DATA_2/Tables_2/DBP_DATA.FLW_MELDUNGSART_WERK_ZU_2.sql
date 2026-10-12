--==============================================================
-- Table: flw_meldungsart_werk_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_meldungsart_werk_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MELDUNGSART_WERK_ZU_2 (
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   meldungsart_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Meldungsart aus qmart',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MELDUNGSART_WERK_ZU PRIMARY KEY (werk_id, meldungsart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - QM: Zuordnung Werk zu Qualitätsmeldungsart aus zfw_wrk_qmeldung';

