create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_BONUSKAUF_RABATTTYPE_SPR_ZU_2(
	BONUSKAUF_RABATTTYPE_ID,
	BONUSKAUF_RABATTTYPE_BEZ,
	BONUSKAUF_RABATTTYPE_BEZ_DE,
	BONUSKAUF_RABATTTYPE_BEZ_CZ,
	BONUSKAUF_RABATTTYPE_BEZ_SK,
	BONUSKAUF_RABATTTYPE_BEZ_HR,
	BONUSKAUF_RABATTTYPE_BEZ_PL,
	BONUSKAUF_RABATTTYPE_BEZ_RO,
	BONUSKAUF_RABATTTYPE_BEZ_BG
) as
   SELECT DISTINCT
   v01.bonuskauf_rabatttype_id
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_rabatttype_bez END) AS bonuskauf_rabatttype_bez                 
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_rabatttype_bez END) AS bonuskauf_rabatttype_bez_de                          
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_cz    
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_sk    
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_ro    
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bonuskauf_rabatttype_bez END), bonuskauf_rabatttype_bez_de) AS bonuskauf_rabatttype_bez_bg    
   FROM dbp_view.v_bonuskauf_rabatttype_spr_zu_2  v01

   GROUP BY
   v01.bonuskauf_rabatttype_id;