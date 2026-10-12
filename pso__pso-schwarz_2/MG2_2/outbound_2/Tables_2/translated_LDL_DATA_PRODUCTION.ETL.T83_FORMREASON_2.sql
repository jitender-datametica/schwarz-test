CREATE OR REPLACE TABLE ldl_data_production_etl.t83_formreason_2 (
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
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c83_formtype, c83_reason) NOT ENFORCED
);