CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BEDIENUNG_SPR_ZU
AS
   -- AL 18.10.2011 Gibt Ja, Nein als Ausprägung zurück
   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   CASE WHEN dat = CURRENT_DATE -1 THEN 1
   WHEN dat = CURRENT_DATE -2 THEN -1
   ELSE 0
   END AS bed_fg, CASE WHEN dat = CURRENT_DATE -1 THEN 'Ja'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'Nein'
   END::VARCHAR(4) AS bed_bez       --standard=deutsch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'Ja'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'Nein'
   END AS bed_bez_de     --deutsch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'Ano'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'ne'
   END::VARCHAR(4) AS bed_bez_cz    --tschechisch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'Tak'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'Nie'
   END::VARCHAR(4) AS bed_bez_pl      --polnisch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'áno'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'nie'
   END::VARCHAR(4) AS bed_bez_sk      --slowakisch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'Yes'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'No'
   END::VARCHAR(4) AS bed_bez_hr      --kroatisch
   , CASE WHEN dat = CURRENT_DATE -1 THEN 'Da'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE 'Nu'
   END::VARCHAR(4) AS bed_bez_ro      --rumänisch
   , CASE WHEN dat = CURRENT_DATE -1 THEN '\u0434\u0430'
   WHEN dat = CURRENT_DATE -2 THEN ''
   ELSE '\u041D\u0435'
   END::VARCHAR(4) AS bed_bez_bg  --bulgarisch
   FROM dbp_view.v_tag

   WHERE dat BETWEEN CURRENT_DATE -2 AND CURRENT_DATE;