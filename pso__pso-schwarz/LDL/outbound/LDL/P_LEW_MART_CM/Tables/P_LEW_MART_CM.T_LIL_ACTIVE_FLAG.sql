CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.t_lil_active_flag (
active_fg INTEGER NOT NULL,
active_fg_desc STRING(50) NOT NULL,
active_fg_desc_en STRING(50) NOT NULL,
PRIMARY KEY (active_fg) NOT ENFORCED
) OPTIONS(description='THE DIMENSIONAL TABLE FOR THE ACTIVE FLAG ATTRIBUTE');