--==============================================================
-- Table: flw_trenn_auftrag_det_output_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_trenn_auftrag_det_output_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRENN_AUFTRAG_DET_OUTPUT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   menge_ist_bme                       NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge Ist aus ismen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRENN_AUFTRAG_DET_OUTPUT PRIMARY KEY (auftrag_id, flw_art_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Trennprozess Positionen Output aus spmeat_copo';

