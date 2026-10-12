--==============================================================
-- Table: l_tms_beschraenkung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_beschraenkung_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_BESCHRAENKUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_beschraenkung_id                INTEGER     NOT NULL COMMENT 'ID der Beschränkung (Nummer der Beschränkung). Aus plbes.besnr',
   tms_beschraenkung_lfd_nr            INTEGER     NOT NULL COMMENT 'SKey für die Tabelle l_tms_beschraenkung_2 im Quellsystem. Aus plbes.bes_id',
   tms_beschraenkung_bez               VARCHAR(50)      NOT NULL COMMENT 'Bezeichnung zur Beschränkung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_BESCHRAENKUNG PRIMARY KEY (mandant_id, system_id, tms_beschraenkung_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Verwaltung von Einschränkungen für Touren und Geschäftspartnern, z. B. nur Früh- und/oder Spätanlieferung. Aus der Quelle plbes (WANKO)';
