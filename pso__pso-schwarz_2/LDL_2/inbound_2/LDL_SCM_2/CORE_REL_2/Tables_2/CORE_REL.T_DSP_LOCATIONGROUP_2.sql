CREATE TABLE CORE_REL.T_DSP_LOCATIONGROUP_2 (
dispoid NUMBER(10) NOT NULL,
locationsgroupid NUMBER(10) NOT NULL,
locationgrouptypeid NUMBER(4) NOT NULL,
locationid NUMBER(10) NOT NULL,
changedate DATE,
changeuser NUMBER(10),
locgrouptimelineparentid NUMBER(10) NOT NULL,
locgrouptimelinedatefrom DATE NOT NULL,
locgrouptimelinedateuntil DATE NOT NULL,
locgrouptimelineownerlocid NUMBER(4),
locgrouptimelineshort VARCHAR(19),
locgrouptimelinedesc VARCHAR(60),
DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
PRIMARY KEY (DISPOID,LOCATIONSGROUPID)
);