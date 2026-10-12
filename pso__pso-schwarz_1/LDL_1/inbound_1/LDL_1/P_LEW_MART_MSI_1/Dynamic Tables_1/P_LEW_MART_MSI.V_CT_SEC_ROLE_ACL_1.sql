
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CT_SEC_ROLE_ACL_1
 /*   
 #DescStart#  
 #$Revision: 10027 $, $LastChangedBy: jgraeff $   
 #SubjectAreas#:  
 #DescEnd#  
 */ 
( 
  security_role_id  
, security_role_desc  
, dashboard_name  
, change_entry  
, actual_entry  
, entry_user  
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   SELECT 
     act.security_role_id,  
   act.security_role_desc,  
   act.dashboard_name,  
   CASE 
      WHEN (n.new_authorized IS NULL)  THEN a.authorized  
      ELSE n.new_authorized 
      END AS change_entry,  
   a.authorized AS actual_entry,  
   CASE 
      WHEN (n.entry_user IS NULL)  THEN a.entry_user  
      ELSE n.entry_user 
      END AS entry_user 
  FROM (  
  SELECT  
    security_role_id, 
   security_role_desc,  
   dashboard_name 
  FROM p_lew_mart_msi.t_ct_sec_role_acl_1 AS t  
   GROUP BY 1,2,3 
   ) AS act 
   LEFT JOIN (  
   SELECT 
     security_role_id,  
   dashboard_name,  
   authorized AS new_authorized,  
   entry_user 
  FROM p_lew_mart_msi.t_ct_sec_role_acl_1 
     WHERE active_fg = 1 AND approved = 0 
  ) AS n  
   ON act.security_role_id = n.security_role_id 
   AND act.dashboard_name  = n.dashboard_name 
   INNER JOIN ( 
   SELECT 
     security_role_id,  
   dashboard_name,  
   authorized,  
   entry_user 
  FROM p_lew_mart_msi.t_ct_sec_role_acl_1 
      WHERE active_fg = 1 AND approved = 1  
  ) AS a  
   ON act.security_role_id = a.security_role_id 
   AND act.dashboard_name  = a.dashboard_name 
;
