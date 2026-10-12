
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_wawi_org_all_store_reloc_act_1 (
move_to_st_loc_sid INTEGER NOT NULL,
st_loc_sid INTEGER NOT NULL,
store_desc STRING(50) COLLATE 'und:ci',
client_id INTEGER NOT NULL,
orig_store_nr INTEGER NOT NULL,
move_fg INTEGER NOT NULL
);