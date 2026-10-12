CREATE OR REPLACE VIEW lec_share.v_fact_product_price_warehouse
AS
SELECT
	*
FROM
	core.t_fact_product_price_warehouse
;