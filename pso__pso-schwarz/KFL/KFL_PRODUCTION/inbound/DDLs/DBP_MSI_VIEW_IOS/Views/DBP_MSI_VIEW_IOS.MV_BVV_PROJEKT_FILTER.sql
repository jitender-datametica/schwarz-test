CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_PROJEKT_FILTER as
   -- LOOKUP/SPRACHE : Projektfilter aus bvv_projekt
   -- 20160317 ssch0611: initial
   -- 20160414 ssch0611: Review

   SELECT
   akt_tag::byteint  AS projekt_filter_id, CASE projekt_filter_id
   WHEN  0 THEN 'Aktuell'
   WHEN  1 THEN 'Abgeschlossen'
   WHEN  2 THEN 'Abgebrochen'
   WHEN  3 THEN 'Unvollstaendig'
   -- WHEN  4 THEN 'Zukuenftig'
   END
   ::VARCHAR(40) AS projekt_filter_bez
   FROM dbp_view.v_tag
   WHERE akt_tag between 0 and 3;