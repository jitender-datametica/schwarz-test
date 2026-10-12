CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_INVERS_TEILBEREICH_SPR_ZU
AS
-- SPR : KMR/AMX Teilbereich (invers)
-- 2020.07.09 ssch0611: Initial (AP0044665)

SELECT
AMX.invers_kat_id
, Max(CASE WHEN MCX.spr_id =  22 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez    -- standard (DE)
, Max(CASE WHEN MCX.spr_id =  22 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez
, Max(CASE WHEN MCX.spr_id = 124 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_cz
, Max(CASE WHEN MCX.spr_id = 124 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_cz
, Max(CASE WHEN MCX.spr_id = 108 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_sk
, Max(CASE WHEN MCX.spr_id = 108 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_sk
, Max(CASE WHEN MCX.spr_id =  65 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_hr
, Max(CASE WHEN MCX.spr_id =  22 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_hr
, Max(CASE WHEN MCX.spr_id =  90 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_pl
, Max(CASE WHEN MCX.spr_id =  90 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_pl
, Max(CASE WHEN MCX.spr_id =  95 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_ro
, Max(CASE WHEN MCX.spr_id =  95 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_ro
, Max(CASE WHEN MCX.spr_id =  18 THEN MCX.invers_kat_bez ELSE NULL END)    AS teilbereich_bez_bg
, Max(CASE WHEN MCX.spr_id =  18 THEN MCX.invers_kat_bez_2 ELSE NULL END)  AS teilbereich_kbez_bg

FROM dbp_view.v_amx_teilbereich_mcx_invers_kategorie_zu AMX

LEFT JOIN dbp_view.v_mcx_invers_kategorie_spr_zu MCX
ON AMX.invers_kat_id = MCX.invers_kat_id

WHERE AMX.amx_system_id=1

GROUP BY AMX.invers_kat_id;