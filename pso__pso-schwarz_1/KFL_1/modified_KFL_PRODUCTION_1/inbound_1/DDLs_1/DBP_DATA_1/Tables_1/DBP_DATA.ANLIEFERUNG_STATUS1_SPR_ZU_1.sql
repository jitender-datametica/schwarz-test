--==============================================================
-- Table: anlieferung_status1_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_status1_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLIEFERUNG_STATUS1_SPR_ZU_1 (
   anlieferung_status1_id              INTEGER     NOT NULL COMMENT 'ID des Erfassungsstatus (Wert zwischen 1 und 3)',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   anlieferung_status1_bez             VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Erfassungsstatus, z.Bsp. "Fehlerfassung durch VZ"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLIEFERUNG_STATUS1_SPR_ZU PRIMARY KEY (anlieferung_status1_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen des Erfassungstatus einer Mercareon-Buchung. Keine SST, wird initial im DWH gepflegt';

