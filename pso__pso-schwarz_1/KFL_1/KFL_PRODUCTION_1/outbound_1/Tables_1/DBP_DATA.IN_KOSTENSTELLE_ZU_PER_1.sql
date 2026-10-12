CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_kostenstelle_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
kostenstelle_node_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
kostenstelle_parent_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
kostenstelle_child_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
kostenstelle_next_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
kostenstelle_level_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
kostenstelle_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);