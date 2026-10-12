CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_AKTION_2
-- 18.03.2014 twie: Join auf tag_2 entfernt, durch dat kam es zur Versiebenfachung der Werte
-- 14.04.2014 twie: Dummyaktion 0 pro Mandant_2 eingeführt, damit Daten ohne Aktion_2 nicht aus dem Bericht fallen
-- 02.07.2014 twie: Dummyaktion -1 pro Mandant_2 eingeführt, BED setzt nicht eindeutige aktion_id in Fakttabelle auf -1
-- 29.07.2014 srom: Anzahl Märkte herausgenommen, wird über Metrik auf Attribut in MSI umgesetzt
--                  dat_zeitraum mit reingenommen (bisher in aktion_art_wup_zu_2), damit mv_aktion_2 als reine lookup funktioniert
-- 14.03.2016 srom: Bisher hat ein Artikel_2, der nicht in Aktion_2 war, eine_2 "0" in der Spalte aktion_id. Nach der Änderung wird es blank (' ') sein.
-- 12.07.2016 srom: AP0009976 Werbeabschriften, Erweiterung Werbewoche
-- 17.08.2016 srom: AP0009976 Werbeabschriften, kjwo_von wurde nach aussen als ww_kjwo (Werbewoche) dargestellt, ist aber nicht wirklich die Werbewoche,
--                  sondern die Startwoche der Aktion_2
-- 25.08.2016 srom: sap_aktion_id nicht mehr benötigt
(
aktion_id
--,sap_aktion_id
,dat_von
,dat_bis
,mandant_id
,dat_zeitraum
--,anz
,kjwo_von


)
AS
   SELECT V01.AKTION_ID ,
       V01.DAT_VON ,
       V01.DAT_BIS ,
       V01.MANDANT_ID ,
       CAST (V01.DAT_VON AS VARCHAR) || ' - ' || CAST(V01.DAT_BIS AS VARCHAR) AS DAT_ZEITRAUM ,
            V01.KJWO_VON
FROM DBP_VIEW.V_AKTION_2 V01 /** 29.07.2014 srom
   LEFT OUTER JOIN

   (SELECT
   mandant_id
   ,aktion_id
   ,COUNT(DISTINCT wup_id ) anz
   FROM dbp_view.v_aktion_art_wup_zu_2
   WHERE grund_sperrung IS NULL
   GROUP BY 1,2)

   v99
   ON v99.mandant_id = v01.mandant_id
   AND v99.aktion_id   = v01.aktion_id

   WHERE v01.mandant_id <> 1
   **/ -- Dummyeinträge

UNION ALL
SELECT CAST('' AS CHAR(10)) AS AKTION_ID ,
       to_date('1900-01-01','YYYY-MM_2-DD') AS DAT_VON ,
       to_date('9999-12-31','YYYY-MM_2-DD') AS DAT_BIS ,
       MANDANT_ID ,
       CAST (DAT_VON AS VARCHAR) || ' - ' || CAST(DAT_BIS AS VARCHAR) AS DAT_ZEITRAUM ,
            190001 AS KJWO_VON
FROM DBP_VIEW.V_MANDANT_2
WHERE MANDANT_ID <> 1
UNION ALL
SELECT CAST('-1' AS CHAR(10)) AS AKTION_ID ,
       to_date('1900-01-01','YYYY-MM_2-DD') AS DAT_VON ,
       to_date('9999-12-31','YYYY-MM_2-DD') AS DAT_BIS ,
       MANDANT_ID ,
       CAST (DAT_VON AS VARCHAR) || ' - ' || CAST(DAT_BIS AS VARCHAR) AS DAT_ZEITRAUM ,
            190001 AS KJWO_VON
FROM DBP_VIEW.V_MANDANT_2
WHERE MANDANT_ID <> 1;