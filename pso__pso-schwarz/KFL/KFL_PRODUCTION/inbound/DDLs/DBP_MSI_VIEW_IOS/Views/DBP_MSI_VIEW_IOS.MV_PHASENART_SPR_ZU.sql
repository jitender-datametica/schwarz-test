CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_PHASENART_SPR_ZU
(
phasenart_id
,cpr_phase_bez
,cpr_phase_bez_cz
,cpr_phase_bez_sk
,cpr_phase_bez_hr
,cpr_phase_bez_pl
,cpr_phase_bez_ro
,cpr_phase_bez_en
,cpr_phase_bez_bg
)
AS
   SELECT
  phasenart_id, MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END) AS cpr_phase_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN cpr_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_bg    -- BG


   FROM dbp_view.v_phasenart_spr_zu
   --WHERE
   --spr_id = 22;
   GROUP BY 1;