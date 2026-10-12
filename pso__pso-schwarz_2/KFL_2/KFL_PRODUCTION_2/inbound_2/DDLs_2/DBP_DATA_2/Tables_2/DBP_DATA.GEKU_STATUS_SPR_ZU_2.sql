--==============================================================
-- Table: geku_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_status_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_STATUS_SPR_ZU_2 (
   geku_status_id                      NUMBER(38,0)     NOT NULL COMMENT 'eindeutige ID des Ticketstatus (erledigt, eskaliert, in Arbeit, überfällig)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_status_bez                     VARCHAR(60)      COMMENT 'Bezeichnung des Ticketstatus z.Bsp. (erledigt, eskaliert, in Arbeit, überfällig)',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_STATUS_SPR_ZU PRIMARY KEY (geku_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen des GEKU Ticketstatus';
