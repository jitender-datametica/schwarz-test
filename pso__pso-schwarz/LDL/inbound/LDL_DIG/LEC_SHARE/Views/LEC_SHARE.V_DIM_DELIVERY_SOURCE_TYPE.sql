CREATE OR REPLACE VIEW lec_share.v_dim_delivery_source_type
AS
SELECT
	*
FROM
	core.t_dim_delivery_source_type
;