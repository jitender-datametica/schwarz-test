CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_gruppe_1 (rohstoff_gruppe_typ_id
OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'), rohstoff_gruppe_name
OPTIONS(description='Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'), rohstoff_gruppe_kurz_name
OPTIONS(description='Abkürzung der Rohstoffsgruppe name.'))
OPTIONS(DESCRIPTION = `GRUPPE_1 EINES ROHSTOFFS NACH GRUPPIERUNGSTYP.`) AS SELECT rohstoff_gruppe_typ_id,
 rohstoff_gruppe_name,
 rohstoff_gruppe_kurz_name
FROM kfl_production_dbp_data.rohstoff_gruppe_1;