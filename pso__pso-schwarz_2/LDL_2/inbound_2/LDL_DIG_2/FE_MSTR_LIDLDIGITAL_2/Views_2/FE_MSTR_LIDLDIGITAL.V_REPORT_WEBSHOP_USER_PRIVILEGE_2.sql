CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_REPORT_WEBSHOP_USER_PRIVILEGE_2 AS
(
SELECT 
    report_name
	,IFNULL(NULLIF( username, '' ), '-1' ) AS username
    ,full_mstr_login_name
    ,LOWER(full_mstr_login_name) AS lower_full_mstr_login_name
    ,wshop_cd
FROM 
	lec_share.v_meta_report_webshop_user_privilege_2
UNION ALL
	SELECT
	 '-1' 	AS report_name 
    ,'-1' 	AS username
    ,'-1' 	AS full_mstr_login_name
    ,'-1' 	AS lower_full_mstr_login_name
    ,'-1' 	AS wshop_cd
)
;
