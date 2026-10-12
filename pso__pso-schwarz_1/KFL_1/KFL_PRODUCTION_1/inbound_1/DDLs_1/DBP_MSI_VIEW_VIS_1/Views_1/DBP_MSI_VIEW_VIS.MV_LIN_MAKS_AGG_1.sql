CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_MAKS_AGG_1
-- SROM, 09.12.14: kjmo in Gruppierung bei Ermittlung anzahl_kurse
(
mandant_id
,wup_id
,ausbildung_id
,lin_kursgruppe_id
,kjmo
,lehrjahr
,bestanden
,mitarbeiter_in_lin_aktiv
,lernpensum_soll
,lehrjahr_monate
)
AS
   SELECT mandant_id,
   wup_id,
   ausbildung_id,
   lin_kursgruppe_id,
   kjmo,
   rate_group AS lehrjahr,
   SUM(learning_historie_fg) AS bestanden,
   COUNT(DISTINCT maks_id) AS mitarbeiter_in_lin_aktiv,
   AVG(sol_kurse_rel) AS lernpensum_soll,
   AVG(DISTINCT ausbildung_dauer_akt) AS lehrjahr_monate

   FROM
   (
   SELECT v01.mandant_id,
   v01.wup_id,
   v01.ausbildung_id,
   v02.lin_kursgruppe_id,
   v01.kjmo,
   v01.rate_group,
   v01.learning_historie_fg,
   v01.maks_id,
   datediff(day,dat_ausbildung_von, v03.max_dat) / 30.4 AS ausbildung_dauer_akt,
   datediff(day, dat_ausbildung_von, v01.dat_ausbildung_bis) - v02.pauschalabzug - v02.sonderabzug AS ausbildung_dauer_net,
   CASE WHEN ausbildung_dauer_akt * (v04.anzahl_kurse / ausbildung_dauer_net) > v04.anzahl_kurse
   THEN v04.anzahl_kurse
   ELSE ausbildung_dauer_akt * (v04.anzahl_kurse / ausbildung_dauer_net)
   END AS sol_kurse_rel
   FROM dbp_view.v_linbew_maks_1 v01
   LEFT JOIN (SELECT mandant_id,
   ausbildung_id,
   lin_kursgruppe_id,
   sonderabzug,
   pauschalabzug
   FROM dbp_msi_view_vis.mv_l_lin_taetigkeiten_1
   )v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.ausbildung_id = v02.ausbildung_id
   AND v01.wup_id BETWEEN 1 AND 8999
   LEFT JOIN dbp_view.v_monat_1 v03
   ON v01.kjmo = v03.kjmo
   LEFT JOIN (SELECT mandant_id,
   ausbildung_id,
   kjmo,
   CAST(COUNT(DISTINCT lin_kurs_id) AS DECIMAL(18,2)) AS anzahl_kurse
   FROM dbp_view.v_linbew_maks_1
   WHERE wup_id BETWEEN 1 AND 8999
   GROUP BY  mandant_id
   ,ausbildung_id
   ,kjmo
   )v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.ausbildung_id = v04.ausbildung_id
   AND v01.kjmo = v04.kjmo

   ) v05
   GROUP BY mandant_id
   ,wup_id
   ,ausbildung_id
   ,lin_kursgruppe_id
   ,kjmo
   ,lehrjahr;