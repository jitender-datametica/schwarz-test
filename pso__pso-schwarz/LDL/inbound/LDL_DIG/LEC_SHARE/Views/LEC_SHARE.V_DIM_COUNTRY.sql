CREATE OR REPLACE VIEW lec_share.v_dim_country
AS
SELECT
	*
FROM
	core.t_dim_country
;