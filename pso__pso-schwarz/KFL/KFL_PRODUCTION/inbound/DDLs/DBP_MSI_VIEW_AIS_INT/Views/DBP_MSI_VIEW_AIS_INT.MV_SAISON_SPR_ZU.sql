CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SAISON_SPR_ZU
(
mandant_id
, saison_id
, saison_bez
, saison_bez_de
, saison_bez_cz
, saison_bez_sk
, saison_bez_hr
, saison_bez_pl
, saison_bez_ro
, saison_bez_bg
)
AS
   SELECT
   v01.mandant_id, v01.saison_id, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.saison_bez END),'N/A') AS saison_bez                                                          -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.saison_bez END),'N/A') AS saison_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.saison_bez END), saison_bez_de) AS saison_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.saison_bez END), saison_bez_de) AS saison_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.saison_bez END), saison_bez_de) AS saison_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.saison_bez END), saison_bez_de) AS saison_bez_bg  -- BG
   FROM dbp_view.v_saison_spr_zu v01
   GROUP BY 1,2;