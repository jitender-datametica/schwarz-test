CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_internal_company (
	internal_company_sid
	, internal_company_cd
	, internal_company_name
	, country_cd
	, company_nr
	, company_name
	, company_group
    , is_ker_relevant_fg
) AS
SELECT
    t1.internal_company_sid   																	AS internal_company_sid
    , IFNULL( NULLIF( t1.internal_company_cd, '' ), '-1' ) 										AS internal_company_cd
    , t1.internal_company_name																	AS internal_company_name
    , IFNULL( NULLIF( t1.country_cd, '' ), '-1' ) 												AS country_cd
    , t1.company_nr																				AS company_nr
    , t1.company_name																			AS company_name
    , COALESCE( t2.cc_group_lvl2_name_de, t2.cc_group_lvl2_name_en, '-1' ) 						AS company_group   
    , IFNULL( t3.parameter_value_numeric ::BOOLEAN, FALSE )                                     AS is_ker_relevant_fg
FROM
    lec_share.v_dim_internal_company 		AS t1
LEFT JOIN
	lec_share.v_dim_cost_center_group_lvl_4 	AS t2 	ON t1.internal_company_cd = t2.cc_group_lvl4_nr
LEFT JOIN
    lec_share.v_meta_report_parameter             AS t3   ON t3.report = 'KER'
                                                AND t3.parameter_type = 'filter'
                                                AND t3.parameter_name = 'cc_group_lvl_2_nr'
                                                AND t2.cc_group_lvl2_nr = t3.parameter_value_char
WHERE
    dwh_valid_fg = TRUE
UNION ALL
    SELECT '-1', '-1', '', '-1', '-1', '', '-1', 'FALSE'
;