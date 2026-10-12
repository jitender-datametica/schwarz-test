CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_1 (
src_familygrp_cd STRING(20),
item_fam_grp_name STRING(100) COLLATE 'und:ci',
pillar_id BIGNUMERIC(38,0),
pillar_name STRING(100) COLLATE 'und:ci',
main_pillar_id BIGNUMERIC(38,0),
main_pillar_name STRING(20) COLLATE 'und:ci'
);