CREATE OR REPLACE VIEW lec_share.v_fact_currency_exchange_rate
AS
SELECT
	*
FROM
	core.t_fact_currency_exchange_rate
;