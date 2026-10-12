CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_store_geo (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
longitude NUMERIC(9,6) NOT NULL,
latitude NUMERIC(9,6) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);