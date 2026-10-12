CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tupel_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
tupel_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung eines Tupels für EK SORT'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='Tupelbezeichnungen in Landessprache, Quelle der Tupel ist Tabelle tupel_mat_1');