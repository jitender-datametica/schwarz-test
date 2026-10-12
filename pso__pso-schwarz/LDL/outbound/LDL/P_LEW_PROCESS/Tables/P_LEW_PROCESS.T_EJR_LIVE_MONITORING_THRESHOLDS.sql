CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_ejr_live_monitoring_thresholds (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client'),
red_store_threshold_pct BIGNUMERIC(38,5)
OPTIONS(description='a percentage benchmark, for the proportion of red stores, above which the client assumes a red status'),
orange_store_threshold_pct BIGNUMERIC(38,5)
OPTIONS(description='a percentage benchmark, for the proportion of orange stores, above which the client assumes an orange status'),
PRIMARY KEY (client_id) NOT ENFORCED
)
OPTIONS(description='Monitoring actions based on client-level live ejr receipt delays can be configured on a per client basis in this table');