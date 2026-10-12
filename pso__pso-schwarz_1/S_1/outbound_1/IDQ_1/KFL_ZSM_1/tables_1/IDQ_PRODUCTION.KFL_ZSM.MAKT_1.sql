CREATE OR REPLACE TABLE kfl_zsm.makt_1 (
mandt STRING(3) NOT NULL,
matnr STRING(40) NOT NULL,
spras STRING(1) NOT NULL,
maktx STRING(40),
maktg STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, matnr, spras) NOT ENFORCED
);