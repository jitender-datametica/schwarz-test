CREATE OR REPLACE VIEW lec_share.v_dim_internal_company_partner
AS
SELECT
	*
FROM
	core.t_dim_internal_company_partner
;