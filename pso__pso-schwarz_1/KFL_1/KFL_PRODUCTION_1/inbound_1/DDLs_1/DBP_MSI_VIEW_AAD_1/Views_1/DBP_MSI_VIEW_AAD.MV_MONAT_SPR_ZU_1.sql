CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_MONAT_SPR_ZU_1 AS
--14.06.2023 twie: SPEC0200542 Sprachview Monat_1
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
WHERE kjmo>=202301
GROUP BY v01.kjmo
   , v01.gj
   , v01.mo_gj
   , v01.gjmo
   , v01.kj
   , v01.mo_kj;