CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_risiko_bewertung (
risiko_bewertung_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Risikobereichs aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
risiko_wert_von INTEGER NOT NULL
OPTIONS(description='Risikowert Intervall Beginn aus dem Quellfeld risk_from. Darstellung als dreistelliger Wert, z.Bsp. 112'),
risiko_wert_bis INTEGER NOT NULL
OPTIONS(description='Risikowert Intervall Ende aus dem Quellfeld risk_to. Darstellung als dreistelliger Wert, z.Bsp. 112'),
risiko_farbe STRING(20) COLLATE 'und:ci' OPTIONS(description='Farbcode aus dem Quellfeld background_color'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (risiko_bewertung_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='Audimex - Übersetzung der Risikowerte in Farben aus der Quelltabelle rca_risk_translat');