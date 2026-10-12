CREATE TABLE IF NOT EXISTS ldl_data_etl.t007_descriptions (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c007_id INTEGER NOT NULL,
c007_type STRING(25) NOT NULL,
c007_code STRING(25) NOT NULL,
c007_desc STRING(80),
c007_readonly INTEGER,
c007_moduser STRING(8),
c007_moddate DATETIME,
c007_eks_link INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c007_code, c007_type) NOT ENFORCED
);