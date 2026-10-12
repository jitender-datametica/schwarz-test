-- Bonuskauf Dimension Spr_2 Zu 

CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_bonuskauf_dimension_spr_zu_2(
	BONUSKAUF_DIMENSION_ID,
	BONUSKAUF_DIMENSION_BEZ,
	BONUSKAUF_DIMENSION_BEZ_DE,
	BONUSKAUF_DIMENSION_BEZ_CZ,
	BONUSKAUF_DIMENSION_BEZ_SK,
	BONUSKAUF_DIMENSION_BEZ_HR,
	BONUSKAUF_DIMENSION_BEZ_PL,
	BONUSKAUF_DIMENSION_BEZ_RO,
	BONUSKAUF_DIMENSION_BEZ_BG
) AS
   SELECT DISTINCT
   v01.bonuskauf_dimension_id
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_dimension_bez END) AS bonuskauf_dimension_bez                 
   , MAX(CASE WHEN spr_id =  22 THEN bonuskauf_dimension_bez END) AS bonuskauf_dimension_bez_de                          
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_cz    
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_sk    
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_ro    
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bonuskauf_dimension_bez END), bonuskauf_dimension_bez_de) AS bonuskauf_dimension_bez_bg    
   FROM dbp_view.v_bonuskauf_dimension_spr_zu_2  v01

   GROUP BY
   v01.bonuskauf_dimension_id;