-- 28.08.2013 twie: Zuordnung VK_1 Datum zu Konditions Datum

-- Somit kann pro Artikel_1 vom dat_von aus Retail auf das dat aus Industrie gemappt werden.

-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- Es soll zum Datensatz aus art_pm_vw_zu_per_1 fuer den gleichen Artikel_1 der passende Datensatz in der kondit_det/kondit_freigabe gejoint werden.

-- Ist am gleichen Tag_1 aber kein Datensatz in der kondit_det vorhanden, wird der naechst juengere Datensatz gesucht und genommen.

-- spezielle Logik fuerr Bericht 01.05.01.10 DE VK_1-Preisentwicklung

-- 11.06.2014 twie: Filterung auf mandant_id = 1 entfernt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_vkpreis_abgn_dat_zu_1 AS -- Verkaufspreise aus Retail

-- Konditionen aus Industrie dazu, wenn vorhanden
 -- Ausschnitt aus der mv_f_kondit_det_1, ohne Fakten

-- Verbindung der beiden Tabellen ueber den Artikel_1
 SELECT VK.art_id,
 VK.mandant_id,
 VK.pm_id,
 VK.vw_id,
 VK.preistyp_id,
 VK.dat_von,
 kondit.dat
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS VK_1
 LEFT JOIN (SELECT V01.mandant_id,
   V04.art_id,
   T.dat,
   V02.preisliste_typ_id,
   V02.flw_vw_id,
    CASE
    WHEN V02.wrg_id = V100.default_wrg
    THEN 1
    ELSE 0
    END AS flag_landeswrg
  FROM kfl_production_dbp_view.v_flw_kondit_det_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_flw_kondit_freigabe_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kondition_id
       = V02.kondition_id AND V01.konditionsart_id = V02.konditionsart_id -- Retailartikel dazu, falls vorhanden

   LEFT JOIN kfl_production_dbp_view.v_flw_art_1 AS V04 ON V02.flw_art_id = V04.flw_art_id AND V02.mandant_id = V04.mandant_id
     
   INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN V02.dat_von AND V02.dat_bis) AS kondit ON VK.art_id =
   kondit.art_id AND VK.mandant_id = kondit.mandant_id
   -- fuer einen Retaildatensatz werden alle passenden Industriedatensaetze gesucht und der mit dem kleinsten Datum genommen

   
WHERE kondit.dat >= VK.dat_von -- der Industiedatensatz muss das gleiche oder ein groesseres Datum haben, als Retail

QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(VK.art_id AS STRING), CAST(VK.mandant_id AS STRING), CAST(VK.pm_id AS STRING)
          , CAST(VK.vw_id AS STRING), CAST(VK.preistyp_id AS STRING), VK.dat_von ORDER BY kondit.dat IS NULL, kondit.dat
          )) = 1 -- Filterungen im Bericht, nur fuer diese Datensaetze darf ein Datum gesucht werden
 AND kondit.flw_vw_id
       = 10 AND kondit.preisliste_typ_id = 'F0' AND kondit.flag_landeswrg = 1
    -- AND vk.mandant_id = 1 -- Bericht jetzt auch fuer CZ
 AND VK.preistyp_id = 0;