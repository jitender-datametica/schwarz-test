CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_budget_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
budget_typ_cd STRING(20) NOT NULL
OPTIONS(description='Code des Budget Typs. (A1 = Budget bei Freigabe, A2 = Aktuelles Budget)'),
budget_version_name STRING(100) OPTIONS(description='Name der aktuellen Version des Budgets.'),
dat_budget DATE OPTIONS(description='Datum an dem das Budget geplant wurde.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_budget NUMERIC(29,5) NOT NULL OPTIONS(description='Wert des Budgets für den einzelnen Budgettyp pro Gewerk.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, gewerk_id, budget_typ_cd) NOT ENFORCED
)
OPTIONS(description='Enthält die geplanten Budgets für die einzelnen Gewerke eines Projektes aus den Zentralbereichen');