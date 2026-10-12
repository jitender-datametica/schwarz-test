CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t058_discounts (
c058_discountcode INTEGER NOT NULL,
c058_percent INTEGER NOT NULL,
c058_moddate DATETIME,
c058_moduser STRING(8),
scn INTEGER DEFAULT 0,
PRIMARY KEY (c058_discountcode) NOT ENFORCED
);