CREATE OR REPLACE VIEW lec_share.v_dim_warehouse_order_line_process_status
AS
SELECT
	*
FROM
	core.t_dim_warehouse_order_line_process_status
;