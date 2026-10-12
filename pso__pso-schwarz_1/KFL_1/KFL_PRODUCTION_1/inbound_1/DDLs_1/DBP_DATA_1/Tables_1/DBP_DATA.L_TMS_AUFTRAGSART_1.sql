--==============================================================
-- Table: l_tms_auftragsart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_auftragsart_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_AUFTRAGSART_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftragsart_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID der Auftragsart. Aus plini.entry',
   tms_auftragsart_lfd_nr              NUMBER(38,0)     NOT NULL COMMENT 'SKey für die Tabelle l_tms_auftragsart_1 im Quellsystem. Aus plini.ini_id',
   tms_auftragsart_bez                 VARCHAR(300)     NOT NULL COMMENT 'Bezeichnung zur Auftragsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_AUFTRAGSART PRIMARY KEY (mandant_id, system_id, tms_auftragsart_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Klassifizierung von TMS Aufträgen mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Auftragsarten. Aus der Quelle plini (WANKO)';
