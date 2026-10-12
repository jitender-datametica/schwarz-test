CREATE OR REPLACE TABLE kfl_production_dbp_data.retail_company_1 (
ext_system_name STRING(50) NOT NULL
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'),
ext_retail_company_id INTEGER NOT NULL OPTIONS(description='ID des Einzelhändlers im externen System.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
retail_company_code STRING(50) NOT NULL
OPTIONS(description='Code des Einzelhändlers, wie vom Quellsystem bereitgestellt.'),
retail_company_name STRING(50) NOT NULL OPTIONS(description='Name des Marktes.'),
competitor_fg INTEGER NOT NULL
OPTIONS(description='Flag, das angibt, ob es sich um ein Kaufland-Unternehmen (Wert 0) oder einen Mitbewerber (Wert 1) handelt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ext_system_name, ext_retail_company_id) NOT ENFORCED
) OPTIONS(description='Die Tabelle enthält 1 Zeile pro Markt. Einschließlich Kaufland und Wettbewerber.');