CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_MO_SUM_BER_1
(
KJMO,
ART_ID,
MANDANT_ID,
GP_ID,
NB_ID,
WUP_ID,
BEWART_ID,
BEWART_DET_ID,
BQ_FINDUNG_ID,
BEZUGSWEG_ID,
POSTEN_ID,
POSTEN_KZ,
POSTEN_ID_PER,
POSTEN_KZ_PER,
WUP_BEREINIGT_FG,
WUP_BEREINIGT_FG_VJ,
EAN_KASSE,
UMRECHNUNGSKURS_HIST,
UMSATZ_NETTO,
DIFF_UMSATZ_NETTO_KONZ,
MENGE
)
TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   
WITH t_wup_bereinigt AS
(
SELECT  
v01.dat, 
v02.mandant_id,
v02.wup_id,
CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
CASE WHEN v01.dat LIKE '%-02-29' 
THEN wup_bereinigt_fg_vj_wo
WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj
FROM dbp_view.v_tag_1 v01
JOIN dbp_view.v_wup_1 v02
ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
LEFT JOIN dbp_view.v_tag_1 v03
ON (v01.dat = v03.dat_vj_kt)
LEFT JOIN dbp_view.v_tag_1 v04
ON (v01.dat = v04.dat_vj)
WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
AND v02.nb_id = 0
AND v02.mandant_id <> 1
)

SELECT
v06.kjmo,
v01.art_id,
v01.mandant_id,
v01.gp_id,
v01.nb_id,
v01.wup_id,
v01.bewart_id,
v01.bewart_det_id,
v01.bq_findung_id,
v01.bezugsweg_id,
CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('1') THEN 'SO'
     ELSE 'PN' END :: CHAR(2) AS posten_id,
CASE WHEN v01.POSTEN_ID NOT IN ('1') THEN 'SO'
     ELSE 'PN' END :: CHAR(2) AS posten_kz,
CASE WHEN v01.bewart_id = 1001 AND v04.posten_id NOT IN ('1') THEN 'SO'
     ELSE 'PN' END :: CHAR(2) AS posten_id_per,
CASE WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO'
     ELSE 'PN'
END :: CHAR(2) AS posten_kz_per,
v05.wup_bereinigt_fg_akt,
v05.wup_bereinigt_fg_vj,
(CASE WHEN v01.ean_kasse BETWEEN 100000 AND 999999 THEN  v01.ean_kasse * 10000000 
      ELSE v01.ean_kasse END ) AS ean_kasse,
v01.UMRECHNUNGSKURS_HIST,
SUM(umsatz_netto) AS umsatz_netto,
SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
SUM(CAST(v01.menge AS NUMBER(38,5))) AS vk_menge

FROM dbp_view.v_artbew_1 v01

LEFT JOIN dbp_view.v_art_per_1 v04
ON v01.art_id = v04.art_id
AND v01.mandant_id = v04.mandant_id
AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1

LEFT JOIN t_wup_bereinigt v05
ON v01.dat = v05.dat
AND v01.mandant_id = v05.mandant_id 
AND v01.wup_id = v05.wup_id

JOIN dbp_view.v_tag_1 v06
ON v01.dat = v06.dat

WHERE v01.mandant_id > 1 AND  v01.dat >= '2022-01-01'
AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
AND NOT (v01.mandant_id = 2 AND v01.art_id = 20812450)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 20811369)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 20813157)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 20811474)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 20813164)
   
GROUP BY
v06.KJMO,
v01.ART_ID,
v01.MANDANT_ID,
v01.GP_ID,
v01.NB_ID,
v01.WUP_ID,
v01.BEWART_ID,
v01.BEWART_DET_ID,
v01.BQ_FINDUNG_ID,
v01.BEZUGSWEG_ID,
v01.POSTEN_ID,
POSTEN_KZ,
POSTEN_ID_PER,
POSTEN_KZ_PER,
v05.wup_bereinigt_fg_akt,
v05.wup_bereinigt_fg_vj,
EAN_KASSE,
v01.UMRECHNUNGSKURS_HIST;