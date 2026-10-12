CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_lin_nonmaks_agg_2(
    mandant_id
    ,lin_kurs_id
    ,hr_objekt_id
    ,kjmo
    ,unternehmens_bereich_id
    ,anzahl_kurse_gesamt
    ,anzahl_kurse_abgeschlossen
    ,ki_fg
    ,wup_id
    ,kurs_ampel
    ,markt_ampel
 ) AS

    -- AP0008358, 05.04.2016, srom0404, In Quelltabelle wird Monat_2 durch Tag_2 abgelöst.
    -- Für Kurse <> GSL bleibt bisherige Monatssichtweise bestehen. Daten werden auf den letzten des Monats geladen
    -- Für Kurse = GSL wwerden tagesweise Daten geladen. Dargestellt wird immer der zuletzt geladene Tag_2 des Monats. Das wird in einer neuen View umgesetzt.
    -- Filter "AND unternehmens_bereich_id IN (10,11,'')" ausgebaut
    -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
   v01.mandant_id,
   v01.lin_kurs_id,
   v01.hr_objekt_id,
   v02.kjmo,
   v01.unternehmens_bereich_id,
   v01.anzahl_kurse_gesamt,
   v01.anzahl_kurse_abgeschlossen,
   v01.ki_fg,
   v01.wup_id,
   CASE
      WHEN CAST(anzahl_kurse_abgeschlossen AS DECIMAL(18,2))/ CAST(anzahl_kurse_gesamt AS DECIMAL(18,2)) < 0.795
         THEN 'rot'
      WHEN CAST(anzahl_kurse_abgeschlossen AS DECIMAL(18,2))/ CAST(anzahl_kurse_gesamt AS DECIMAL(18,2)) >= 0.895
         THEN 'gruen'
      ELSE 'gelb'
   END AS kurs_ampel,
   CASE 
      WHEN CAST(SUM(v01.anzahl_kurse_abgeschlossen) OVER (PARTITION BY v02.kjmo, v01.mandant_id, v01.wup_id) AS DECIMAL(18,2)) / CAST(COUNT(v01.lin_kurs_id) OVER (PARTITION BY v02.kjmo, v01.mandant_id, v01.wup_id) AS DECIMAL(18,2)) < 0.795
         THEN 'rot'
      WHEN CAST(SUM(v01.anzahl_kurse_abgeschlossen) OVER (PARTITION BY v02.kjmo, v01.mandant_id, v01.wup_id) AS DECIMAL(18,2)) / CAST(COUNT(v01.lin_kurs_id) OVER (PARTITION BY v02.kjmo, v01.mandant_id, v01.wup_id) AS DECIMAL(18,2)) >= 0.895
         THEN 'gruen'
      ELSE 'gelb'
   END AS markt_ampel
 FROM 
(
   SELECT
      v01.mandant_id
      , v01.lin_kurs_id
      , v01.hr_objekt_id
      , v01.dat
      , v01.unternehmens_bereich_id
      , v01.ki_fg
      , wup.aktuell_wup_id                      AS wup_id
      , SUM(v01.anzahl_kurse_gesamt)            AS anzahl_kurse_gesamt
      , SUM(v01.anzahl_kurse_abgeschlossen)     AS anzahl_kurse_abgeschlossen
   FROM dbp_view.v_linbew_nonmaks_2 v01

   INNER JOIN dbp_view.v_wup_2 wup_2
   ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
        
   WHERE v01.wup_id BETWEEN 1 AND 8999

   GROUP BY 
      v01.mandant_id
      , v01.lin_kurs_id
      , v01.hr_objekt_id
      , v01.dat
      , v01.unternehmens_bereich_id
      , v01.ki_fg
      , wup.aktuell_wup_id
) v01
        
INNER JOIN dbp_view.v_tag_2 v02
ON v01.dat = v02.dat
 
WHERE wup_id BETWEEN 1 AND 8999
 
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.lin_kurs_id, v01.hr_objekt_id, v01.wup_id, v01.unternehmens_bereich_id, v02.kjmo ORDER BY v01.dat DESC NULLS LAST) = 1
;
 