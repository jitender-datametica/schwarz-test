--==============================================================
-- Table: cpr_phase_spr_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_phase_spr_zu_per_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_PHASE_SPR_ZU_PER_2 (
   projekt_phase_id                    VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projektphase aus xlcphase',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   cpr_phase_bez                       VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Beschreibung der Projektphase',
   cpr_phase_langtext                  VARCHAR(320)     COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext zur Projektphase',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_PHASE_SPR_ZU_PER PRIMARY KEY (projekt_phase_id, dat_von, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Projektphasen';

