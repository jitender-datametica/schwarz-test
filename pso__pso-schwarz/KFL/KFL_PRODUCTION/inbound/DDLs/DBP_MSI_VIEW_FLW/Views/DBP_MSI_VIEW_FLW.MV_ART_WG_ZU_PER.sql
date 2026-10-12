CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ART_WG_ZU_PER
-- 30.06.2011 Anpassung Join mit in_art anstatt CAST ueber art_id Spalte
-- 26.10.2011 system_id entfernt
-- 04.11.2011 Mdtfilter auf CZ erweitert
--  23.11.2011 Filterung auf art_id > 0 rausgenommen
-- 21.10.2013 twie: Join auf in_art jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
--=============================================================
-- ACHTUNG bei aenderungen: diese View wird von anderen MV-Views benutzt
--=============================================================
-- 25.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--                               Den alten Namen in_art_id fuer MSI ausgeben, da dort nicht umbenannt werden kann
--                               Zusaetzlich den neuen Namen flw_art_id fuer Join innerhalb von anderen Views
(
art_id
,in_art_id
,flw_art_id
,mandant_id
-- ,system_id
,arthiertyp_id
,wug_id
,wg_id
,dat_von
,dat_bis
)
AS
   SELECT
   v01.art_id, v03.flw_art_id AS in_art_id, v03.flw_art_id, v01.mandant_id, v01.arthiertyp_id, v01.wug_id, v01.wg_id, v01.dat_von, v01.dat_bis
   FROM dbp_view.v_art_wg_zu_per v01
   INNER JOIN dbp_view.v_art v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_msi_view_flw.mv_l_in_art v03     -- MARA + Retailartikel

   ON v03.art_id = v02.art_id
   AND v03.mandant_id = v02.mandant_id

   WHERE v01.arthiertyp_id = 2
   AND v01.mandant_id in (1,2)
   AND v02.dat_bis='9999-12-31'
   AND v01.dat_bis='9999-12-31';