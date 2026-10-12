create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_VKL_1(
	MANDANT_ID,
	VKL_ID,
	GF_ID,
	VKL_NAME,
	VKL_NAME_CZ,
	VKL_NAME_SK,
	VKL_NAME_HR,
	VKL_NAME_PL,
	VKL_NAME_RO,
	VKL_NAME_BG
) as
--15.06.2023 snik: SPEC0200542 Lookup VKL_1, analog KMR ohne Zusatz für Maritz
   SELECT
     mandant_id
   , ma_id	AS vkl_id
   , gf_id
   , MAX(CASE WHEN spr_id = 22 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END)							AS vkl_name
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_cz
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_sk
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_hr
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_pl
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_ro
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)	AS vkl_name_bg
   FROM
	(
	 SELECT 
	  v01.mandant_id
	  , v01.ma_id
	  , v01.ma_name
	  , v01.ma_vorname
	  , v01.ma_anrede
	  , v01.spr_id
	  , v02.gf_id
	 FROM dbp_view.v_ma_spr_zu_1 v01
	 --Ermittlung gf_id über vkl_1 Tabelle
	 INNER JOIN dbp_view.v_vkl_1 v02
	  ON v01.ma_id = v02.vkl_id
	  AND v01.mandant_id  = v02.mandant_id
	  WHERE (v01.mandant_id, v01.ma_id) IN 
	  (
	   SELECT mandant_id, vkl_id
	   FROM dbp_view.v_wup_1
	   WHERE nb_id IN (0, -1, 2, 7) AND vkl_id <> wup_id
	   UNION ALL  -- Zentralfilialen
	   SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER
	   FROM dbp_view.v_vs_1
	  )
    ) msz
   GROUP BY mandant_id
   , ma_id
   , gf_id;