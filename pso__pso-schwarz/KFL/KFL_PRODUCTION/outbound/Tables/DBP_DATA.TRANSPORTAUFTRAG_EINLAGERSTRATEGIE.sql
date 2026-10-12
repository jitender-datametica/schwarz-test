CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportauftrag_einlagerstrategie (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transport_beleg_id INTEGER NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
entfernung_horz_1 NUMERIC(9,2) DEFAULT 0 NOT NULL,
aufschlag_gangwechsel_1 NUMERIC(9,2) DEFAULT 0 NOT NULL,
aufschlag_hoehe_1 NUMERIC(9,2) DEFAULT 0 NOT NULL,
lagerplatz_typ_aufschlag_1 NUMERIC(9,2) DEFAULT 0 NOT NULL,
entfernung_horz_2 NUMERIC(9,2) DEFAULT 0 NOT NULL,
aufschlag_gangwechsel_2 NUMERIC(9,2) DEFAULT 0 NOT NULL,
aufschlag_hoehe_2 NUMERIC(9,2) DEFAULT 0 NOT NULL,
lagerplatz_typ_aufschlag_2 NUMERIC(9,2) DEFAULT 0 NOT NULL,
palettensteuerung_indiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
alternative_griffzone_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);