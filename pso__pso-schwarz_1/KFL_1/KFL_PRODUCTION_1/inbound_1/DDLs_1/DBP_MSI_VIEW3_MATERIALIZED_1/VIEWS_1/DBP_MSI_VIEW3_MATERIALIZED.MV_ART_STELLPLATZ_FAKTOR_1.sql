create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_STELLPLATZ_FAKTOR_1(
	MANDANT_ID,
	ART_ID,
	STELLPLATZ_FAKTOR
) as
SELECT
 v01.mandant_id, v01.art_id
,COALESCE (v02.stellplatz_faktor, 0) AS stellplatz_faktor
FROM dbp_view.v_art_1 v01

LEFT JOIN dbp_msi_view_log.ts_art_stellplatz_faktor_1 v02
ON v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id

INNER JOIN dbp_view.v_art_wg_zu_per_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id
AND v03.arthiertyp_id = 2
AND v03.dat_bis = '9999-12-31'


INNER JOIN dbp_view.v_wg_filter_zu_1 v04
ON v04.mandant_id = v03.mandant_id
AND v04.wg_id = v03.wg_id
AND v04.wg_filter_id=4

WHERE v01.dat_bis = '9999-12-31';