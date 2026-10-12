CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t200_pricegroup_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c200_groupnr BIGNUMERIC(30,10) NOT NULL,
c200_groupdesc STRING(30),
c200_priority BIGNUMERIC(30,10) NOT NULL,
c200_warehouse BIGNUMERIC(30,10) NOT NULL,
c200_storenr BIGNUMERIC(30,10) NOT NULL,
c200_editedby STRING(8),
c200_lastedited DATETIME,
c200_datefrom DATETIME NOT NULL,
c200_dateto DATETIME,
c200_add_vatcode INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);