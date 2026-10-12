--==============================================================
-- Table: best_beleg_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_beleg_status_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_BELEG_STATUS_SPR_ZU_2 (
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   best_beleg_status_id                VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel zur Identifikation eines Belegstatus der Bestellung.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   best_beleg_status_bez               VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung für den Bestellbelegstatus',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_BELEG_STATUS_SPR_ZU PRIMARY KEY (system_id, mandant_id, best_beleg_status_id) NOT ENFORCED
)  COMMENT = 'RPW - Sprachabhängige Kurzbezeichnungen  für den Status_2 eines Bestellbeleges. Für jede DWH Sprache = 1 wird ein Eintrag per Initialisierung hinterlegt.';

