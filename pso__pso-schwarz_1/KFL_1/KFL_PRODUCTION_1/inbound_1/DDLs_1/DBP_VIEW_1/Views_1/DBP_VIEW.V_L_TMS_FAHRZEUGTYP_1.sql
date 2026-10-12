CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_FAHRZEUGTYP_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_fahrzeugtyp_id                       COMMENT 'ID des Fahrzeugtyps (Fahrzeugtypnummer). Aus plfaztyp.faztyp_nr'
  ,tms_fahrzeugtyp_lfd_nr                   COMMENT 'SKey für die Tabelle l_tms_fahrzeugtyp_1 im Quellsystem. Aus plfaztyp.faztyp_id'
  ,tms_fahrzeugtyp_bez                      COMMENT 'Bezeichnung zum Fahrzeugtyp'
)
COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Fahrzeugen für verschiedene Fahrzeugtypen, z. B. Zugmaschine, Auflieger, LKW, Anhänger. Aus der Quelle plfaztyp (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_fahrzeugtyp_id,
        tms_fahrzeugtyp_lfd_nr,
        tms_fahrzeugtyp_bez

FROM DBP_DATA.L_TMS_FAHRZEUGTYP_1 ;