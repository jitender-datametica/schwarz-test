CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.erwartete_entwicklung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
sm_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
ksm_id STRING(16) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sortimentsmodul ID für die neuen Sortimentsstufen'),
kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
wrg_id STRING(12) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kl_wg_id BIGNUMERIC(38,0) OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_owg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_uwg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
hwg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Hauptwarengruppe'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0),
ost_basis_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='Listung Ost Basis gepflegt durch ZEK_1'),
ost_gross_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='ost_gross_pflege'),
sued_ost_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='sued_ost_pflege'),
sued_west_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='sued_west_pflege'),
west_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='west_pflege'),
nord_pflege STRING(8) COLLATE 'und:ci' OPTIONS(description='nord_pflege'),
umsatz_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
absatz_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
rohertrag_hr NUMERIC(18,4) NOT NULL
OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Tabelle für Zwischenablage der Werte für die erwartete Entwicklung');