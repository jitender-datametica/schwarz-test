CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_volumen_gedeckelt (tour_id, distribution_abr_fg,
belos_vorgang_id, wup_id, markt_id, mandant_id_kunde, mandant_id, dat_tour, lagernummer_id, sum_netto_vol,
sum_brutto_vol, sum_brtvol_gedeckelt, sum_netvol_gedeckelt) AS SELECT tour_id,
 distribution_abr_fg,
 belos_vorgang_id,
 wup_id,
 kunde_id AS markt_id,
 mandant_id_kunde,
 mandant_id,
 dat_tour,
 lagernummer_id,
 SUM(vol_ladung) AS sum_netto_vol,
 SUM(brtvol_ladung) AS sum_brutto_vol,
 SUM(brtvol_ladung_gedeckelt) AS sum_brtvol_gedeckelt,
 SUM(CASE
   WHEN vol_ladung > 2304
   THEN 2304
   ELSE vol_ladung
   END) AS sum_netvol_gedeckelt
FROM (SELECT DISTINCT V01.tour_id,
   V01.distribution_abr_fg,
   V03.belos_vorgang_id,
   V02.wup_id,
   COALESCE(V05.aktuell_wup_id, ROUND(CAST(SUBSTR(V03.kunde_id, 7, 4) AS BIGNUMERIC), 0)) AS kunde_id,
   V03.mandant_id_kunde,
   V02.mandant_id,
   V02.dat_tour,
   V01.lagernummer_id,
   V04.handling_unit_id,
   V04.vol_ladung,
   V04.brtvol_ladung,
   V04.brtvol_ladung_gedeckelt
  FROM kfl_production_dbp_view.v_belos_vorgang AS V01
   INNER JOIN kfl_production_dbp_view.v_tag AS T ON V01.dat_leistung = T.dat AND T.akt_kj >= - 3
   INNER JOIN kfl_production_dbp_view.v_tour AS V02 ON V01.tour_id = V02.tour_id AND V01.mandant_id = V02.mandant_id
   INNER JOIN kfl_production_dbp_view.v_besch_lief AS V03 ON V01.belos_vorgang_id = V03.belos_vorgang_id AND V01.mandant_id
      = V03.mandant_id
   INNER JOIN kfl_production_dbp_view.v_handling_unit AS V04 ON V03.lief_beleg_id = V04.lief_beleg_id AND V03.kj = V04.kj_lief_beleg
       AND V03.mandant_id = V04.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_wup AS V05 ON V05.mandant_id = CASE
       WHEN V03.mandant_id_kunde IS NULL OR V03.mandant_id_kunde = 0
       THEN V01.mandant_id
       ELSE V03.mandant_id_kunde
       END AND V05.wup_id = CASE
       WHEN ROUND(SAFE_CAST(V03.kunde_id AS BIGNUMERIC), 0) = 0
       THEN NULL
       ELSE ROUND(SAFE_CAST(V03.kunde_id AS BIGNUMERIC), 0)
       END AND V05.nb_id = 0) AS t1
GROUP BY tour_id,
 distribution_abr_fg,
 belos_vorgang_id,
 wup_id,
 markt_id,
 mandant_id_kunde,
 mandant_id,
 dat_tour,
 lagernummer_id,
 handling_unit_id,
 brtvol_ladung_gedeckelt;