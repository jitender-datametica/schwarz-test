CREATE OR REPLACE TABLE kfl_production_dbp_data.tupel_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
matching_id INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
kjwo_update INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
tupel_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung eines Tupels für EK SORT'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='Tupelbezeichnungen in Landessprache, Quelle der Tupel ist Tabelle tupel_mat');