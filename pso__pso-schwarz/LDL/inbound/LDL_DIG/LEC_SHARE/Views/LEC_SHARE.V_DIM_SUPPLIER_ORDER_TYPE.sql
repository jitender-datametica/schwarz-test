CREATE OR REPLACE VIEW lec_share.v_dim_supplier_order_type
AS
SELECT
	*
FROM
	core.t_dim_supplier_order_type
;