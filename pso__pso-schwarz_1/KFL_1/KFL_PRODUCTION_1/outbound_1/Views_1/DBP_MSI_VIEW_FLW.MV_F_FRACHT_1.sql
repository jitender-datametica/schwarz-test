CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_fracht_1 (mandant_id, in_art_id, in_art_nr, werk_id, dat_lief
, dat_mat_bereitstllg, zeit_mat_bereitstllg, flw_tourart_id, in_kunde_id, verk_menge_einh_id, datenpool_satzart_id,
anz_kolli_produzier, komm_auftrag_status_id, handling_unit_id_ext, menge_produziert, lagernummer_id, menge_produziert_kg
, vol_einh_id, nettogew, gew_einh_id, vol, kolli_vol, vol_pal, lief_beleg_id, dat_leist_erstellung) AS SELECT V01.mandant_id
 ,
 V01.flw_art_id AS in_art_id,
 V02.flw_art_nr AS in_art_nr,
 V01.werk_id,
 V01.dat_lief,
 V01.dat_mat_bereitstllg,
 V01.zeit_mat_bereitstllg,
 COALESCE(V01.flw_tourart_id, '') AS flw_tourart_id,
 V01.flw_kunde_id AS in_kunde_id,
 V01.verk_menge_einh_id,
 V01.datenpool_satzart_id,
 V01.anz_kolli_produzier,
 V01.komm_auftrag_status_id,
 V01.handling_unit_id_ext,
 V01.menge_produziert,
 V01.lagernummer_id,
  CASE
  WHEN V02.basismenge_einh_id = 'ST'
  THEN V01.menge_produziert * V02.nettogew
  ELSE V01.menge_produziert
  END AS menge_produziert_kg,
 V02.vol_einh_id,
 V02.nettogew,
 V02.gew_einh_id,
 V02.vol,
 V01.kolli_vol,
   V03.vol * V04.nenner / V04.zaehler AS vol_pal,
 V01.lief_beleg_id,
 v06.dat_leist_erstellung
FROM kfl_production_dbp_view.v_flw_datenpool_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.flw_art_id_verpackung =
   V03.flw_art_id
 LEFT JOIN kfl_production_dbp_view.v_flw_einheiten_umrechnung_1 AS V04 ON V01.verp_menge_einh_id = V04.einh_id
 LEFT JOIN (SELECT lief_beleg_id,
   mandant_id,
   MAX(folge_beleg_id) AS folge_beleg_id
  FROM kfl_production_dbp_view.v_flw_faktura_belegfluss_1
  WHERE folge_beleg_typ_id = 'M'
  GROUP BY mandant_id,
   lief_beleg_id) AS v05 ON V01.lief_beleg_id = v05.lief_beleg_id AND V01.mandant_id = v05.mandant_id
 LEFT JOIN (SELECT faktura_beleg_id,
   mandant_id,
   MAX(dat_leist_erstellung) AS dat_leist_erstellung
  FROM kfl_production_dbp_view.v_flw_besch_faktura_det_1
  GROUP BY faktura_beleg_id,
   mandant_id) AS v06 ON v05.folge_beleg_id = v06.faktura_beleg_id AND v05.mandant_id = v06.mandant_id
WHERE V02.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND V01.mandant_id IN (1, 2);