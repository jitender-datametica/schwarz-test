CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t405_suppayment_1 (
c405_krednr STRING(7) NOT NULL,
c405_datefrom DATETIME NOT NULL,
c405_dateto DATETIME,
c405_paymenttype INTEGER,
c405_extrakrednr STRING(7),
c405_inv_ent_date INTEGER,
c405_mod_user STRING(8),
c405_mod_date DATETIME,
c405_goodsin_date INTEGER,
scn INTEGER DEFAULT 0,
PRIMARY KEY (c405_krednr, c405_datefrom) NOT ENFORCED
);