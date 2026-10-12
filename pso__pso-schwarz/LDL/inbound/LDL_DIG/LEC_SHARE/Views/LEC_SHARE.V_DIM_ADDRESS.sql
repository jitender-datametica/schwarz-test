CREATE OR REPLACE VIEW lec_share.v_dim_address
AS
SELECT
	*
FROM
	core.t_dim_address
;