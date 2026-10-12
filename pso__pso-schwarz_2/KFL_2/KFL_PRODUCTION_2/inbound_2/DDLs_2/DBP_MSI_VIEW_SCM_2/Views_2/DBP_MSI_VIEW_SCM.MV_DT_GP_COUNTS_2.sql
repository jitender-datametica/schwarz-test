CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_GP_COUNTS_2(
	MANDANT_ID,
	ART_ID,
	DAT_VON,
	DAT_BIS,
	MIN_PLATZIERUNG_MARKT_CLUSTER_ID,
	DAT_BELADUNG,
	GP_COUNT
) 
TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
 AS
 
SELECT 
 v01.mandant_id
,v01.art_id
,v01.dat_ab AS dat_von
,v01.dat_bis
,v01.min_platzierung_markt_cluster_id
,v01.dat_beladung
,COUNT (DISTINCT v01.gp_id) AS gp_count
FROM dbp_view.v_wbs_werbeaenderungen_2 v01

WHERE  v01.dat_beladung = CURRENT_DATE
GROUP BY 
 v01.mandant_id
,v01.art_id
,v01.dat_ab
,v01.dat_bis
,v01.dat_beladung
,v01.min_platzierung_markt_cluster_id
;