--==============================================================
-- Table: rohstoff_rohstoff_gruppe_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_rohstoff_gruppe_zu
   generated from Powerdesigner on Donnerstag, 25. September 2025 18:01:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohstoff_rohstoff_gruppe_zu (
rohstoff_nr STRING(20) NOT NULL OPTIONS(description='Mintecs Interne ID des Rohstoffs.'),
rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'),
rohstoff_gruppe_name STRING(100) NOT NULL OPTIONS(description='Name der Gruppe eines Rohstoffs nach Gruppierungstyp.'),
rohstoff_blend_kfl_cd STRING(100)
OPTIONS(description='Ein Blend kann einem Rohstoff zugeordnet werden. Diese Zuordnung ist über die Subkategorie des Rohstoffs eindeutig'),
rohstoff_cluster_id BIGNUMERIC(38,0)
OPTIONS(description='Rohstoffe können für eine Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_nr, rohstoff_gruppe_typ_id, rohstoff_gruppe_name) NOT ENFORCED
) OPTIONS(description='Zuordnungstabelle zwischen Rohstoff und Rohstoffsgruppe nach Gruppierungstyp.');