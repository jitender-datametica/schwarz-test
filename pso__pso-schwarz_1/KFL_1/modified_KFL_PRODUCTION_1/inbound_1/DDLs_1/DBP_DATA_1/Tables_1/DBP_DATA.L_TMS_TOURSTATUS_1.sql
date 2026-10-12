--==============================================================
-- Table: l_tms_tourstatus_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_tourstatus_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_TOURSTATUS_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_tourstatus_id                   INTEGER     NOT NULL COMMENT 'ID des Tourstatus. Aus plini.entry',
   tms_tourstatus_lfd_nr               INTEGER     NOT NULL COMMENT 'SKey für die Tabelle l_tms_tour_status im Quellsystem. Aus plini.ini_id. Aus plini.ini_id',
   tms_tourstatus_bez                  VARCHAR(300)     NOT NULL COMMENT 'Bezeichnung zum Tourstatus. (Verladen, Abgerechnet,…)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_TOURSTATUS PRIMARY KEY (mandant_id, system_id, tms_tourstatus_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Kennzeichnung des Status_1 von Touren mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Tourstadien (z. B. an Abrechnung übertragen, abgerechnet, usw). Aus der Quelle plini (WANKO)';
