CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t406_suppaymcond_1 (
c406_krednr STRING(7) NOT NULL,
c406_datefrom DATETIME NOT NULL,
c406_posnr INTEGER NOT NULL,
c406_std_flag INTEGER,
c406_inv_ent_date INTEGER,
c406_days INTEGER,
c406_starttype INTEGER,
c406_daysafter INTEGER,
c406_discount NUMERIC(10,3),
c406_rebate NUMERIC(10,3),
c406_mod_user STRING(8),
c406_mod_date DATETIME,
c406_goodsin_date INTEGER,
scn INTEGER DEFAULT 0,
c406_discount_days INTEGER,
PRIMARY KEY (c406_krednr, c406_datefrom, c406_posnr) NOT ENFORCED
);