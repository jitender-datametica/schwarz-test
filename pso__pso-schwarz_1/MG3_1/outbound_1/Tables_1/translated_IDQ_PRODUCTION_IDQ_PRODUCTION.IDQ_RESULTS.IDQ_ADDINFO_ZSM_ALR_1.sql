CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_alr_1 (
id INTEGER NOT NULL,
test_object_id INTEGER,
source_system_primary_key STRING(10),
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
is_relevant INTEGER,
lieferantennummer STRING(10),
lieferantenname STRING(35),
artikelnummer STRING(18),
artikelbezeichnung STRING(40),
berechtigungsgruppe STRING(4),
artikelart STRING(4),
warenbereich STRING(20),
warengruppe STRING(9),
grunddaten_status STRING(2),
PRIMARY KEY (id) NOT ENFORCED
);