CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_FLAECHE_TYP_PLOT_SPR_ZU
(
ginfo_flaeche_typ_id
--,spr_id
,mandant_id
,ginfo_flaeche_typ_bez
--,ginfo_flaeche_typ_bez_de
,ginfo_flaeche_typ_bez_cz
,ginfo_flaeche_typ_bez_sk
,ginfo_flaeche_typ_bez_hr
,ginfo_flaeche_typ_bez_pl
,ginfo_flaeche_typ_bez_ro
,ginfo_flaeche_typ_bez_en
,ginfo_flaeche_typ_bez_bg

)
AS
   SELECT
   ginfo_flaeche_typ_id, mandant_id, MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END) AS ginfo_flaeche_typ_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN ginfo_flaeche_typ_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN ginfo_flaeche_typ_bez ELSE NULL END)) AS ginfo_flaeche_typ_bez_bg    -- BG


   FROM dbp_view.v_ginfo_flaeche_typ_spr_zu
   WHERE flaeche_quelle_id  = 1

   GROUP BY  ginfo_flaeche_typ_id
   ,mandant_id;