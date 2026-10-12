CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_IN_ART_SPR_ZU_1
(
mandant_id
--, system_id
, in_art_id
, spr_id
, art_bez
)
AS
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.spr_id, v01.art_bez

   FROM dbp_view.v_flw_art_spr_zu_1 v01

   JOIN dbp_view.v_flw_art_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id
   WHERE (v02.artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZHAW','ZFLV') OR v01.flw_art_id = -1)
   AND v01.mandant_id IN (1,2)

   UNION

   -- fehlende Fleischartikel, die es nicht im Industrie gibt

   SELECT

   v01.mandant_id, CASE WHEN v01.art_id < 0 THEN (v01.art_id * -1 + 10000000) ELSE v01.art_id * -1 END AS in_art_id, v01.spr_id, v01.art_bez

   FROM dbp_view.v_art_spr_zu_1 v01
   LEFT OUTER JOIN dbp_view.v_flw_art_1 v04
   ON v01.art_id  =v04.art_id
   AND v01.mandant_id = v04.mandant_id
   INNER JOIN dbp_view.v_art_wg_zu_per_1 v02
   ON  v01.art_id = v02.art_id
   AND  v01.mandant_id = v02.mandant_id
   WHERE v01.mandant_id IN (1,2)
   -- eindeutigen Datensatz aus art_wg_zu_per_1 ermitteln
   AND v02.dat_bis='9999-12-31'
   AND v02.arthiertyp_id = 2
   -- nur FLW Artikel_1
   -- Naku  Alte wg_id (1, 2, 3, 5, 9, 10, 12, 13, 19) durch neue laut Mapping Tabelle in SPEC0034878 ersetzt
   AND v02.wg_id IN (003,122,128,134,135,136,137,138,139,141,142,144,145,146,147,158,159,184,186,232,233,234,235,236,237,238,239,331,242,243,244,245,246)

   -- nur reine Retail Artikel_1
   AND v04.flw_art_id IS NULL;