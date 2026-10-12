CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t219_itemexduty_2 (
c219_itemnr STRING(18) NOT NULL,
c219_exdutymain INTEGER NOT NULL,
c219_exdutysub INTEGER NOT NULL,
c219_exdutyvol NUMERIC(5,3),
c219_mod_date DATETIME,
c219_mod_user STRING(8),
c219_validfrom DATETIME NOT NULL,
c219_validuntil DATETIME,
scn INTEGER DEFAULT 0,
PRIMARY KEY (c219_exdutymain, c219_exdutysub, c219_itemnr, c219_validfrom) NOT ENFORCED
);