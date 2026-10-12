CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_rohstoff_gruppe_zu_2 (rohstoff_nr
OPTIONS(description='Mintecs Interne ID des Rohstoffs.'), rohstoff_gruppe_typ_id
OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'), rohstoff_gruppe_name
OPTIONS(description='Name der Gruppe_2 eines Rohstoffs nach Gruppierungstyp.'), rohstoff_blend_kfl_cd
OPTIONS(description='Ein Blend kann einem Rohstoff_2 zugeordnet werden. Diese Zuordnung ist über die Subkategorie des Rohstoffs eindeutig'),
rohstoff_cluster_id
OPTIONS(description='Rohstoffe können für eine_2 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN ROHSTOFF_2 UND ROHSTOFFSGRUPPE NACH GRUPPIERUNGSTYP.`) AS SELECT
 rohstoff_nr,
 rohstoff_gruppe_typ_id,
 rohstoff_gruppe_name,
 rohstoff_blend_kfl_cd,
 rohstoff_cluster_id
FROM kfl_production_dbp_data.rohstoff_rohstoff_gruppe_zu_2;