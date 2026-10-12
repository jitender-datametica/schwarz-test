create or replace dynamic table KFL_PRODUCTION.DBP_MSI_VIEW2.MV_EINKAUFSPREISSTAMM(
	MANDANT_ID,
	ART_ID,
	BEZUGSWEG_ID,
	EK_KAL_BASIS,
	EK_MEP,
	LOGISTIKKOSTENZUSCHLAG,
	STERNCHEN_LOGIK_SK,
	SX_ID,
	S1_ID,
	S2_ID,
	S3_ID,
	S4_ID,
	S5_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_P_DYNAMIC_TABLE_AIS_DE
 as
SELECT
dt1.mandant_id, 
dt1.art_id, 
dt1.bezugsweg_id, 
dt1.ek_kal_basis, 
dt1.ek_mep, 
dt1.logistikkostenzuschlag, 
dt2.sternchen_logik_sk, 
dt2.sX_id, 
dt2.s1_id, 
dt2.s2_id, 
dt2.s3_id, 
dt2.s4_id, 
dt2.s5_id

FROM KFL_PRODUCTION.dbp_msi_view2.mv_einkaufspreisstamm_kbsal dt1
INNER JOIN
   (SELECT
   sk.art_id,  
   sk.mandant_id,  
   bezugsweg_id,  
   MAX(sX_id)||'/'||MAX(s1_id)||'/'||MAX(s2_id)||'/'||MAX(s3_id)||'/'||MAX(s4_id)||'/'||MAX(s5_id) AS sternchen_logik_sk,  
   MAX(sX_id) AS sX_id,  
   MAX(s1_id) AS s1_id,  
   MAX(s2_id) AS s2_id,  
   MAX(s3_id) AS s3_id,  
   MAX(s4_id) AS s4_id,  
   MAX(s5_id) AS s5_id
   FROM
   (
   SELECT
   lsl.art_id AS art_id,  
   lsl.mandant_id,  
   (lsl.bezugsweg1_fg * 1) + ( lsl.bezugsweg4_fg * 4 ) AS bezugsweg_id,  
   CAST (CASE lsl.sm_id WHEN -1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS sX_id,  
   CAST (CASE lsl.sm_id WHEN 1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s1_id,  
   CAST (CASE lsl.sm_id WHEN 2 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s2_id,  
   CAST (CASE lsl.sm_id WHEN 3 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s3_id,  
   CAST (CASE lsl.sm_id WHEN 4 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s4_id,  
   CAST (CASE lsl.sm_id WHEN 5 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s5_id
   FROM KFL_PRODUCTION.dbp_view.v_sternchen_logik AS lsl
   INNER JOIN KFL_PRODUCTION.dbp_view.v_l_sternchen AS ls
   ON  lsl.list_durchg_fg = ls.list_durchg_fg
   AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
   AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
   AND lsl.kdis0_fg       = ls.kdis0_fg
   AND lsl.kdis1_fg       = ls.kdis1_fg
   AND lsl.mandant_id     = ls.mandant_id

   WHERE lsl.mandant_id = 1
   AND lsl.dat_bis = '9999-12-31'
   ) AS sk
   GROUP BY 1, 2, 3
   )dt2
   ON dt1.mandant_id = dt2.mandant_id
   AND dt1.art_id = dt2.art_id
   AND dt1.bezugsweg_id = dt2.bezugsweg_id;