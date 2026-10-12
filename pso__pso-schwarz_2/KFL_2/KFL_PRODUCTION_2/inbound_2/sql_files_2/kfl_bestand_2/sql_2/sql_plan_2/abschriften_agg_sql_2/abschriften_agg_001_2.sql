
DROP TABLE IF EXISTS DBP_ETL.useg_agg_dat_2 ;


CREATE TABLE DBP_ETL.useg_agg_dat_2  (
wup_id              INTEGER NOT NULL,
nb_id               SMALLINT NOT NULL,
dat                 DATE,
mandant_id          BYTEINT NOT NULL
)
;

