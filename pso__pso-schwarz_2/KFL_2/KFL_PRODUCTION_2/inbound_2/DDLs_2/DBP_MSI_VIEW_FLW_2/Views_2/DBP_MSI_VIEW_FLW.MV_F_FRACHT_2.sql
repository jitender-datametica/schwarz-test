CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FRACHT_2 --AL 27.06.2011 tourart_id  ''  als anstatt NULL, da Join Spalte
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 11.01.2018 twie: SPEC0018116 Ausgabe der lief_beleg_id und Ermittlung dat_leist_erstellung aus flw_besch_faktura_det_2 ueber die flw_faktura_belegfluss_2
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
(
   mandant_id --  ,system_id
,
   in_art_id,
   in_art_nr,
   werk_id,
   dat_lief,
   dat_mat_bereitstllg,
   zeit_mat_bereitstllg,
   flw_tourart_id,
   in_kunde_id,
   verk_menge_einh_id,
   datenpool_satzart_id,
   anz_kolli_produzier,
   komm_auftrag_status_id,
   handling_unit_id_ext,
   menge_produziert,
   lagernummer_id,
   menge_produziert_kg,
   vol_einh_id,
   nettogew,
   gew_einh_id,
   vol,
   kolli_vol,
   vol_pal,
   lief_beleg_id,
   dat_leist_erstellung
) AS
SELECT
   v01.mandant_id,
   v01.flw_art_id AS in_art_id,
   v02.flw_art_nr AS in_art_nr,
   v01.werk_id,
   v01.dat_lief,
   v01.dat_mat_bereitstllg,
   v01.zeit_mat_bereitstllg,
   COALESCE(v01.flw_tourart_id, ''),
   v01.flw_kunde_id AS in_kunde_id,
   v01.verk_menge_einh_id,
   v01.datenpool_satzart_id,
   v01.anz_kolli_produzier,
   v01.komm_auftrag_status_id,
   v01.handling_unit_id_ext,
   v01.menge_produziert,
   v01.lagernummer_id,
   CASE
      WHEN v02.basismenge_einh_id = 'ST' THEN v01.menge_produziert * v02.nettogew
      ELSE v01.menge_produziert
   END AS menge_produziert_kg,
   v02.vol_einh_id,
   v02.nettogew,
   v02.gew_einh_id,
   v02.vol,
   v01.kolli_vol,
   ((v03.vol * v04.nenner) / v04.zaehler) AS vol_pal,
   v01.lief_beleg_id,
   v06.dat_leist_erstellung
FROM
   dbp_view.v_flw_datenpool_2 v01 -- Volumenermittlung des Artikels
   JOIN dbp_view.v_flw_art_2 v02 ON v01.mandant_id = v02.mandant_id
   AND v01.flw_art_id = v02.flw_art_id -- Volumenermittlung der Verpackung
   JOIN dbp_view.v_flw_art_2 v03 ON v01.mandant_id = v03.mandant_id
   AND v01.flw_art_id_verpackung = v03.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_einheiten_umrechnung_2 v04 ON v01.verp_menge_einh_id = v04.einh_id
   LEFT OUTER JOIN (
      SELECT
         lief_beleg_id,
         mandant_id,
         MAX(folge_beleg_id) AS folge_beleg_id
      FROM
         dbp_view.v_flw_faktura_belegfluss_2
      WHERE
         folge_beleg_typ_id = 'M'
      GROUP BY
         1,
         2 --genau eine_2 Zeile pro Lieferbeleg, damit keine Vervielfaeltigung in der View
   ) v05 ON v01.lief_beleg_id = v05.lief_beleg_id
   AND v01.mandant_id = v05.mandant_id
   LEFT OUTER JOIN (
      SELECT
         faktura_beleg_id,
         mandant_id,
         MAX(dat_leist_erstellung) AS dat_leist_erstellung
      FROM
         dbp_view.v_flw_besch_faktura_det_2
      GROUP BY
         1,
         2 --genau eine_2 Zeile pro Fakturabeleg, damit keine Vervielfaeltigung in der View
   ) v06 ON v05.folge_beleg_id = v06.faktura_beleg_id
   AND v05.mandant_id = v06.mandant_id
WHERE
   v02.artikelart_id IN (
      'ZKMN',
      'HALB',
      'ZERL',
      'ZFER',
      'ROH',
      'VERP',
      'FERT',
      'HAWA',
      'ZDIE',
      'REWO',
      'ZHAW',
      'ZFLV'
   )
   AND v01.mandant_id IN (1, 2);