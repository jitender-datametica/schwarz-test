CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t277_unitfactors_2 (
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
PRIMARY KEY (c277_id) NOT ENFORCED
);