CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW_MO_SUM_BER_2
(
	ART_ID,
	BEWART_ID,
	BEWART_DET_ID,
	KJMO,
	GP_ID,
	HERST_ID,
	MANDANT_ID,
	MWST_ID,
	NB_ID,
	WRG_2,
	WUP_ID,
	BEZUGSWEG_ID,
	AKTION_ID,
	POSTEN_ID,
	POSTEN_KZ,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	EAN_KASSE,
	BQ_FINDUNG_ID,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
    UMSATZ_NETTO,
	VK_MENGE
    
) AS

WITH t_wup_bereinigt AS(
    SELECT
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' THEN wup_bereinigt_fg_vj_wo
             WHEN (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 
             ELSE 0 END AS wup_bereinigt_fg_vj
    FROM dbp_view.v_tag_2 v01
    JOIN dbp_view.v_wup_2 v02
    ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN dbp_view.v_tag_2 v03
    ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN dbp_view.v_tag_2 v04
    ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
    AND v02.nb_id = 0
    AND v02.mandant_id = 1
)

SELECT
    v1.art_id,
    bewart_id,
    bewart_det_id,
    v4.kjmo,
    gp_id,
    herst_id,
    v1.mandant_id,
    v1.mwst_id,
    nb_id,
    wrg_2,
    v1.wup_id,
    bezugsweg_id,
    aktion_id,
    CASE WHEN BEWART_ID = 1001 AND v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN ''
         ELSE 'PN' END :: CHAR(2) AS POSTEN_ID_,
    CASE WHEN v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
         ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ,
    CASE WHEN BEWART_ID = 1001 AND v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN ''
         ELSE 'PN' END :: CHAR(2) AS POSTEN_ID_PER,
    CASE WHEN v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
         ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER,
    (
    CASE WHEN ean_kasse BETWEEN 100000 AND 999999 THEN ean_kasse * 10000000
             ELSE ean_kasse END
    ) AS ean_kasse,
    bq_findung_id,
    wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    wup_bereinigt_fg_vj,
    SUM(CAST(umsatz_netto AS NUMBER(38, 5))) AS umsatz_netto,
    SUM(CAST(menge AS NUMBER(38, 5))) AS menge,

FROM dbp_view.v_artbew_2 v1

LEFT JOIN dbp_view.v_art_per_2 v2
ON v1.art_id = v2.art_id
AND v1.mandant_id = v2.mandant_id
AND v1.dat BETWEEN v2.dat_von-1 AND v2.dat_bis-1

LEFT JOIN t_wup_bereinigt v3
ON v1.dat = v3.dat 
AND v1.mandant_id = v3.mandant_id 
AND v1.wup_id = v3.wup_id

JOIN dbp_data.tag_2 v4
ON v1.dat = v4.dat

WHERE v1.mandant_id = 1 AND v1.dat >= '2022-01-01' 

GROUP BY
v1.ART_ID,
v1.BEWART_ID,
v1.BEWART_DET_ID,
v4.KJMO,
v1.GP_ID,
v1.HERST_ID,
v1.MANDANT_ID,
v1.MWST_ID,
v1.NB_ID,
v1.WRG_2,
v1.WUP_ID,
v1.BEZUGSWEG_ID,
v1.AKTION_ID,
POSTEN_ID_,
POSTEN_KZ,
POSTEN_ID_PER,
POSTEN_KZ_PER,
EAN_KASSE,
v1.BQ_FINDUNG_ID,
wup_bereinigt_fg_akt,
WUP_BEREINIGT_FG_VJ;