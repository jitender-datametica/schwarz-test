CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_delivery_zip_full (
	addr_sid
	, addr_lat
	, addr_lon
	, addr_nr
	, zip_cd
) AS 
SELECT DISTINCT
	dim.addr_sid
	, dim.addr_lat
	, dim.addr_lon
	, dim.addr_nr
	, dim.zip_cd
FROM
	lec_share.v_dim_address 				AS dim
INNER JOIN
	lec_share.v_fact_customer_order_line	AS fact
	ON dim.addr_sid = fact.delivery_addr_sid
WHERE
	dim.dwh_valid_fg = TRUE
;
