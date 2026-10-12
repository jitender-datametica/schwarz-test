CREATE OR REPLACE VIEW lec_share.v_dim_accounted_module
AS
SELECT
	*
FROM
	core.t_dim_accounted_module
;