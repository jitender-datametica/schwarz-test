CREATE OR REPLACE VIEW lec_share.v_dim_cost_center
AS
SELECT
	*
FROM
	core.t_dim_cost_center
;