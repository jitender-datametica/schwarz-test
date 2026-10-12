DROP TABLE IF EXISTS szd_production_etl.t_item_gtin;
CREATE OR REPLACE TABLE szd_production_etl.t_item_gtin (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
uom_sid INTEGER NOT NULL,
src_lfnum STRING(20) NOT NULL,
uom_cd STRING(20),
gtin STRING(20),
gtin_type_cd STRING(20),
main_gtin_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (item_sid, uom_sid, src_lfnum) NOT ENFORCED
) CLUSTER BY client_id;