CREATE OR REPLACE TABLE kfl_production_dbp_data.inventur_plan (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gj INTEGER NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
inventurart_id INTEGER NOT NULL OPTIONS(description='SRS: Inventurart (international nicht identisch)'),
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_vk_netto NUMERIC(29,4) OPTIONS(description='Geplanter Umsatz je OWG und Markt'),
betrag_vk_netto_inventur_diff_plan NUMERIC(29,4)
OPTIONS(description='Geplante Inventurdifferenz je OWG, Inventurart und Markt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, gj, inventurart_id, owg_id) NOT ENFORCED
) OPTIONS(description='Planwerte für Umsatz und Inventurverluste je OWG und Inventurart pro Geschäftsjahr und Markt.');