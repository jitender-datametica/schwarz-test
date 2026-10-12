CREATE TABLE IF NOT EXISTS ldl_data_etl.t83_formreason_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c83_formtype INTEGER NOT NULL,
c83_reason INTEGER NOT NULL,
c83_shortdesc STRING(5) NOT NULL,
c83_desc STRING(40) NOT NULL,
c83_artgroup INTEGER,
c83_wgroup INTEGER,
c83_moduser STRING(8),
c83_moddate DATETIME,
c83_pcwo_reason INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c83_formtype, c83_reason) NOT ENFORCED
);