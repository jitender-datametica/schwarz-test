CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ORG_ACCOUNT_MANAGER_MERGE_2 as
   /*	
   #DescStart#	
   #$Revision: 12357 $, $LastChangedBy: tkhusainov $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
	
   SELECT	
     oamm.aspect_id,	
   oamm.client_id,	
   b.src_wh_id  AS wh_id,	
   oamm.account_manager_id,	
   oamm.account_manager_name	
	
  FROM p_lew_core_ac.v_wawi_org_account_manager_mrg_act_2 oamm	
   INNER JOIN p_lew_core_ac.v_location_2 b	
   ON oamm.client_id = b.client_id	
   AND oamm.wh_loc_sid = b.loc_sid	
   AND b.wh_store_mark = 'B'  -- Filialen	
	
   UNION ALL	
	
   /* Adding country_2 level dummy_2 records for aspect id 1 and 2*/	
	
   SELECT	
     multiply.row_no                                  AS aspect_id,	
   client_id                                        AS client_id,	
   -1*client_id                                     AS wh_id,	
   -1*client_id                                     AS account_manager_id,	
   CAST('#'|| TRIM( cntr.country_iso_cd) AS VARCHAR(50))	
   AS account_manager_name	
	
FROM p_lew_core_ac.v_wawi_ref_client_country_2              AS clnt	
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_2               AS cntr	
   ON clnt.country_id = cntr.country_id	
   CROSS JOIN (SELECT 1 AS row_no FROM (SELECT 1 AS one) SUB1	
   UNION ALL	
   SELECT 2 AS row_no FROM (SELECT 1 AS two) SUB2	
   ) AS multiply	
   WHERE cntr.dashboard_relevant_fg = 1	
;