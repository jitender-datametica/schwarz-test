CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GINFO_BAUFORM_SPR_ZU_2
(
ginfo_bauform_id
--,spr_id
,ginfo_bauform_bez
--,ginfo_bauform_bez_de
,ginfo_bauform_bez_cz
,ginfo_bauform_bez_sk
,ginfo_bauform_bez_hr
,ginfo_bauform_bez_pl
,ginfo_bauform_bez_ro
,ginfo_bauform_bez_en
,ginfo_bauform_bez_bg
)
AS
   SELECT
   ginfo_bauform_id, MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END) AS ginfo_bauform_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN ginfo_bauform_bez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN ginfo_bauform_bez ELSE NULL END)) AS ginfo_bauform_bez_bg    -- BG

   FROM dbp_view.v_ginfo_bauform_spr_zu_2

   GROUP BY
   ginfo_bauform_id;