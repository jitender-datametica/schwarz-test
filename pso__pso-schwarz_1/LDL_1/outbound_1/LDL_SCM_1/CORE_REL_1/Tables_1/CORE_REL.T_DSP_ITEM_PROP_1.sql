CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_dsp_item_prop_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
itempropid BIGNUMERIC(38,0) NOT NULL,
suppliercargowayid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
palfactor BIGNUMERIC(38,0),
pallettypeid BIGNUMERIC(38,0),
palweight BIGNUMERIC(38,10),
palheight BIGNUMERIC(38,0),
doubledeckflag BIGNUMERIC(38,0),
minorderqty BIGNUMERIC(38,0),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
excise_tax_flag BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (dispoid, itempropid) NOT ENFORCED
);