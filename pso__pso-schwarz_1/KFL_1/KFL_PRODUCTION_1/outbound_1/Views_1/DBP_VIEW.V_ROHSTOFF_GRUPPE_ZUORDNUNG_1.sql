CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_gruppe_zuordnung_1 (rohstoff_gruppe_typ_id
OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'), rohstoff_gruppe_name
OPTIONS(description='Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'), zugeordnete_rohstoff_gruppe_typ_id
OPTIONS(description='ID der zugeordnete Rohstoffgruppe.'), zugeordnete_rohstoff_gruppe_name
OPTIONS(description='Name der zugeordneten Rohstoffsgruppe.'), rohstoff_gruppe_zuordnungstyp_id
OPTIONS(description='ID der Zurodnungstyp zwischen Rohstoffgruppen.'), dat_gueltig_von
OPTIONS(description='Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
dat_gueltig_bis
OPTIONS(description='Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN ROHSTOFFSGRUPPEN.`) AS SELECT rohstoff_gruppe_typ_id,
 rohstoff_gruppe_name,
 zugeordnete_rohstoff_gruppe_typ_id,
 zugeordnete_rohstoff_gruppe_name,
 rohstoff_gruppe_zuordnungstyp_id,
 dat_gueltig_von,
 dat_gueltig_bis
FROM kfl_production_dbp_data.rohstoff_gruppe_zuordnung_1;