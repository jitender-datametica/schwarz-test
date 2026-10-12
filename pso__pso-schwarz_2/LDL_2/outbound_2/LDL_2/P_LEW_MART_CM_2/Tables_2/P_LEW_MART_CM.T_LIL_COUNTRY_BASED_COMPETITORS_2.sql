CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.t_lil_country_based_competitors_2 (
country_cd STRING(10) NOT NULL OPTIONS(description='Country_2 Code'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_2 Identification Number'),
retailer_name STRING(100) OPTIONS(description='Retailer name of competitors'),
retailer_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Retailer Identification Number'),
competitor_rank_name STRING(100) OPTIONS(description='Rank name of competitors'),
competitor_rank_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sequential Identification number of competitors based on ranks'),
active_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='This field indicates if the record is active or not by 1 or 0.'),
PRIMARY KEY (client_id, retailer_id, competitor_rank_id) NOT ENFORCED
) OPTIONS(description='Mapping table of Cross Country_2 Competitors for Category Management');