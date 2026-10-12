CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_dsp_order (
dispoid BIGNUMERIC(38,0) NOT NULL,
itempropid BIGNUMERIC(38,0) NOT NULL,
daywhid BIGNUMERIC(38,0) NOT NULL,
lorryno BIGNUMERIC(38,0) NOT NULL,
versionid BIGNUMERIC(38,0) NOT NULL,
corrtypeid BIGNUMERIC(38,0),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
order_reference STRING(250),
wawipurchaseorderid STRING(250),
order_number BIGNUMERIC(38,0),
order_position BIGNUMERIC(38,0),
orderquantity BIGNUMERIC(38,10),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (dispoid, itempropid, daywhid, lorryno, versionid) NOT ENFORCED
);