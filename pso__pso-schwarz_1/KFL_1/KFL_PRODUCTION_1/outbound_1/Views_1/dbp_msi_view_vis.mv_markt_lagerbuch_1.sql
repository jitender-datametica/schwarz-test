CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_markt_lagerbuch_1 AS WITH LABU AS (SELECT mandant_id,
   nb_id,
   wup_id,
   art_id,
   stellplatz_nr,
   markt_lagerbereich_id,
   dat_mhd,
   dat_lagerbuch,
   betrag_vk_brutto,
   menge_lagerbestand_stellplatz,
   rate_verraeumung AS rate_verraeum,
   IF(rate_verraeumung = 0.00, 1, 0) AS rate_verraeum_000,
   IF(rate_verraeumung BETWEEN 0.01 AND 49.99, 1, 0) AS rate_verraeum_001,
   IF(rate_verraeumung BETWEEN 50.00 AND 79.99, 1, 0) AS rate_verraeum_050,
   IF(rate_verraeumung BETWEEN 80.00 AND 99.99, 1, 0) AS rate_verraeum_080,
   IF(rate_verraeumung = 100.00, 1, 0) AS rate_verraeum_100,
   dat_aenderung
  FROM kfl_production_dbp_view.v_markt_lagerbuch_1 AS LABU), PRIO AS (SELECT mandant_id,
   nb_id,
   wup_id,
   art_id,
   stellplatz_nr,
   markt_lagerbereich_id,
   dat_mhd,
   dat_lagerbuch,
   betrag_vk_brutto,
   MAX(IF(verraeumung_prio_grund_id = '00', 1, 0)) AS verraeum_grund_00,
   MAX(IF(verraeumung_prio_grund_id = '01', 1, 0)) AS verraeum_grund_01,
   MAX(IF(verraeumung_prio_grund_id = '02', 1, 0)) AS verraeum_grund_02,
   MAX(IF(verraeumung_prio_grund_id = '04', 1, 0)) AS verraeum_grund_04,
   MAX(IF(verraeumung_prio_grund_id = '05', 1, 0)) AS verraeum_grund_05,
   MAX(IF(verraeumung_prio_grund_id = '06', 1, 0)) AS verraeum_grund_06,
   MAX(IF(verraeumung_prio_grund_id = '12', 1, 0)) AS verraeum_grund_12,
   MAX(IF(verraeumung_prio_grund_id = '13', 1, 0)) AS verraeum_grund_13,
   MAX(IF(verraeumung_prio_grund_id = '50', 1, 0)) AS verraeum_grund_50,
   MAX(IF(verraeumung_prio_grund_id = '55', 1, 0)) AS verraeum_grund_55,
   MAX(IF(verraeumung_prio_grund_id = '60', 1, 0)) AS verraeum_grund_60,
   MAX(IF(verraeumung_prio_grund_id = '70', 1, 0)) AS verraeum_grund_70,
   MAX(IF(verraeumung_prio_grund_id = '80', 1, 0)) AS verraeum_grund_80,
               IF(MAX(IF(verraeumung_prio_grund_id = '00', 1, 0)) = 1, '00 ', '') || IF(MAX(IF(verraeumung_prio_grund_id
                     = '01', 1, 0)) = 1, '01 ', '') || IF(MAX(IF(verraeumung_prio_grund_id = '02', 1, 0)) = 1, '02 ', ''
               ) || IF(MAX(IF(verraeumung_prio_grund_id = '04', 1, 0)) = 1, '04 ', '') || IF(MAX(IF(verraeumung_prio_grund_id
                  = '05', 1, 0)) = 1, '05 ', '') || IF(MAX(IF(verraeumung_prio_grund_id = '06', 1, 0)) = 1, '06 ', '')
          || IF(MAX(IF(verraeumung_prio_grund_id = '12', 1, 0)) = 1, '12 ', '') || IF(MAX(IF(verraeumung_prio_grund_id =
              '13', 1, 0)) = 1, '13 ', '') || IF(MAX(IF(verraeumung_prio_grund_id = '50', 1, 0)) = 1, '50 ', '') || IF(MAX(IF(verraeumung_prio_grund_id
             = '55', 1, 0)) = 1, '55 ', '') || IF(MAX(IF(verraeumung_prio_grund_id = '60', 1, 0)) = 1, '60 ', '') || IF(MAX(IF(verraeumung_prio_grund_id
           = '70', 1, 0)) = 1, '70 ', '') || IF(MAX(IF(verraeumung_prio_grund_id = '80', 1, 0)) = 1, '80 ', '') AS
   verraeum_prio_gruende
  FROM kfl_production_dbp_view.v_markt_lagerbuch_verraeum_prio_grund_zu_1
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   art_id,
   stellplatz_nr,
   markt_lagerbereich_id,
   dat_mhd,
   dat_lagerbuch,
   betrag_vk_brutto) (SELECT t0.mandant_id,
   t0.nb_id,
   t0.wup_id,
   t0.art_id,
   t0.stellplatz_nr,
   t0.markt_lagerbereich_id,
   t0.dat_mhd,
   t0.dat_lagerbuch AS dat,
   KRS.nach_wrg_id AS wrg_id,
    t0.betrag_vk_brutto * KRS.umrechnungskurs AS betrag_vk_brutto,
   t0.menge_lagerbestand_stellplatz,
   t0.rate_verraeum,
   t0.rate_verraeum_000,
   t0.rate_verraeum_001,
   t0.rate_verraeum_050,
   t0.rate_verraeum_080,
   t0.rate_verraeum_100,
   t0.dat_lagerbuch,
   t0.dat_aenderung,
   t4.verraeum_grund_00,
   t4.verraeum_grund_01,
   t4.verraeum_grund_02,
   t4.verraeum_grund_04,
   t4.verraeum_grund_05,
   t4.verraeum_grund_06,
   t4.verraeum_grund_12,
   t4.verraeum_grund_13,
   t4.verraeum_grund_50,
   t4.verraeum_grund_55,
   t4.verraeum_grund_60,
   t4.verraeum_grund_70,
   t4.verraeum_grund_80,
   t4.verraeum_prio_gruende
  FROM LABU AS t0
   INNER JOIN PRIO AS t4 ON t0.mandant_id = t4.mandant_id AND t0.wup_id = t4.wup_id AND t0.art_id = t4.art_id AND t0.markt_lagerbereich_id
          = t4.markt_lagerbereich_id AND t0.stellplatz_nr = t4.stellplatz_nr AND t0.dat_lagerbuch = t4.dat_lagerbuch AND
      t0.dat_mhd = t4.dat_mhd AND t0.betrag_vk_brutto = t4.betrag_vk_brutto
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_zu_per_1 AS WRG_1 ON t0.mandant_id = WRG.mandant_id AND t0.dat_lagerbuch
     BETWEEN WRG.dat_von AND WRG.dat_bis
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 AS KRS ON WRG.wrg_id = KRS.von_wrg_id);