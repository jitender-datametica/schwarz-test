CREATE OR REPLACE VIEW lec_share.v_fact_product_availability
AS
SELECT
	*
FROM
	core.t_fact_product_availability
;