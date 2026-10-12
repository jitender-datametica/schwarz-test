CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_buyer_role_type_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
role_type_cd STRING(20) NOT NULL
OPTIONS(description='type code of the role a NFPO user can be assigned to for a specific item_1 in the range selection process'),
role_type STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='name of the role a user can be assigned to for a specific item_1 in the range selection process'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (role_type_cd) NOT ENFORCED
)
OPTIONS(description='NFPO user role type;             Static reference data:             1: EKL: Purchasing Manager             2: SE: Category Manager (Hardware only)             3: KVW: Contract Manager             4: KP: Contract Approver');