CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_pillar (
mdm_pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key, identifier of the pillar in NFPO source system, alternative item grouping for non food items in addition to the standard grouping based on item families
            CBX: CNT_ITEM.LDL_PILLAR'''),
mdm_pillar_name STRING(100) NOT NULL
OPTIONS(description='''name of the pillar in NFPO source system, alternative item grouping for non food items in addition to the standard grouping based on item families
            CBX: CNT_ITEM.LDL_PILLAR'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_pillar_sid) NOT ENFORCED
) OPTIONS(description='''NFPO alternative item grouping
             CBX: CNT_ITEM.LDL_PILLAR''');