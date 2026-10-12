CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_dsp_locationgroup_1 (
dispoid NUMERIC(10) NOT NULL,
locationsgroupid NUMERIC(10) NOT NULL,
locationgrouptypeid NUMERIC(4) NOT NULL,
locationid NUMERIC(10) NOT NULL,
changedate DATE,
changeuser NUMERIC(10),
locgrouptimelineparentid NUMERIC(10) NOT NULL,
locgrouptimelinedatefrom DATE NOT NULL,
locgrouptimelinedateuntil DATE NOT NULL,
locgrouptimelineownerlocid NUMERIC(4),
locgrouptimelineshort STRING(19),
locgrouptimelinedesc STRING(60),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (dispoid, locationsgroupid) NOT ENFORCED
);