CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_item_rel_type_1 (
item_rel_type_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Code: immutable representation of relation type;'),
item_rel_type STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Description: updatable description.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH')
)
OPTIONS(description='Item_1 relation type             Reference data:             item_1 relation types in the NFPO item_1 planning and creation system:              PRED1: Predecessor 1             PRED2: Predecessor 2             REF_PRED: Reference Predecessor             REF_MKT: Reference Item_1 in other market');