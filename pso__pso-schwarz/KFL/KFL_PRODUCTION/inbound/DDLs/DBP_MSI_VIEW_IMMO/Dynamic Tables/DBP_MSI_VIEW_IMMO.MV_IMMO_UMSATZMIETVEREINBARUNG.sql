CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_UMSATZMIETVEREINBARUNG(
	MV_INTRENO,
	MIETE_UMSATZ_PROZENT,
	FLAG_GREY
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
SELECT 
v5.mv_intreno
,MAX(v5.miete_umsatz_prozent) AS miete_umsatz_prozent 
,v5.flag_grey

FROM (
SELECT 
mv_intreno
,CASE WHEN CAST(miete_umsatz_prozent-AVG(miete_umsatz_prozent) OVER(PARTITION BY mv_intreno) AS DECIMAL (9,2)) =0 THEN miete_umsatz_prozent ELSE NULL END AS miete_umsatz_prozent
,CASE WHEN COUNT(mv_intreno) OVER(PARTITION BY mv_intreno)>1 THEN 1 ELSE 0 END AS flag_grey
FROM dbp_view.v_immo_umsatzmietvereinbarung 
WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
) v5
GROUP BY
v5.mv_intreno

,v5.flag_grey
;