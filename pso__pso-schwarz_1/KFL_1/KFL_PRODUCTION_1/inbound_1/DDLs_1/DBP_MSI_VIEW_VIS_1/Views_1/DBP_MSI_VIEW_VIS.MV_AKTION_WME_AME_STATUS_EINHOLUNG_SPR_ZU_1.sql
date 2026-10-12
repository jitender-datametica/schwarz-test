CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_STATUS_EINHOLUNG_SPR_ZU_1

AS
--30.06.2020 snik1809 AP0029549-SPEC0068832

SELECT 
  mandant_id
 ,status_einholung_id
 ,Max(CASE WHEN spr_id =  22 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez   --standard=deutsch
 ,Max(CASE WHEN spr_id = 124 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_cz
 ,Max(CASE WHEN spr_id =  90 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_pl
 ,Max(CASE WHEN spr_id = 108 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_sk
 ,Max(CASE WHEN spr_id =  65 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_hr
 ,Max(CASE WHEN spr_id =  95 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_ro
 ,Max(CASE WHEN spr_id =  18 THEN status_einholung_bez ELSE NULL END)  AS status_einholung_bez_bg

FROM dbp_data.aktion_wme_ame_status_einholung_spr_zu_1

GROUP BY     
  mandant_id
 ,status_einholung_id;