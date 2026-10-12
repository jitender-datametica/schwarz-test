CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_ZEITSPANNE_SPR_ZU
AS
-- 20200624 - snik1809

SELECT 
  zeitspanne_id
, Max(CASE WHEN spr_id =  22 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez   --standard=deutsch
, Max(CASE WHEN spr_id = 124 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_cz
, Max(CASE WHEN spr_id =  90 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_pl
, Max(CASE WHEN spr_id = 108 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_sk
, Max(CASE WHEN spr_id =  65 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_hr
, Max(CASE WHEN spr_id =  95 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_ro
, Max(CASE WHEN spr_id =  18 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_bg

FROM dbp_data.mcx_zeitspanne_spr_zu

GROUP BY zeitspanne_id;