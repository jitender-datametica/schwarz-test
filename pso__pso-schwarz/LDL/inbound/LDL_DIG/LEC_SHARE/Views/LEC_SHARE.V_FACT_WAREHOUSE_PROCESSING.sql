CREATE OR REPLACE VIEW lec_share.v_fact_warehouse_processing
AS
SELECT
	*
FROM
	core.t_fact_warehouse_processing
;