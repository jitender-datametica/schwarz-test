CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_t173_gintasks (
client_id BIGNUMERIC(38,0) NOT NULL,
c173_taskid STRING(100) NOT NULL,
wh_rcv_cnt_task_sid BIGNUMERIC(38,0),
c173_gingate BIGNUMERIC(38,0),
c173_gatetypeid BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
c173_create_date STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);