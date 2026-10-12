--==============================================================
-- Table: wup_entfernungsmatrix_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_entfernungsmatrix_1
   generated from Powerdesigner on Freitag, 12. Januar 2024 12:39:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_entfernungsmatrix_1 (
wup_id_a BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
wup_id_b BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
nb_id_a BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer'),
nb_id_b BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer'),
mandant_id_a BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mandant_id_b BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
distanz_fahrweg_km NUMERIC(11,3) DEFAULT 0 NOT NULL
OPTIONS(description='Entfernung in auf Straßen zurückzulegenden Kilometern zwischen den zwei Standorten A und B'),
dauer_fahrzeit_min BIGNUMERIC(38,0)
OPTIONS(description='Dauer der Fahrzeit in Minuten zwischen den zwei Standorten A und B'),
maut_km NUMERIC(11,3) OPTIONS(description='Anzahl mautpflichtiger Kilometer von DISTANZ_FAHRWEG_KM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id_a, wup_id_b, nb_id_a, nb_id_b, mandant_id_a, mandant_id_b) NOT ENFORCED
) OPTIONS(description='Entfernung (Fahrkilometer) zwischen zwei beliebigen Standorten');