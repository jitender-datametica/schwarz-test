create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_MONAT_KJ_SPR_ZU_1(
	KJMO,
	KJ,
	MO_KJ,
	KJMO_BEZ
) as 
--2022.02.03, dknop, initial
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
	v01.kjmo,
	v01.kj,
	v01.mo_kj,
	MAX(TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)) AS kjmo_bez
FROM
	dbp_view.v_monat_1 v01
	INNER JOIN dbp_view.v_monat_spr_zu_1 v02 
	ON v01.mo_kj = v02.mo_id
	JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v03 
	ON v02.spr_id = v03.spr_id
GROUP BY
	v01.kjmo,
	v01.kj,
	v01.mo_kj;