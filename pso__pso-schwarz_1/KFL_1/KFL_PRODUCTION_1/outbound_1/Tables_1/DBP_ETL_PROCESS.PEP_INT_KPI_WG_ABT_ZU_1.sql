CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.pep_int_kpi_wg_abt_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
pep_kpi_kz STRING(40) NOT NULL
OPTIONS(description='Eindeutiges Kennzeichen der KPI - Treiberkennzahl für Personaleinsatzplanung'),
dayforce_abt_bez STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Abteilungsbezeichnung Dayforce HCM (PEP)'),
pep_kpi_bez STRING(40)
OPTIONS(description='Bezeichnung der KPI - Treiberkennzahl für Personaleinsatzplanung (SQL-Name für die Ausführung des entsprechend SQL)'),
aktiv_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Aktiv-Flag für KPI (1=aktiv)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS - Steuerungstabelle für die Datenlieferung an Dayforce HCM (PEP) für alle KL-Länder (inkl. KMO) - kpi_kz anstatt kpi_id');