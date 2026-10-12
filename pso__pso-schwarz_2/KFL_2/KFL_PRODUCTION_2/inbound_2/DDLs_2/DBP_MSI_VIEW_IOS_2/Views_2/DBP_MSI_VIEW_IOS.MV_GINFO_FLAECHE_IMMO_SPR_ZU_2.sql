CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GINFO_FLAECHE_IMMO_SPR_ZU_2
(
ginfo_flaeche_id
,ginfo_flaeche_typ_id
,mandant_id
--,spr_id
--,ginfo_flaeche_bez
,techn_platz_id
,ginfo_flaeche_bez
--,ginfo_flaeche_bez_de
,ginfo_flaeche_bez_cz
,ginfo_flaeche_bez_sk
,ginfo_flaeche_bez_hr
,ginfo_flaeche_bez_pl
,ginfo_flaeche_bez_ro
,ginfo_flaeche_bez_en
,ginfo_flaeche_bez_bg

)
AS
   SELECT
   ginfo_flaeche_id, ginfo_flaeche_typ_id, mandant_id, techn_platz_id, MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END) AS ginfo_flaeche_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN ginfo_flaeche_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_bez ELSE NULL END)) AS ginfo_flaeche_bez_bg    -- BG

   FROM dbp_view.v_ginfo_flaeche_spr_zu_2
   WHERE flaeche_quelle_id  IN (2)

   GROUP BY
   ginfo_flaeche_id
   ,ginfo_flaeche_typ_id
   ,mandant_id
   --,spr_id
   --,ginfo_flaeche_bez
   ,techn_platz_id;