CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_MONAT_SPR_ZU_1
AS
   SELECT
   v01.kjmo, v01.gj, v01.mo_gj, v01.gjmo, v01.kj, v01.mo_kj, MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez    --Standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_de  --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_cz  --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_pl   --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_sk  --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_hr   --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_ro   --rumaenisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_bg  ---bulgarisch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang   --Standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_de    --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_cz   --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_pl    --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_sk   --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_hr   --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_ro    --rumaenisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_bg   --bulgarisch
   , MAX(CASE WHEN v02.spr_id =  22 THEN DECODE(TRIM(SUBSTRING(v02.mo_bez, 1, 3)),'Mae','Mrz',TRIM(SUBSTRING(v02.mo_bez, 1, 3))) ELSE NULL END)::VARCHAR(20) AS mo_kbez   --Standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN DECODE(TRIM(SUBSTRING(v02.mo_bez, 1, 3)),'Mae','Mrz',TRIM(SUBSTRING(v02.mo_bez, 1, 3))) ELSE NULL END)::VARCHAR(20) AS mo_kbez_de   --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_cz   --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_pl   --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_sk   --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_hr   --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_ro   --rumaenisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_bg   --bulgarisch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj   --Standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_de    --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_cz   --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_pl     --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_sk   --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_hr    --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_ro    --rumaenisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_bg   --bulgarisch

   FROM dbp_view.v_monat_1 v01
   INNER JOIN dbp_view.v_monat_spr_zu_1 v02
   ON v01.mo_kj = v02.mo_id
   GROUP BY
   v01.kjmo
   ,v01.gj
   ,v01.mo_gj
   ,v01.gjmo
   ,v01.kj
   ,v01.mo_kj;