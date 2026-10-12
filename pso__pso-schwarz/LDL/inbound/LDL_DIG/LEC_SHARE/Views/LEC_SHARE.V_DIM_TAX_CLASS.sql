CREATE OR REPLACE VIEW lec_share.v_dim_tax_class
AS
SELECT
	*
FROM
	core.t_dim_tax_class
;