CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_UNTER_KATEGORIE_SPR_ZU
-- 20180919 twie: SPE0043225 Neuanlage Sprachview übergreifende Unterkategorie in KMR
--                           Unterkategorie wird in DWH generiert, existiert nicht im Quellsystem
-- 20180926 twie: SPEC0043226
(
kmr_unter_kategorie_id
,kmr_unter_kategorie_bez
,kmr_unter_kategorie_bez_cz
,kmr_unter_kategorie_bez_pl
,kmr_unter_kategorie_bez_sk
,kmr_unter_kategorie_bez_hr
,kmr_unter_kategorie_bez_ro
,kmr_unter_kategorie_bez_bg
)
AS
   SELECT

   kmr_unter_kategorie_id, MAX(CASE WHEN spr_id =   22 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_cz, MAX(CASE WHEN spr_id =   90 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_pl, MAX(CASE WHEN spr_id = 108 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_sk, MAX(CASE WHEN spr_id =   65 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_hr, MAX(CASE WHEN spr_id =   95 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_ro, MAX(CASE WHEN spr_id =   18 THEN kmr_unter_kategorie_bez ELSE NULL END)  AS kmr_unter_kategorie_bez_bg

   FROM dbp_view.v_kmr_unter_kategorie_spr_zu

   GROUP BY kmr_unter_kategorie_id;