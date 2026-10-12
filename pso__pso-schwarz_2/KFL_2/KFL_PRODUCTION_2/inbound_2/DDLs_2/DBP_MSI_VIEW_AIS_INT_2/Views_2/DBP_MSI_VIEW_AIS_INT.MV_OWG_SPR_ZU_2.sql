CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_OWG_SPR_ZU_2
(
owg_id
,arthiertyp_id
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
   v01.owg_id, v01.arthiertyp_id, v01.mandant_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.owg_bez END),'N/A') AS owg_bez                       -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.owg_bez END),'N/A') AS owg_bez_de                 -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_pl     -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_bg    -- BG

   FROM dbp_view.v_owg_spr_zu_2 v01
   WHERE v01.arthiertyp_id = 2
   GROUP BY 1,2,3;