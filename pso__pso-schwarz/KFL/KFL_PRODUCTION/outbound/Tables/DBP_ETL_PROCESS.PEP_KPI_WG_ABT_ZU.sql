CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.pep_kpi_wg_abt_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
pep_kpi_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der KPI - Treiberkennzahl für Personaleinsatzplanung'),
dayforce_abt_bez STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Abteilungsbezeichnung Dayforce HCM (PEP)'),
pep_kpi_bez STRING(40)
OPTIONS(description='Bezeichnung der KPI - Treiberkennzahl für Personaleinsatzplanung (SQL-Name für die Ausführung des entsprechend SQL)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS - Steuerungstabelle für die Datenlieferung an Dayforce HCM (PEP) - Tabelle soll abgelöst werden');