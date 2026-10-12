CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MONAT_SPR_ZU_2
(
kjmo
,gj
,mo_gj
,gjmo
,kj
,mo_kj
,mo_bez
,mo_bez_de
,mo_bez_cz
,mo_bez_sk
,mo_bez_hr
,mo_bez_pl
,mo_bez_ro
,mo_bez_bg
)
AS
   SELECT
   v01.kjmo, v01.gj, v01.mo_gj, v01.gjmo, v01.kj, v01.mo_kj, MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez          --Standard DE
   , MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_de    -- DE
   , MAX(CASE WHEN v02.spr_id = 124 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_cz  -- CZ
   , MAX(CASE WHEN v02.spr_id =  90 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_pl    -- PL
   , MAX(CASE WHEN v02.spr_id = 108 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_sk  -- SK
   , MAX(CASE WHEN v02.spr_id =  65 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_hr    -- HR
   , MAX(CASE WHEN v02.spr_id =  95 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_ro    --RO
   , MAX(CASE WHEN v02.spr_id =  18 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_bg  -- BG

   FROM dbp_view.v_monat_2 v01
   INNER JOIN dbp_view.v_monat_spr_zu_2 v02
   ON v01.mo_kj = v02.mo_id
   GROUP BY
   v01.kjmo
   ,v01.gj
   ,v01.mo_gj
   ,v01.gjmo
   ,v01.kj
   ,v01.mo_kj;