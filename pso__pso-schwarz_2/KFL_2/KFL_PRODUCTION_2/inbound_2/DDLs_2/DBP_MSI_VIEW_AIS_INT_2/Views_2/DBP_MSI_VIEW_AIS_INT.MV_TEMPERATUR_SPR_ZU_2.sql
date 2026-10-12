CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_TEMPERATUR_SPR_ZU_2
(
mandant_id
, temperatur_id
, temperatur_bez
, temperatur_bez_de
, temperatur_bez_cz
, temperatur_bez_sk
, temperatur_bez_hr
, temperatur_bez_pl
, temperatur_bez_ro
, temperatur_bez_bg
)
AS
   SELECT
   v01.mandant_id, v01.temperatur_id, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.temperatur_bez END),'N/A') AS temperatur_bez                                                          -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.temperatur_bez END),'N/A') AS temperatur_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.temperatur_bez END), temperatur_bez_de) AS temperatur_bez_bg  -- BG

   FROM dbp_view.v_temperatur_spr_zu_2 v01
   GROUP BY 1,2;