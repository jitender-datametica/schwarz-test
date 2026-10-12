create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MONAT_SPR_ZU_1(
	KJMO,
	GJ,
	MO_GJ,
	GJMO,
	KJ,
	MO_KJ,
	MO_BEZ,
	MO_BEZ_CZ,
	MO_BEZ_PL,
	MO_BEZ_SK,
	MO_BEZ_HR,
	MO_BEZ_RO,
	MO_BEZ_BG,
	MO_BEZ_LANG,
	MO_BEZ_LANG_CZ,
	MO_BEZ_LANG_PL,
	MO_BEZ_LANG_SK,
	MO_BEZ_LANG_HR,
	MO_BEZ_LANG_RO,
	MO_BEZ_LANG_BG,
	MO_KBEZ,
	MO_KBEZ_CZ,
	MO_KBEZ_PL,
	MO_KBEZ_SK,
	MO_KBEZ_HR,
	MO_KBEZ_RO,
	MO_KBEZ_BG,
	MO_KBEZ_KJ,
	MO_KBEZ_KJ_CZ,
	MO_KBEZ_KJ_PL,
	MO_KBEZ_KJ_SK,
	MO_KBEZ_KJ_HR,
	MO_KBEZ_KJ_RO,
	MO_KBEZ_KJ_BG
) as
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT
   v01.kjmo
   , v01.gj
   , v01.mo_gj
   , v01.gjmo
   , v01.kj
   , v01.mo_kj
   , MAX(CASE WHEN v02.spr_id =   22 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez   --standard=deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_cz
   , MAX(CASE WHEN v02.spr_id =   90 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_pl
   , MAX(CASE WHEN v02.spr_id = 108 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_sk
   , MAX(CASE WHEN v02.spr_id =   65 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_hr
   , MAX(CASE WHEN v02.spr_id =   95 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_ro
   , MAX(CASE WHEN v02.spr_id =   18 THEN (v02.mo_bez::VARCHAR(20)) ELSE NULL END)  AS mo_bez_bg
   , MAX(CASE WHEN v02.spr_id =   22 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang  --standard=deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_cz
   , MAX(CASE WHEN v02.spr_id =   90 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_pl
   , MAX(CASE WHEN v02.spr_id = 108 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_sk
   , MAX(CASE WHEN v02.spr_id =   65 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_hr
   , MAX(CASE WHEN v02.spr_id =   95 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_ro
   , MAX(CASE WHEN v02.spr_id =   18 THEN (TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_bez_lang_bg
   , MAX(CASE WHEN v02.spr_id =   22 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez   --standard=deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_cz
   , MAX(CASE WHEN v02.spr_id =   90 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_pl
   , MAX(CASE WHEN v02.spr_id = 108 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_sk
   , MAX(CASE WHEN v02.spr_id =   65 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_hr
   , MAX(CASE WHEN v02.spr_id =   95 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_ro
   , MAX(CASE WHEN v02.spr_id =   18 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3))::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_bg
   , MAX(CASE WHEN v02.spr_id =   22 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj   --standard=deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_cz
   , MAX(CASE WHEN v02.spr_id =   90 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_pl
   , MAX(CASE WHEN v02.spr_id = 108 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_sk
   , MAX(CASE WHEN v02.spr_id =   65 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_hr
   , MAX(CASE WHEN v02.spr_id =   95 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_ro
   , MAX(CASE WHEN v02.spr_id =   18 THEN (TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj)::VARCHAR(20)) ELSE NULL END)  AS mo_kbez_kj_bg

   FROM dbp_view.v_monat_1 v01
   
   INNER JOIN dbp_view.v_monat_spr_zu_1 v02
   ON v01.mo_kj = v02.mo_id

   GROUP BY 1,2,3,4,5,6;