CREATE OR REPLACE VIEW lec_share.v_dim_address_type
AS
SELECT
	*
FROM
	core.t_dim_address_type
;