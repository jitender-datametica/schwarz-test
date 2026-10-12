create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_KPOS_ZAHLUNG_TYP_LU(
	KPOS_ZAHLUNG_TYP_ID,
	KPOS_ZAHLUNG_TYP_BEZ_DE,
	KPOS_ZAHLUNG_TYP_BEZ,
	KPOS_ZAHLUNG_TYP_BEZ_CZ,
	KPOS_ZAHLUNG_TYP_BEZ_SK,
	KPOS_ZAHLUNG_TYP_BEZ_HR,
	KPOS_ZAHLUNG_TYP_BEZ_PL,
	KPOS_ZAHLUNG_TYP_BEZ_RO,
	KPOS_ZAHLUNG_TYP_BEZ_BG
) as
SELECT DISTINCT 
	
	kpos_zahlung_typ_id
	, MAX(CASE WHEN spr_id = 22 THEN kpos_zahlung_typ_bez ELSE TRIM(kpos_zahlung_typ_id) END) AS kpos_zahlung_typ_bez_de
	, kpos_zahlung_typ_bez_de AS kpos_zahlung_typ_bez 
	, COALESCE(MAX(CASE WHEN spr_id = 124 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_cz 
	, COALESCE(MAX(CASE WHEN spr_id = 108 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_sk 
	, COALESCE(MAX(CASE WHEN spr_id =  65 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_hr 
	, COALESCE(MAX(CASE WHEN spr_id =  90 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_pl 
	, COALESCE(MAX(CASE WHEN spr_id =  95 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_ro 
	, COALESCE(MAX(CASE WHEN spr_id =  18 THEN kpos_zahlung_typ_bez END), kpos_zahlung_typ_bez_de) AS kpos_zahlung_typ_bez_bg 
FROM dbp_v_ods.v_l_kpos_zahlung_typ_spr_zu
GROUP BY kpos_zahlung_typ_id
;
