CREATE OR REPLACE VIEW lec_share.v_dim_currency_exchange_rate_type
AS
SELECT
	*
FROM
	core.t_dim_currency_exchange_rate_type
;