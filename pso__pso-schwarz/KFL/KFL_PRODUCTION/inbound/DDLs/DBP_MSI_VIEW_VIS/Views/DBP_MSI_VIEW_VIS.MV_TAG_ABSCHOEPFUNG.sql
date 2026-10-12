CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TAG_ABSCHOEPFUNG as
   -- ZEIT/STRUKTUR Geldabschoepfungsquote Tage, Woche, Monat
   -- 2012KW12PU Initial
   -- 2012KW19 Update/Final
   -- 2012KW25 Trend um akt. Tag erweitert

   SELECT
   akt_tag AS sort_id, dat AS dat_von, dat AS dat_bis, (CASE WHEN wtag_id = 1 THEN 'Mo'
   WHEN wtag_id = 2 THEN 'Di'
   WHEN wtag_id = 3 THEN 'Mi'
   WHEN wtag_id = 4 THEN 'Do'
   WHEN wtag_id = 5 THEN 'Fr'
   WHEN wtag_id = 6 THEN 'Sa'
   WHEN wtag_id = 7 THEN 'So'
   ELSE ''
   END::VARCHAR(3)) || ' ' ||
   (TO_CHAR(EXTRACT(DAY FROM dat), '00')) ||'.'|| (TO_CHAR(EXTRACT(MONTH FROM dat), '00')) ||'.'|| (TO_CHAR(EXTRACT(YEAR FROM dat), '0000'))::VARCHAR(40) AS dat_bez
   FROM dbp_view.v_tag
   WHERE akt_tag BETWEEN -6 AND 0 -- 7 Tage rollierend

   UNION ALL
   SELECT
   1 AS sort_id, MIN(dat) AS dat_von, MAX(dat) AS dat_bis, 'Trend' AS dat_bez
   FROM dbp_view.v_tag
   WHERE akt_tag BETWEEN -6 AND -0  -- Woche inkl. akt Tag für Trend

   UNION ALL
   SELECT
   11 AS sort_id, dat_von, dat_bis, 'Woche ' || (TO_CHAR(EXTRACT(DAY FROM dat_von), '00')) ||'.'|| (TO_CHAR(EXTRACT(MONTH FROM dat_von), '00')) ||'. - ' ||
   (TO_CHAR(EXTRACT(DAY FROM dat_bis), '00')) ||'.'|| (TO_CHAR(EXTRACT(MONTH FROM dat_bis), '00')) ||'.'|| (TO_CHAR(EXTRACT(YEAR FROM dat_bis), '0000')) AS dat_bez
   FROM (
   SELECT
   MIN(dat) AS dat_von, MAX(dat) AS dat_bis
   FROM dbp_view.v_tag
   WHERE akt_tag BETWEEN -6 AND 0 -- Woche = 7 Tage rollierend
   ) sub01

   UNION ALL
   SELECT
   22 AS sort_id, dat_von, dat_bis, 'Monat aufg. ' || (TO_CHAR(EXTRACT(DAY FROM dat_von), '00')) ||'.'|| (TO_CHAR(EXTRACT(MONTH FROM dat_von), '00')) ||'. - ' ||
   (TO_CHAR(EXTRACT(DAY FROM dat_bis), '00')) ||'.'|| (TO_CHAR(EXTRACT(MONTH FROM dat_bis), '00')) ||'.'|| (TO_CHAR(EXTRACT(YEAR FROM dat_bis), '0000')) AS dat_bez
   FROM (
   SELECT
   MIN(dat) AS dat_von, MAX(dat) AS dat_bis
   FROM dbp_view.v_tag
   WHERE akt_mo = 0 AND akt_tag <=0 -- Monat akt. bis akt. Tag
   ) sub01
;