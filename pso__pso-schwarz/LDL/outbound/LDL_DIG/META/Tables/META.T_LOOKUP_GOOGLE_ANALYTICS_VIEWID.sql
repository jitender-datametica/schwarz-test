CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_google_analytics_viewid (
view_id BIGNUMERIC(38,0),
country STRING(50),
is_web_or_app STRING(50),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);