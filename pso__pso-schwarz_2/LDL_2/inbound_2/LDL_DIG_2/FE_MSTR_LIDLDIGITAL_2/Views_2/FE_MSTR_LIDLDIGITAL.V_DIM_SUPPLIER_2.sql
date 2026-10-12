CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_supplier_2 
AS SELECT
	supplier_sid 										AS supplier_sid
	, supplier_nr 										AS supplier_nr
	, supplier_name 									AS supplier_name
	, supplier_full_name 								AS supplier_full_name
	, IFNULL( addr_sid, '-1' ) 							AS addr_sid	
	, IFNULL( NULLIF( orig_country_cd, '' ), '-1' ) 	AS orig_country_cd
	, IFNULL( NULLIF( zip_cd, '' ), '-1' )				AS zip_cd
	, city_name											AS city_name
	, street_name										AS street_name
	, supplier_src_insert_dt							AS supplier_src_insert_dt
FROM
    lec_share.v_dim_supplier_2
WHERE
    dwh_valid_fg = TRUE
	
UNION ALL
    SELECT    
         '-1' -- supplier_sid
        ,''   -- supplier_nr
        ,''   -- supplier_name
        ,''   -- supplier_full_name
        ,'-1' -- addr_sid
        ,'-1' -- orig_country_cd
        ,'-1' -- zip_cd
        ,''   -- city_name
        ,''   -- street_name
		,''   -- supplier_src_insert_dt
;