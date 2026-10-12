CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_alr_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
source_system_primary_key STRING(10),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
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