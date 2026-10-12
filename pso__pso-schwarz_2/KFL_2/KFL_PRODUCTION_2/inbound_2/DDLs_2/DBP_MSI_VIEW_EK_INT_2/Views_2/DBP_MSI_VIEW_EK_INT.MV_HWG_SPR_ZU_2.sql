CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_HWG_SPR_ZU_2
(
hwg_id
--,mandant_id
,arthiertyp_id
,hwg_bez
,hwg_bez_de
,hwg_bez_cz
,hwg_bez_sk
,hwg_bez_hr
,hwg_bez_pl
,hwg_bez_ro
,hwg_bez_bg
)
AS

   SELECT
   v01.hwg_id, v01.arthiertyp_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END),'N/A') AS hwg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END),'N/A') AS hwg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg  -- BG

   FROM dbp_view.v_hwg_per_2 v01
   INNER JOIN dbp_view.v_hwg_spr_zu_2 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis

   group by 1,2;