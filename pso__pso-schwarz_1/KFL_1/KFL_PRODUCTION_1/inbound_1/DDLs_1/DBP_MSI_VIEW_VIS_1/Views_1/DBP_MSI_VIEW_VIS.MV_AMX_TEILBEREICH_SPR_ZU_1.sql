CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_TEILBEREICH_SPR_ZU_1
AS 
-- SPR_1  KMRAMX teilbereich
-- 2019.2709 snik1809 VTC-KMR Redesign (Init)
-- 20200326 lsvi SPEC0073867 OneAudimex filter amx_system_id=1

SELECT 
  AMX.teilbereich_id
, AMX.invers_kat_id
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

FROM dbp_view.v_amx_teilbereich_mcx_invers_kategorie_zu_1 AMX

LEFT JOIN dbp_view.v_mcx_invers_kategorie_spr_zu_1 MCX
ON AMX.invers_kat_id = MCX.invers_kat_id

WHERE AMX.amx_system_id=1

GROUP BY 
  AMX.teilbereich_id
, AMX.invers_kat_id;