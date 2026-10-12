CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t007_descriptions (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
id INTEGER NOT NULL,
type_ STRING(25) NOT NULL,
code STRING(25) NOT NULL,
`desc` STRING(80),
readonly INTEGER,
moduser STRING(8),
moddate DATETIME,
eks_link INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);