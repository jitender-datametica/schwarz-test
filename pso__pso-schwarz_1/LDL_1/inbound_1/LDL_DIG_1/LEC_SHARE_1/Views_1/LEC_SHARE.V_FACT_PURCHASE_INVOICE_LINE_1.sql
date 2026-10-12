CREATE OR REPLACE VIEW lec_share.v_fact_purchase_invoice_line_1
AS
SELECT
	*
FROM
	core.t_fact_purchase_invoice_line_1
;