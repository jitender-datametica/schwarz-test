--==============================================================
-- Table: l_tms_standorttyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_standorttyp_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_STANDORTTYP_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_standorttyp_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID des Standorttyps. Aus plini.entry',
   tms_standorttyp_lfd_nr              NUMBER(38,0)     NOT NULL COMMENT 'SKey für die Tabelle l_tms_standort_typ im Quellsystem. Aus plini.ini_id',
   tms_standorttyp_bez                 VARCHAR(300)     NOT NULL COMMENT 'Bezeichnung zum Standorttyp (z. B. Frühmarkt, Lieferant, EWM Lager, usw)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_STANDORTTYP PRIMARY KEY (mandant_id, system_id, tms_standorttyp_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Standorten für verschiedene Standorttypen (z. B. Frühmarkt, Lieferant, EWM Lager, usw). Aus der Quelle plini (WANKO)';
