CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_ZEITSPANNE_SPR_ZU
(
 zeitspanne_id
,zeitspanne_bez
,zeitspanne_bez_cz
,zeitspanne_bez_pl
,zeitspanne_bez_sk
,zeitspanne_bez_hr
,zeitspanne_bez_ro
,zeitspanne_bez_bg
)
AS
--lsvi0303: AP0043627, SPEC0055162 Atributt Einkaufszeit

SELECT 

  zeitspanne_id
 ,MAX(CASE WHEN spr_id =   22 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_bg

FROM dbp_view.v_mcx_zeitspanne_spr_zu

GROUP BY zeitspanne_id;