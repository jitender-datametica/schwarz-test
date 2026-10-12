--==============================================================
-- Table: transportation_unit_kosten
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_kosten
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:34:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_kosten (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum ( (hier: nur Speditionen))'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_diesel NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten für Diesel'),
betrag_strom NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten für Strom'),
betrag_gas NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten für Gas'),
betrag_maut NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten für Maut'),
betrag_kuehlung NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten für Kühlung'),
betrag_sonstiges NUMERIC(11,3) OPTIONS(description='zusätzliche Kosten weitere'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
)
OPTIONS(description='Table for additional costs per transportation unit that are not included in WANKO billing data - main source is excel files, manually uploaded in Sharepoint');