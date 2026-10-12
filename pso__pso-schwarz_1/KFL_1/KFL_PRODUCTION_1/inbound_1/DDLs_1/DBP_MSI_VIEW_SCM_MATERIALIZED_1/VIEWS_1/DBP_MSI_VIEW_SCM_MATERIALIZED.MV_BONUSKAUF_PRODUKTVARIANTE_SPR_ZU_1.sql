create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_BONUSKAUF_PRODUKTVARIANTE_SPR_ZU_1(
	BONUSKAUF_PRODUKTVARIANTE_ID,
	BONUSKAUF_PRODUKTVARIANTE_BEZ,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_DE,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_CZ,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_SK,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_HR,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_PL,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_RO,
	BONUSKAUF_PRODUKTVARIANTE_BEZ_BG
) as
   SELECT DISTINCT
   v01.bonuskauf_produktvariante_id
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_produktvariante_bez END) AS bonuskauf_produktvariante_bez                 
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_produktvariante_bez END) AS bonuskauf_produktvariante_bez_de                          
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_cz    
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_sk    
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_ro    
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bonuskauf_produktvariante_bez END), bonuskauf_produktvariante_bez_de) AS bonuskauf_produktvariante_bez_bg    
   FROM dbp_view.v_bonuskauf_produktvariante_spr_zu_1  v01

   GROUP BY
   v01.bonuskauf_produktvariante_id;