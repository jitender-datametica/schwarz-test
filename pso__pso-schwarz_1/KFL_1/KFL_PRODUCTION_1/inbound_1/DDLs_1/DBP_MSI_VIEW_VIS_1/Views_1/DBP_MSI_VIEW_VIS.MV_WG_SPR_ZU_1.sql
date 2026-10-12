CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WG_SPR_ZU_1 as
   -- SPRACHE : Warengruppen
   -- userabhaengige Bezeichnung
   -- 2010KW07: arthiertyp_1 2 für 3stellige WG
   -- 2011KW37: Internationalisierung (feste Sprache)
   -- 2015KW46: Erweiterung um alle WG, für Mehrsprachigkeit im CUBE
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, MAX(CASE WHEN spr_id =  22 THEN wg_bez END) AS wg_bez                -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN wg_bez END) AS wg_bez_de                         -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN wg_bez END), wg_bez_de) AS wg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN wg_bez END), wg_bez_de) AS wg_bez_bg    -- BG

   FROM dbp_view.v_wg_spr_zu_1  v01

   WHERE v01.arthiertyp_id = 2

   GROUP BY 1, 2, 3;