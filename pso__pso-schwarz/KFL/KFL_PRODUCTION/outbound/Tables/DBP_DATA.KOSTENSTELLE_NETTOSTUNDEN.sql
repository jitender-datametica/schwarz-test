CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenstelle_nettostunden (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
hr_objekt_bez_kurz STRING(10) DEFAULT '-1        ' NOT NULL,
dat DATE NOT NULL,
hr_objekt_bereich_id BIGNUMERIC(38,0) NOT NULL,
stunden_netto NUMERIC(9,2) DEFAULT 0 NOT NULL,
stunden_netto_plan NUMERIC(9,2) DEFAULT 0 NOT NULL,
stunden_netto_markt_pep NUMERIC(9,2) DEFAULT 0 NOT NULL,
quelle_id BIGNUMERIC(38,0),
planwert_quelle_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);