CREATE OR REPLACE VIEW lec_share.v_dim_unit_of_measurement
AS
SELECT
	*
FROM
	core.t_dim_unit_of_measurement
;