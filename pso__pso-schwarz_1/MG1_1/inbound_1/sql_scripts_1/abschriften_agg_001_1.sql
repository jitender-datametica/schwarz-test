
DROP TABLE IF EXISTS DBP_ETL.useg_agg_dat_1 ;


CREATE TABLE DBP_ETL.useg_agg_dat_1  (
wup_id              INTEGER NOT NULL,
nb_id               SMALLINT NOT NULL,
dat                 DATE,
mandant_id          BYTEINT NOT NULL
)
;

