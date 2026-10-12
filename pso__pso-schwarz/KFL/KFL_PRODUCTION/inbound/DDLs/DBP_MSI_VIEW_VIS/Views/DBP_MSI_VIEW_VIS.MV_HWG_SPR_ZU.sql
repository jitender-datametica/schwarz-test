CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HWG_SPR_ZU as
   -- LOOKUP/Sprache : Hauptwarengruppe
   -- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
   -- 20150220 : Initial (BM 2.0)
   -- 2016KW04 : Vorbereitung Internationaliserung (Spalten)

   SELECT
   v01.mandant_id, v01.wg_hierarchie_id AS hwg_id, MAX(CASE WHEN spr_id =  22 THEN v02.wg_hierarchie_bez END) AS hwg_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN v02.wg_hierarchie_bez END) AS hwg_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN v02.wg_hierarchie_bez END), hwg_bez_de) AS hwg_bez_bg    -- BG

   FROM dbp_view.v_wg_hierarchie_zu_per  v01
   INNER JOIN dbp_view.v_wg_hierarchie_spr_zu  v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
   AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
   AND v02.arthiertyp_id = v01.arthiertyp_id

   WHERE v01.arthiertyp_id = 5
   AND v01.wg_hierarchie_ebene_id = 3 -- HWG
   AND v01.dat_bis = '9999-12-31'

   GROUP BY 1,2;