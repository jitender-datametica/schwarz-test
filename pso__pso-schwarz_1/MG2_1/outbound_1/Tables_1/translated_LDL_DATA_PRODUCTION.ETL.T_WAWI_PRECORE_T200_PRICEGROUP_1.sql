CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t200_pricegroup_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c200_groupnr BIGNUMERIC(29,10) NOT NULL,
c200_groupdesc STRING(30),
c200_priority BIGNUMERIC(29,10) NOT NULL,
c200_warehouse BIGNUMERIC(29,10) NOT NULL,
c200_storenr BIGNUMERIC(29,10) NOT NULL,
c200_editedby STRING(8),
c200_lastedited DATETIME,
c200_datefrom DATETIME NOT NULL,
c200_dateto DATETIME,
c200_add_vatcode INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);