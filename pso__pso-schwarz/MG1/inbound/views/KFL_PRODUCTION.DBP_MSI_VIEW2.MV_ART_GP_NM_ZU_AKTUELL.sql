create or replace view KFL_PRODUCTION.DBP_MSI_VIEW2.MV_ART_GP_NM_ZU_AKTUELL(
	ART_ID,
	AKT_GP_ID,
	GP_NAME,
	MANDANT_ID,
	ANZ_LIEF
) as
SELECT
v01.art_id,
v01.gp_id,
v02.gp_name,
v01.mandant_id,
COUNT(v01.wup_id) AS anz_lief
FROM dbp_view.v_art_gp_nm_zu_per v01
JOIN dbp_view.v_gp v02
ON v01.gp_id=v02.gp_id
AND v01.mandant_id = v02.mandant_id
JOIN dbp_view.v_wup v03
on v01.mandant_id = v03.mandant_id
AND v01.wup_id = v03.wup_id
AND v01.nb_id = v03.nb_id

where
v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
AND v03.nb_id = 0
AND current_date BETWEEN v03.dat_von AND v03.dat_bis
GROUP BY 1,2,3,4
QUALIFY ROW_NUMBER() OVER (PARTITION BY  art_id ORDER BY anz_lief DESC NULLS LAST) = 1;