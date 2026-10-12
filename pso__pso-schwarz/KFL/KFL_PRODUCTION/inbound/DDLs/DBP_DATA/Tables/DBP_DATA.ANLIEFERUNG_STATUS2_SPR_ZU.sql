--==============================================================
-- Table: anlieferung_status2_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_status2_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLIEFERUNG_STATUS2_SPR_ZU (
   anlieferung_status2_id              NUMBER(38,0)     NOT NULL COMMENT 'ID des Pünktlichkeitsstatus (Wert zwischen 1 und 5)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   anlieferung_status2_bez             VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Pünktlichkeitsstatusz.Bsp. "Zeitfenster verfallen"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLIEFERUNG_STATUS2_SPR_ZU PRIMARY KEY (anlieferung_status2_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS -Sprachabhängige Bezeichnungen des Pünktlichkeitsstatus einer Mercareon-Buchung. Keine SST, wird initial im DWH gepflegt';

