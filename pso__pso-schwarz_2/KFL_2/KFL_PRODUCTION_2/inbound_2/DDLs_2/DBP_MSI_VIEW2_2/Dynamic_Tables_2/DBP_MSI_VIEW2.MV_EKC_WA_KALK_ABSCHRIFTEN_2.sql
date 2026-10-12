CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_EKC_WA_KALK_ABSCHRIFTEN_2
(
	MANDANT_ID,
	ART_ID,
	GP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	WUP_ID,
	NB_ID,
	DAT,
	WRG_ID,
	WUP_BEREINIGT_FG,
	ZEK_ID,
	EIGENMARKE_FG,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	PREIS_ABSCHRIFT_NETTO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 a.mandant_id
,a.art_id
,b.gp_id
,a.bewart_id
,a.bewart_det_id
,a.wup_id
,a.nb_id
,a.dat
,a.wrg_id
,a.wup_bereinigt_fg
,a.zek_id
,a.eigenmarke_fg
,CASE WHEN a.BEWART_ID = 1001 AND c.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN '' ELSE 'PN' END  AS POSTEN_ID_PER
,CASE WHEN c.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END AS POSTEN_KZ_PER
,a.preis_abschrift_netto

FROM dbp_view.v_artbew_dat_ek_cp_sum_2 a
   
JOIN dbp_view.v_art_gp_nm_zu_per_2 b
ON (a.mandant_id = b.mandant_id  
AND a.art_id = b.art_id  
AND a.wup_id = b.wup_id  
AND a.dat BETWEEN b.dat_von AND b.dat_bis)
   
LEFT JOIN dbp_view.v_art_per_2 c
ON (a.art_id = c.art_id
AND a.mandant_id = c.mandant_id
AND a.dat BETWEEN c.dat_von-1 AND c.dat_bis-1)
   
WHERE a.mandant_id = 1
AND a.wup_bereinigt_fg = 0
AND a.transaktion_typ_id = 1
AND a.preis_abschrift_netto != 0;