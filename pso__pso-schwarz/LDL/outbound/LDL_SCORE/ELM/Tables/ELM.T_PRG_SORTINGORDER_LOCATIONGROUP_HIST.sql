CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_sortingorder_locationgroup_hist (
sortingtype STRING(250),
position BIGNUMERIC(38,0),
locationgroupid BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);