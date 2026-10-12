CREATE OR REPLACE TABLE ldl_data_production_etl.t277_unitfactors_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c277_id INTEGER NOT NULL,
c277_unit STRING(10),
c277_baseunit STRING(10),
c277_basefactor BIGNUMERIC(29,10),
c277_intunit STRING(10),
c277_intfactor BIGNUMERIC(29,10),
c277_validfrom BIGNUMERIC(29,10),
c277_validuntil BIGNUMERIC(29,10),
c277_eks_link INTEGER,
c277_base_family INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c277_id) NOT ENFORCED
);