CREATE OR REPLACE VIEW lec_share.v_dim_warehouse_task_status
AS
SELECT
	*
FROM
	core.t_dim_warehouse_task_status
;