CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_kostenprognose_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'),
warengruppe_cd STRING(20) NOT NULL OPTIONS(description='Code der Warengruppe'),
dat_version DATE NOT NULL OPTIONS(description='Datum der Version der Kostenprognose'),
version_nr STRING(20) NOT NULL OPTIONS(description='Versionsnummer der Kostenprognose'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_kostenprognose NUMERIC(29,5) NOT NULL OPTIONS(description='Betrag der Kostenprognose in Landeswährung'),
betrag_zek NUMERIC(29,5)
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea NUMERIC(29,5)
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, warengruppe_cd, dat_version) NOT ENFORCED
) OPTIONS(description='Enthält Kostenprognosen für die Warengruppen pro Gewerk im jeweiligen Projekt.');