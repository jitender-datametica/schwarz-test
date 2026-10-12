--==============================================================
-- Table: tms_fahrzeug_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_fahrzeug_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_FAHRZEUG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_fahrzeug_id                     VARCHAR(20)      NOT NULL COMMENT 'ID des Fahrzeugs (Fahrzeugnummer). Aus plfaz.nr',
   tms_fahrzeug_lfd_nr                 INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_fahrzeug_1 im Quellsystem. Aus plfaz.faz_id',
   tms_fahrzeugtyp_id                  INTEGER     NOT NULL COMMENT 'Fahrzeugtyp',
   tms_fahrzeug_trailer_id             VARCHAR(20)      COMMENT 'Hängernummer 1',
   spediteur_tms_gp_id                 VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Spediteur auftrifft',
   spediteur_tms_gp_typ_cd             VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Spediteur auftrifft. immer "S" (Typ = S Spediteur)',
   verbrauch_pro_100km                 NUMBER(29,2)      COMMENT 'Verbrauch pro 100 Km',
   tms_treibstoff_id                   INTEGER     COMMENT 'Treibstoffart (Diesel, Benzin, usw.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_FAHRZEUG PRIMARY KEY (mandant_id, system_id, tms_fahrzeug_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält Informationen über die Fahrzeuge im System, einschließlich Fahrzeugtyp, Spediteur, Anhänger und Verbrauchsinformationen. Es handelt sich um konkrete Fahrzeuge (bei KFL vmtl. eher generische Objekte wie z. B. "Elektro-LKW" oder "LKW Diesel 40t"). Aus der Quelle plfaz (WANKO)';
