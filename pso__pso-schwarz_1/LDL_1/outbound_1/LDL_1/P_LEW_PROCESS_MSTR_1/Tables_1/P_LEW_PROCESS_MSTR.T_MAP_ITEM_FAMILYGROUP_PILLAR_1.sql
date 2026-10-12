CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_map_item_familygroup_pillar_1 (
src_familygrp_cd STRING(20) NOT NULL,
item_fam_grp_name STRING(100) COLLATE 'und:ci',
pillar_id BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_actual_fg BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (src_familygrp_cd, dwh_valid_from) NOT ENFORCED
);