CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_GRUPPE_UMRECH_FAKTOR
(
 MANDANT_ID
,ART_ID
,GP_ID
,WUP_ID
,NB_ID
,DAT
,BEWART_ID
,UMRECH_FAKTOR_1
,MENGE_AF_X_UMRECH_FAKTOR
,MENGE_SA_X_UMRECH_FAKTOR
)
AS
SELECT
-- Neuanlage AP0239305/SPEC0326063 sschuecke 09.10.2025
 v01.mandant_id
,v01.art_id
,v01.gp_id
,v01.wup_id
,v01.nb_id
,v01.dat
,v01.bewart_id
,CASE WHEN v02.umrech_faktor = 0 THEN 1 ELSE v02.umrech_faktor END AS umrech_faktor_1
,CASE WHEN v01.bewart_id = 1001 THEN (SUM(v01.menge) * umrech_faktor_1) ELSE 0 END AS menge_af_x_umrech_faktor
,CASE WHEN v01.bewart_id = 1002 THEN (SUM(v01.menge) * umrech_faktor_1) ELSE 0 END AS menge_sa_x_umrech_faktor
FROM DBP_DATA.ARTBEW v01
LEFT JOIN DBP_MSI_VIEW2.MV_ART_GRUPPE_ART_ZU v02
ON v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
WHERE v01.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,8;