CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.TUPEL_SPR_ZU_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
MATCHING_ID INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
KJWO_UPDATE INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
TUPEL_BEZ STRING(200) NOT NULL OPTIONS(description='Bezeichnung eines Tupels für EK SORT'),
TD_INSERT TIMESTAMP,
TD_UPDATE TIMESTAMP
) OPTIONS(description='Tupelbezeichnungen in Landessprache, Quelle der Tupel ist Tabelle tupel_mat_1');