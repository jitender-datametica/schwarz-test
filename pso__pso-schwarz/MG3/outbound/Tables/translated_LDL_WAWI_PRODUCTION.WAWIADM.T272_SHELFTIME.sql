CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t272_shelftime (
c272_shelft_nr INTEGER NOT NULL,
c272_shelft_desc STRING(15),
c272_shelft_lt STRING(2),
c272_shelft_calc INTEGER,
scn INTEGER DEFAULT 0,
PRIMARY KEY (c272_shelft_nr) NOT ENFORCED
);