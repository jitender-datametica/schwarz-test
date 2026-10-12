create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_STERNCHEN_LOGIK_NONFOOD_1(
	ART_ID,
	SM_ID,
	MANDANT_ID,
	LIST_DURCHG_FG,
	ANZAHL_MARKT,
	STERNCHEN_ID,
	KL_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
SELECT
lsl.art_id,  
lsl.sm_id,  
lsl.mandant_id,  
lsl.list_durchg_fg,  
lsl.anzahl_markt_soll,  
ls.sternchen_id,  1
FROM
   (
   SELECT
    art_id,  
    sm_id,  
    mandant_id,  
    CASE WHEN SUM(list_durchg_fg) = COUNT(list_durchg_fg) THEN 1 ELSE 0 END list_durchg_fg,  
    CASE WHEN SUM(bezugsweg1_fg) = COUNT(bezugsweg1_fg) THEN 1 ELSE 0 END bezugsweg1_fg,  
    CASE WHEN SUM(bezugsweg4_fg) = COUNT(bezugsweg4_fg) THEN 1 ELSE 0 END bezugsweg4_fg,  
    CASE WHEN SUM(kdis0_fg) = COUNT(kdis0_fg) THEN 1 ELSE 0 END kdis0_fg,  
    CASE WHEN SUM(kdis1_fg) = COUNT(kdis1_fg) THEN 1 ELSE 0 END kdis1_fg,  
    SUM(anzahl_markt_soll) anzahl_markt_soll
    FROM dbp_view.v_sternchen_logik_1
    WHERE mandant_id = 1 
    AND CURRENT_DATE BETWEEN dat_von AND dat_bis
    GROUP BY
    art_id
    ,sm_id
    ,mandant_id   
   ) lsl
INNER JOIN dbp_view.v_l_sternchen_1 AS ls
ON  lsl.list_durchg_fg = ls.list_durchg_fg
AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
AND lsl.kdis0_fg       = ls.kdis0_fg
AND lsl.kdis1_fg       = ls.kdis1_fg
AND lsl.mandant_id     = ls.mandant_id;
