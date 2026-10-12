CREATE OR REPLACE VIEW lec_share.v_dim_currency
AS
SELECT
	*
FROM
	core.t_dim_currency
;