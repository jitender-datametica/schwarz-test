CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_FLW_PREIS_SPR_ZU_1
(
flw_preis_id
,flw_preis_bez
,flw_preis_bez_cz
,flw_preis_bez_pl
,flw_preis_bez_sk
,flw_preis_bez_hr
,flw_preis_bez_ro
,flw_preis_bez_bg
)
AS
-- 29.01.2014 twie: Sprachzuordnung für Zusatzinfo 'FLW Preis' zum Ticket
-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden
-- 13.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.zusatzinfo_sel_id AS flw_preis_id
   , MAX(CASE WHEN v03.spr_id =  22 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez   --standard=deutsch
   , MAX(CASE WHEN v03.spr_id = 124 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_cz
   , MAX(CASE WHEN v03.spr_id =  90 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_pl
   , MAX(CASE WHEN v03.spr_id = 108 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_sk
   , MAX(CASE WHEN v03.spr_id =  65 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_hr
   , MAX(CASE WHEN v03.spr_id =  95 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_ro
   , MAX(CASE WHEN v03.spr_id =  18 THEN v03.zusatzinfo_sel_bez ELSE NULL END) AS flw_preis_bez_bg

   FROM dbp_view.v_l_geku_zusatzinfo_sel_zu_1 v01

   -- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden
   INNER JOIN dbp_view.v_geku_zusatzinfo_spr_zu_1 v02
   ON  v01.zusatzinfo_id = v02.zusatzinfo_id

   -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden
   INNER JOIN dbp_view.v_geku_zusatzinfo_sel_spr_zu_1 v03
   ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id

   WHERE  v02.spr_id = 22 -- fix
   AND v02.zusatzinfo_bez = 'FLW Preis'

   GROUP BY v01.zusatzinfo_sel_id

   UNION ALL

   SELECT

   -1 AS  flw_preis_id
   , '' AS flw_preis_bez
   , '' AS flw_preis_bez_cz
   , '' AS flw_preis_bez_pl
   , '' AS flw_preis_bez_sk
   , '' AS flw_preis_bez_hr
   , '' AS flw_preis_bez_ro
   , '' AS flw_preis_bez_bg

   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1;