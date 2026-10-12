CREATE TABLE IF NOT EXISTS ldl_data_etl.t277_unitfactors (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c277_id INTEGER NOT NULL,
c277_unit STRING(10),
c277_baseunit STRING(10),
c277_basefactor BIGNUMERIC(30,10),
c277_intunit STRING(10),
c277_intfactor BIGNUMERIC(30,10),
c277_validfrom BIGNUMERIC(30,10),
c277_validuntil BIGNUMERIC(30,10),
c277_eks_link INTEGER,
c277_base_family INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c277_id) NOT ENFORCED
);