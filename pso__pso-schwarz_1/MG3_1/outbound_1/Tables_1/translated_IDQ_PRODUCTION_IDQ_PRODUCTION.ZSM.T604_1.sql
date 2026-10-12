CREATE OR REPLACE TABLE idq_production_zsm.t604_1 (
mandt STRING(3) NOT NULL,
land1 STRING(3) NOT NULL,
stawn STRING(17) NOT NULL,
bemeh STRING(3),
nihon INTEGER,
impma STRING(3),
minol STRING(1),
PRIMARY KEY (mandt, land1, stawn) NOT ENFORCED
);