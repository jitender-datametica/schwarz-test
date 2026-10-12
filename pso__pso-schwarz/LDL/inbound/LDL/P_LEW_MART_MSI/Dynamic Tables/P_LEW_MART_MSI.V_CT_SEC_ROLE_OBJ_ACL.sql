
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CT_SEC_ROLE_OBJ_ACL 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
       p.p_lft_id,   
   p.p_rgt_id, 
   p.p_object_name,  
   act.nstd_lft_id,  
   act.nstd_rgt_id,  
   act.object_name,  
   act.object_type_id,  
   act.object_path,  
   act.security_role_id,   
   act.security_role_desc, 
   alt.authorized AS actual_entry_auth,   
   CASE  
          WHEN (neu.new_authorized IS NULL) THEN alt.authorized   
          ELSE neu.new_authorized   
      END AS change_entry_auth,  
   CASE  
         WHEN (neu.entry_user IS NULL) THEN alt.entry_user  
         ELSE neu.entry_user  
      END AS entry_user,   
   act.zero_val   
  FROM ( 
  SELECT 
      security_role_id, 
   security_role_desc,  
   object_name,   
   object_type_id,   
   object_path,   
   nstd_lft_id,   
   nstd_rgt_id,   
   zero_val 
  FROM p_lew_mart_msi.t_ct_sec_role_obj_acl  
  GROUP BY 1,2,3,4,5,6,7,8 
  ) act  
   LEFT JOIN ( 
   SELECT   
         security_role_id AS security_role_id,  
   authorized       AS new_authorized, 
   entry_user       AS entry_user,  
   nstd_lft_id      AS nstd_lft_id  
      FROM p_lew_mart_msi.t_ct_sec_role_obj_acl 
      WHERE active_fg = 1  
      AND approved    = 0  
  ) AS neu  
   ON act.security_role_id = neu.security_role_id  
   AND act.nstd_lft_id     = neu.nstd_lft_id 
   INNER JOIN (   
   SELECT   
         security_role_id, 
   authorized, 
   nstd_lft_id,   
   entry_user  
      FROM p_lew_mart_msi.t_ct_sec_role_obj_acl 
      WHERE active_fg = 1  
      AND approved    = 1  
  ) AS alt  
   ON act.security_role_id = alt.security_role_id  
   AND act.nstd_lft_id     = alt.nstd_lft_id 
   
   JOIN p_lew_mart_msi.t_ref_obj_acl_parent_child AS p   
   ON p.c_lft_id = act.nstd_lft_id  
;
