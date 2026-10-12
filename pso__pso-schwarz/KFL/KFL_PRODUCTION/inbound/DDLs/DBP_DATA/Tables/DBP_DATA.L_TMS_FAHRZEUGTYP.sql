--==============================================================
-- Table: l_tms_fahrzeugtyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_fahrzeugtyp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_FAHRZEUGTYP (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_fahrzeugtyp_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID des Fahrzeugtyps (Fahrzeugtypnummer). Aus plfaztyp.faztyp_nr',
   tms_fahrzeugtyp_lfd_nr              NUMBER(38,0)     NOT NULL COMMENT 'SKey für die Tabelle l_tms_fahrzeugtyp im Quellsystem. Aus plfaztyp.faztyp_id',
   tms_fahrzeugtyp_bez                 VARCHAR(20)      NOT NULL COMMENT 'Bezeichnung zum Fahrzeugtyp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_FAHRZEUGTYP PRIMARY KEY (mandant_id, system_id, tms_fahrzeugtyp_id) NOT ENFORCED
)  COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Fahrzeugen für verschiedene Fahrzeugtypen, z. B. Zugmaschine, Auflieger, LKW, Anhänger. Aus der Quelle plfaztyp (WANKO)';
