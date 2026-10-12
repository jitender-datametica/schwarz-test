CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_fahrzeug (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_fahrzeug_id
OPTIONS(description='ID des Fahrzeugs (Fahrzeugnummer). Aus plfaz.nr'), tms_fahrzeug_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_fahrzeug im Quellsystem. Aus plfaz.faz_id'), tms_fahrzeugtyp_id
OPTIONS(description='Fahrzeugtyp'), tms_fahrzeug_trailer_id OPTIONS(description='Hängernummer 1'), spediteur_tms_gp_id
OPTIONS(description='ID des tms_gp, welcher hier als Spediteur auftrifft'), spediteur_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Spediteur auftrifft. immer\""S\"" (Typ = S Spediteur)'),
verbrauch_pro_100km OPTIONS(description='Verbrauch pro 100 Km'), tms_treibstoff_id
OPTIONS(description='Treibstoffart (Diesel, Benzin, usw.)')) AS SELECT mandant_id,
 system_id,
 tms_fahrzeug_id,
 tms_fahrzeug_lfd_nr,
 tms_fahrzeugtyp_id,
 tms_fahrzeug_trailer_id,
 spediteur_tms_gp_id,
 spediteur_tms_gp_typ_cd,
 verbrauch_pro_100km,
 tms_treibstoff_id
FROM kfl_production_dbp_data.tms_fahrzeug;