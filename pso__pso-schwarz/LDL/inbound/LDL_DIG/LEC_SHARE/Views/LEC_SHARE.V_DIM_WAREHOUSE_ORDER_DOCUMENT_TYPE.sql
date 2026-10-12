CREATE OR REPLACE VIEW lec_share.v_dim_warehouse_order_document_type
AS
SELECT
	*
FROM
	core.t_dim_warehouse_order_document_type
;