CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_wrk (
client_id INTEGER NOT NULL,
wh_loc_sid INTEGER NOT NULL,
st_loc_sid INTEGER NOT NULL,
orig_store_nr INTEGER,
dat_formdate_from DATE NOT NULL,
dat_formdate_until DATE NOT NULL,
load_in_progress_fg INTEGER DEFAULT 1 NOT NULL
);