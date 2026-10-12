CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_IMMOBILIE_SPR_ZU_2
(
rpm_immobilie_id
,dat_von
,rpm_immobilie_bez
,rpm_immobilie_bez_cz
,rpm_immobilie_bez_sk
,rpm_immobilie_bez_hr
,rpm_immobilie_bez_pl
,rpm_immobilie_bez_ro
,rpm_immobilie_bez_en
,rpm_immobilie_bez_bg

)
AS
   SELECT
   v01.rpm_immobilie_id, v01.dat_von, MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END) AS rpm_immobilie_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v01.rpm_immobilie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.rpm_immobilie_bez ELSE NULL END)) AS rpm_immobilie_bez_bg    -- BG

   FROM dbp_view.v_rpm_immobilie_spr_zu_2 v01
   --WHERE
   --v01.spr_id = 22

   GROUP BY
   v01.rpm_immobilie_id
   ,v01.dat_von;