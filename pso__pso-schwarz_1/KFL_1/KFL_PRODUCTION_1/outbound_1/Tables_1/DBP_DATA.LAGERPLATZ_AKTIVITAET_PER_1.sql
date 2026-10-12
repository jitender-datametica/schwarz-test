CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerplatz_aktivitaet_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
lagerplatz_id STRING(18) NOT NULL OPTIONS(description='Lagerplatz'),
aktivitaet_id STRING(4) NOT NULL OPTIONS(description='Aktivität'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE OPTIONS(description='Gültig bis'),
lfd_nr BIGNUMERIC(38,0) OPTIONS(description='Fortl. Nummer'),
aktivitaetsbereich_id STRING(4) OPTIONS(description='Aktivitätsbereich'),
lagertyp_id STRING(4) OPTIONS(description='Lagertyp'),
lagerbereich_id STRING(4) OPTIONS(description='Lagerbereich'),
gang_id BIGNUMERIC(38,0) OPTIONS(description='Gang'),
sort_nr BIGNUMERIC(38,0) OPTIONS(description='Sortierreihenfolge'),
entfernung_start BIGNUMERIC(38,0) OPTIONS(description='Entfernung zum Start'),
gang_laenge BIGNUMERIC(38,0) OPTIONS(description='Länge'),
folge_gang_id BIGNUMERIC(38,0) OPTIONS(description='Folgegang'),
entfernung_folgegang BIGNUMERIC(38,0) OPTIONS(description='Entfernung zum Folgegang'),
konsolidierungsgruppe_id STRING(10) OPTIONS(description='Konsolidierungsgruppe'),
org_aktivitaetsbereich_id STRING(4) OPTIONS(description='Aktivitätsbereich'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerplätze für Bereiche und Aktivitäten');