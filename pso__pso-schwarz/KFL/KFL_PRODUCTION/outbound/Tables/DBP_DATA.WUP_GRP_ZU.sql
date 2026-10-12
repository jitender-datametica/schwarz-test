CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_grp_zu (
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wupgrp_id BIGNUMERIC(38,0) NOT NULL,
referenziert BIGNUMERIC(38,0),
referenzierend BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);