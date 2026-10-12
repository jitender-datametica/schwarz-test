CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_REL_COST_CENTER_USER_PRIVILEGE_1 AS
(
SELECT 
	IFNULL(NULLIF( username, '' ), '-1' ) AS username
    ,full_mstr_login_name
    ,LOWER(full_mstr_login_name) AS lower_full_mstr_login_name
    ,fiscal_year
    ,cost_center_nr
FROM 
	lec_share.v_meta_rel_cost_center_user_privilege_1
UNION ALL
	SELECT
	 '-1' 	AS USERNAME  
    ,'-1' 	AS FULL_MSTR_LOGIN_NAME
    ,'-1' 	AS LOWER_FULL_MSTR_LOGIN_NAME
    ,'-1' 	AS FISCAL_YEAR
    ,'-1' 	AS COST_CENTER_NR
)
;