CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_dsp_item_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
suppliercargowayid BIGNUMERIC(38,0) NOT NULL,
itemid BIGNUMERIC(38,0) NOT NULL,
itemidint BIGNUMERIC(38,0),
itemidnat BIGNUMERIC(38,0),
shortdescnat STRING(250),
shortdescint STRING(250),
amount BIGNUMERIC(38,0),
itemcontent BIGNUMERIC(38,10),
measureunitid BIGNUMERIC(38,0),
packagetypeid BIGNUMERIC(38,0),
collicontent BIGNUMERIC(38,10),
timeout BIGNUMERIC(38,0),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
order_gtin STRING(250),
vet_flag BIGNUMERIC(38,0),
nf_flag BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (dispoid, itemid, suppliercargowayid) NOT ENFORCED
);