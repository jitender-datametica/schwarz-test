CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_fact_exchange_rate (
from_curr_cd STRING(3) COLLATE 'und:ci' NOT NULL,
to_curr_cd STRING(3) COLLATE 'und:ci' NOT NULL,
exchange_rate_type_cd STRING(5) COLLATE 'und:ci' NOT NULL,
active_from_dt DATE NOT NULL,
active_to_dt DATE NOT NULL,
active_fg BIGNUMERIC(38,0) NOT NULL,
bus_year BIGNUMERIC(38,0) NOT NULL,
exchange_rate NUMERIC(9,5) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY active_fg;