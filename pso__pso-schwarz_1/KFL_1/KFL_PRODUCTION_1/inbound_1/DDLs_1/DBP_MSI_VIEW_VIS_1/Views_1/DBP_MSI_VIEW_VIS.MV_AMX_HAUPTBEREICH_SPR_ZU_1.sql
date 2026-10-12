CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_HAUPTBEREICH_SPR_ZU_1
AS 
-- SPR_1 : KMR/AMX HauptBereich
-- 2019.2709 snik1809 VTC-KMR Redesign (Init)
-- 2019.1016 ssch0611 Bugfixing
-- 2020.0326 lsvi SPEC0073867 OneAudimex filter amx_system_id=1
SELECT 
  AMX.hauptbereich_id
, AMX.invers_ber_id
, Max(CASE WHEN MCX.spr_id =  22 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez    -- standard (DE)
, Max(CASE WHEN MCX.spr_id =  22 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez
, Max(CASE WHEN MCX.spr_id = 124 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_cz
, Max(CASE WHEN MCX.spr_id = 124 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_cz
, Max(CASE WHEN MCX.spr_id = 108 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_sk
, Max(CASE WHEN MCX.spr_id = 108 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_sk
, Max(CASE WHEN MCX.spr_id =  65 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_hr
, Max(CASE WHEN MCX.spr_id =  65 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_hr
, Max(CASE WHEN MCX.spr_id =  90 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_pl
, Max(CASE WHEN MCX.spr_id =  90 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_pl
, Max(CASE WHEN MCX.spr_id =  95 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_ro
, Max(CASE WHEN MCX.spr_id =  95 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_ro
, Max(CASE WHEN MCX.spr_id =  18 THEN MCX.invers_ber_bez ELSE NULL END)    AS hauptbereich_bez_bg
, Max(CASE WHEN MCX.spr_id =  18 THEN MCX.invers_ber_bez_2 ELSE NULL END)  AS hauptbereich_kbez_bg
FROM dbp_view.v_amx_hauptbereich_mcx_invers_bereich_zu_1 AMX
LEFT JOIN dbp_view.v_mcx_invers_bereich_spr_zu_1 MCX
ON AMX.invers_ber_id = MCX.invers_ber_id
WHERE AMX.amx_system_id=1
GROUP BY 
  AMX.hauptbereich_id
, AMX.invers_ber_id;