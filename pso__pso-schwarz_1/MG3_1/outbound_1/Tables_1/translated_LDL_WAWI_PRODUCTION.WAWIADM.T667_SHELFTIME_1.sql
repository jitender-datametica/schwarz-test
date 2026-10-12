CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t667_shelftime_1 (
c667_st_wh INTEGER NOT NULL,
c667_st_wh_sign INTEGER NOT NULL,
c667_st_store INTEGER,
c667_st_store_sign INTEGER,
c667_st_customer INTEGER,
c667_st_customer_sign INTEGER,
c667_moduser STRING(8),
c667_modedate DATETIME,
scn INTEGER DEFAULT 0,
c667_st_type STRING(1) NOT NULL,
PRIMARY KEY (c667_st_wh, c667_st_wh_sign, c667_st_type) NOT ENFORCED
);