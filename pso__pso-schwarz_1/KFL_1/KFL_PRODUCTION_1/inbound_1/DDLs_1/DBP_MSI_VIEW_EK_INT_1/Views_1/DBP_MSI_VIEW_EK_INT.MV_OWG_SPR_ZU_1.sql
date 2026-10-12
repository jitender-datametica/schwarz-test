CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_OWG_SPR_ZU_1
(
owg_id
,mandant_id
,owg_bez
,owg_bez_de
,owg_bez_cz
,owg_bez_sk
,owg_bez_hr
,owg_bez_pl
,owg_bez_ro
,owg_bez_bg
)
AS
   SELECT
   v01.owg_id, v01.mandant_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.owg_bez END),'N/A') AS owg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.owg_bez END),'N/A') AS owg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.owg_bez END), owg_bez_de) AS owg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.owg_bez END), owg_bez_de) AS owg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_bg  -- BG

   FROM dbp_view.v_owg_per_1 v01
   INNER JOIN dbp_view.v_owg_spr_zu_1 v02
   ON
   v02.owg_id = v01.owg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis

   GROUP BY 1,2;