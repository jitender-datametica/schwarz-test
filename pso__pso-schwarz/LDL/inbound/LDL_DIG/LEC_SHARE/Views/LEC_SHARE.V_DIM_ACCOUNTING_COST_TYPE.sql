CREATE OR REPLACE VIEW lec_share.v_dim_accounting_cost_type
AS
SELECT
	*
FROM
	core.t_dim_accounting_cost_type
;