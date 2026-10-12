CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_GRUPPE_ZUORDNUNG_1 (
   rohstoff_gruppe_typ_id                   COMMENT 'ID des Gruppierungstyps eines Rohstoffs.'
  ,rohstoff_gruppe_name                     COMMENT 'Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'
  ,zugeordnete_rohstoff_gruppe_typ_id       COMMENT 'ID der zugeordnete Rohstoffgruppe.'
  ,zugeordnete_rohstoff_gruppe_name         COMMENT 'Name der zugeordneten Rohstoffsgruppe.'
  ,rohstoff_gruppe_zuordnungstyp_id         COMMENT 'ID der Zurodnungstyp zwischen Rohstoffgruppen.'
  ,dat_gueltig_von                          COMMENT 'Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'
  ,dat_gueltig_bis                          COMMENT 'Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'
)
COMMENT = 'Zuordnungstabelle zwischen Rohstoffsgruppen.'
 AS 
    SELECT 
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        zugeordnete_rohstoff_gruppe_typ_id,
        zugeordnete_rohstoff_gruppe_name,
        rohstoff_gruppe_zuordnungstyp_id,
        dat_gueltig_von,
        dat_gueltig_bis

FROM DBP_DATA.ROHSTOFF_GRUPPE_ZUORDNUNG_1 ;