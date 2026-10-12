
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CT_SEC_ROLE_OBJ_ACL_PERMS 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
        act.security_role_id, 
   act.security_role_desc, 
   act.permission_type, 
   alt.authorized AS actual_entry_auth,   
   CASE  
          WHEN (neu.new_authorized IS NULL) THEN alt.authorized   
          ELSE neu.new_authorized   
       END AS change_entry_auth, 
   CASE  
          WHEN (neu.entry_user IS NULL)  THEN alt.entry_user   
          ELSE neu.entry_user 
       END AS entry_user,  
   zero_val 
  FROM ( 
  SELECT 
       security_role_id,   
   security_role_desc,  
   permission_type,  
   zero_val 
  FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms  
  GROUP BY 1,2,3,4   
  ) act  
   LEFT JOIN ( 
   SELECT   
     security_role_id AS security_role_id,   
   authorized       AS new_authorized, 
   entry_user       AS entry_user,  
   permission_type  AS permission_type 
      FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms 
      WHERE active_fg = 1 AND approved = 0   
  ) AS neu  
   ON act.security_role_id = neu.security_role_id  
   AND act.permission_type = neu.permission_type   
   INNER JOIN (   
   SELECT   
        security_role_id,  
   authorized, 
   permission_type,  
   entry_user  
      FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms 
      WHERE active_fg = 1  
      AND approved    = 1  
  ) AS alt  
   ON act.security_role_id = alt.security_role_id  
   AND act.permission_type = alt.permission_type   
;
