CREATE OR REPLACE TABLE idq_production_zsm.t604_2 (
mandt STRING(3) NOT NULL,
land1 STRING(3) NOT NULL,
stawn STRING(17) NOT NULL,
bemeh STRING(3),
nihon NUMERIC(1,0),
impma STRING(3),
minol STRING(1),
PRIMARY KEY (mandt, land1, stawn) NOT ENFORCED
);