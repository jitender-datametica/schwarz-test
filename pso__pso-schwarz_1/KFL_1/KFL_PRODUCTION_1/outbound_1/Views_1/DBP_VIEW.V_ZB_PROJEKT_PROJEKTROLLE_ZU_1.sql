CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_projektrolle_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Nummer des Projektes aus ePPM. '),
projektrolle_cd OPTIONS(description='Eindeutiger Code der Projektrolle.'), mitarbeiter_name
OPTIONS(description='Name des Mitarbeiters der zum aktuellen Zeitpunkt die Rolle innerhalb des Projektes ausübt.'))
OPTIONS(DESCRIPTION = `Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und alle darin ausgeübten Projektrollen.`)
AS SELECT mandant_id,
 projekt_nr,
 projektrolle_cd,
 mitarbeiter_name
FROM kfl_production_dbp_data.zb_projekt_projektrolle_zu_1;