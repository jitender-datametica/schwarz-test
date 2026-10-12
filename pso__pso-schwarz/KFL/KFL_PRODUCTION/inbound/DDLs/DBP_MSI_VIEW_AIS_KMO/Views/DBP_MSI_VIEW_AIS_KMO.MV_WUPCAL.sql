create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_KMO.MV_WUPCAL(
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	DAT,
	BONANZAHL,
	BONANZAHL_SUG,
	DATENLIEFERUNG,
	DATENLIEFERUNG_ARTBEW,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO
) as
WITH t_wup_bereinigt AS(
    SELECT  
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM dbp_view.v_tag v01
    JOIN dbp_view.v_wup v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN dbp_view.v_tag v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN dbp_view.v_tag v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
    AND ((v02.nb_id = 0
    AND v02.mandant_id <> 1) OR (v02.mandant_id>= 2 AND v02.wup_id = 0))
)
SELECT
  v01.wup_id,
  v01.mandant_id,
  v01.nb_id,
  v01.dat,
  v01.bonanzahl,
  v01.bonanzahl_sug,
  CASE
    WHEN v01.datenlieferung_artbew_wg_sum = 2 THEN 0
    WHEN v01.datenlieferung_artbew_wg_sum = 3 THEN 0
    WHEN v01.datenlieferung_artbew_wg_sum = 0 THEN 0
    ELSE v01.datenlieferung_artbew_wg_sum
    END AS datenlieferung,
  v01.datenlieferung_artbew,
  v02.wup_bereinigt_fg_akt,
  v02.wup_bereinigt_fg_vj,
  v02.wup_bereinigt_fg_vj_wo
  
FROM dbp_view.v_wupcal v01
LEFT JOIN t_wup_bereinigt v02
ON v01.dat = v02.dat 
AND v01.mandant_id = v02.mandant_id 
AND v01.wup_id = v02.wup_id

WHERE v01.mandant_id <> 1;
