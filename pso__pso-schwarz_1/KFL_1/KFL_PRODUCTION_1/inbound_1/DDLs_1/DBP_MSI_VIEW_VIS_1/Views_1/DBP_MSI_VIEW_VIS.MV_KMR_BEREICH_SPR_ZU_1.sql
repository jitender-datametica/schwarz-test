CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_BEREICH_SPR_ZU_1
-- 20180528 twie: SPEC0038139 Neuanlage Sprachview übergreifender Bereich in KMR
-- 20180625 ttod                 Bereich wird in DWH generiert, existiert nicht im Quellsystem

(
kmr_bereich_id
,kmr_bereich_bez
,kmr_bereich_bez_cz
,kmr_bereich_bez_pl
,kmr_bereich_bez_sk
,kmr_bereich_bez_hr
,kmr_bereich_bez_ro
,kmr_bereich_bez_bg
)
AS
   SELECT

   kmr_bereich_id, MAX(CASE WHEN spr_id =   22 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_cz, MAX(CASE WHEN spr_id =   90 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_pl, MAX(CASE WHEN spr_id = 108 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_sk, MAX(CASE WHEN spr_id =   65 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_hr, MAX(CASE WHEN spr_id =   95 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_ro, MAX(CASE WHEN spr_id =   18 THEN kmr_bereich_bez ELSE NULL END)  AS kmr_bereich_bez_bg

   FROM dbp_view.v_kmr_bereich_spr_zu_1

   GROUP BY kmr_bereich_id
   ;