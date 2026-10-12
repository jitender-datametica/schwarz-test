CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_QUAL_MELDUNG_ART_DET_2 
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_2 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
   mandant_id,
   qual_meldung_id,
   in_art_id,
   kopf_fehlerpunkte
) AS
SELECT
   v01.mandant_id,
   v01.qual_meldung_id,
   v03.flw_art_id AS in_art_id,
   sum(
      (
         cast(anz_fehlerpunkte_pro_qm as NUMBER(38, 5)) / anz_best_pos
      )
   ) AS kopf_fehlerpunkte
FROM
   (
      SELECT
         qm.qual_meldung_id,
         qm.mandant_id,
         qm.best_beleg_id,
         case
            when sum(fehlerklasse_kennzahl_ber) > 100 then 100
            else sum(fehlerklasse_kennzahl_ber)
         end as anz_fehlerpunkte_pro_qm
      FROM
         dbp_view.v_flw_qual_meldung_2 qm
         INNER JOIN dbp_view.v_flw_qual_meldung_det_2 qmd ON qm.mandant_id = qmd.mandant_id
         AND qm.qual_meldung_id = qmd.qual_meldung_id
         INNER JOIN dbp_msi_view_flw.mv_l_flw_l_fehlerklasse_qual_2 fk ON qmd.fehlerklasse_id = fk.fehlerklasse_id
         AND qmd.mandant_id = fk.mandant_id
      GROUP BY
         qm.qual_meldung_id,
         qm.mandant_id,
         qm.best_beleg_id
   ) v01
   INNER JOIN dbp_view.v_flw_besch_best_2 v02 ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN (
      SELECT
         best_beleg_id,
         mandant_id,
         flw_art_id,
         sum(1) over (partition by best_beleg_id, mandant_id) anz_best_pos
      FROM
         dbp_view.v_flw_besch_best_det_2
   ) v03 ON v02.best_beleg_id = v03.best_beleg_id
   AND v02.mandant_id = v03.mandant_id
WHERE
   v02.einkaufsorganisation_id IN (5000, 5013, 5014)
GROUP BY
   v01.mandant_id,
   v01.qual_meldung_id,
   v03.flw_art_id;