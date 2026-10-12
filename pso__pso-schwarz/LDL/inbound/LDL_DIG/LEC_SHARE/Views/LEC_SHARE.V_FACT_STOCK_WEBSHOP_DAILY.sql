CREATE OR REPLACE VIEW lec_share.v_fact_stock_webshop_daily
AS
SELECT
	*
FROM
	core.t_fact_stock_webshop_daily
;