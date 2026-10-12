CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_pos_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_id INTEGER NOT NULL,
hu_typ_id BIGNUMERIC(38,0),
anz_pack_hilfsmittel BIGNUMERIC(38,0) DEFAULT 0,
de_egalisiert_fg BIGNUMERIC(38,0) NOT NULL,
verp_menge_einh_id STRING(3),
art_id BIGNUMERIC(38,0),
lagerort_id STRING(4) COLLATE 'und:ci',
menge_handling_kolli NUMERIC(9,3),
lief_beleg_id INTEGER,
lief_beleg_pos_id INTEGER,
kj_lief_beleg BIGNUMERIC(38,0),
charge_id STRING(10) OPTIONS(description='chargennummer           '),
dat_mhd DATE OPTIONS(description='verfallsdatum oder mindesthaltbarkeitsdatum     '),
handling_unit_id_child INTEGER OPTIONS(description='untergeordnete handling unit       '),
hu_inhalt_ident STRING(20) OPTIONS(description='identifikation des handling-unit-inhalts   '),
verp_menge_bme NUMERIC(9,3) OPTIONS(description='verpackte basismenge in der handling unit position '),
td_update TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
) CLUSTER BY mandant_id;