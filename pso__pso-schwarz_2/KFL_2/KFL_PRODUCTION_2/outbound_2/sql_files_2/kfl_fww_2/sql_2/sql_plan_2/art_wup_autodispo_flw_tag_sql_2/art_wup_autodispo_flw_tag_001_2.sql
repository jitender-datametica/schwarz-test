--13.02.2025


DROP TABLE IF EXISTS dbp_etl.art_wup_autodispo_flw_gp_temp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_autodispo_flw_gp_temp_2 (
mandant_id INTEGER,
gp_id INTEGER
);


INSERT INTO dbp_etl.art_wup_autodispo_flw_gp_temp_2
(SELECT mandant_id,
  gp_id
 FROM dbp_data.gp_2
 WHERE gp_id IN (6912, 6922, 6916)
  AND mandant_id = 1);


DROP TABLE IF EXISTS dbp_etl.art_wup_autodispo_flw_tag_temp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_autodispo_flw_tag_temp_2 (
mandant_id INTEGER NOT NULL,
kunde_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id_kunde INTEGER NOT NULL,
nb_id_lieferant INTEGER NOT NULL,
art_id INTEGER NOT NULL,
dat DATE NOT NULL,
we_bearbeitungszeit INTEGER,
planlieferzeit INTEGER,
kdis INTEGER,
verkaufslistung_fg INTEGER,
sa_af_fg INTEGER,
udf_prognose_menge_ungesteuert NUMERIC(29,3),
udf_prognose_menge_gesteuert NUMERIC(29,3),
fur_prognose_menge_ungesteuert NUMERIC(29,3),
fur_prognose_menge_gesteuert NUMERIC(29,3),
fur_prognose_menge_max NUMERIC(29,3),
menge_abverkauf NUMERIC(29,3),
ret_bestand NUMERIC(29,3),
fur_bestand NUMERIC(29,3),
menge_we_offen NUMERIC(29,3),
menge_bv NUMERIC(29,3),
menge_ofc NUMERIC(29,3),
nullbestand_fg INTEGER,
menge_preisabschriften NUMERIC(29,3),
menge_totalabschriften NUMERIC(29,3),
kollifaktor NUMERIC(29,3),
egalisierungsfaktor NUMERIC(29,7),
menge_einh_id STRING(3) COLLATE 'und:ci',
servicelevel NUMERIC(29,2),
optik NUMERIC(29,6),
menge_we NUMERIC(29,3),
basismenge_einh_id STRING(3) COLLATE 'und:ci',
vk_brutto NUMERIC(29,3),
umrech_faktor_marm NUMERIC(29,7),
umrech_faktor_ef NUMERIC(29,7),
wg_id INTEGER,
bezugsvorschrift_kz STRING(1) COLLATE 'und:ci',
marc_kdis INTEGER DEFAULT - 1,
marc_dat_von DATE,
ordersatz_dat_von DATE,
vklist_dat_von DATE,
vklist_anz_schliesstage INTEGER,
bewart_id_fg STRING(2) COLLATE 'und:ci',
nullbestand_exc_fg INTEGER DEFAULT 0,
art_id_display INTEGER,
menge_we_geplant NUMERIC(29,3),
komponentenmenge NUMERIC(29,4),
best_anz_schliesstage INTEGER,
dat_best DATE
);


INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_temp_2 (mandant_id, kunde_id, wup_id, nb_id_kunde,
 nb_id_lieferant, art_id, dat, sa_af_fg, kollifaktor, basismenge_einh_id, vk_brutto, umrech_faktor_marm,
 umrech_faktor_ef, wg_id, marc_kdis, marc_dat_von)
(SELECT DISTINCT EORD.mandant_id,
  EORD.wup_id AS kunde_id,
  EORD.vz_wup_id AS wup_id,
  EORD.nb_id AS nb_id_kunde,
  - 111 AS nb_id_lieferant,
  EORD.art_id,
  TAG.dat,
  0 AS sa_af_fg,
  CAST(kolli.faktor_kolli AS NUMERIC) AS faktor_kolli,
  MARA.basismenge_einh_id,
  VKBR.vk_brutto,
  CAST(MARM.umrech_faktor AS NUMERIC) AS umrech_faktor_marm,
  CAST(EF.umrech_faktor AS NUMERIC) AS umrech_faktor_ef,
  WG.wg_id,
  MARC.kdis AS marc_kdis,
  MARC.dat_von AS marc_dat_von
 FROM dbp_data.ek_orderbuch_2 AS EORD_2
  INNER JOIN dbp_data.tag_2 AS TAG_2 ON TRUE
  INNER JOIN dbp_data.art_2 AS MARA_2 ON EORD.mandant_id = MARA.mandant_id AND EORD.art_id = MARA.art_id
  INNER JOIN dbp_data.art_wup_zu_per_2 AS VKBR ON EORD.mandant_id = VKBR.mandant_id AND EORD.art_id = VKBR
      .art_id AND EORD.wup_id = VKBR.wup_id AND TAG.dat BETWEEN VKBR.dat_von AND VKBR.dat_bis
  INNER JOIN dbp_data.art_umrechnung_faktor_per_2 AS MARM_2 ON MARA.mandant_id = MARM.mandant_id AND MARA.art_id
        = MARM.art_id AND TAG.dat BETWEEN MARM.dat_von AND MARM.dat_bis AND MARM.gew_einh_id = 'KG' AND MARM.altnv_menge_einh_id
     = 'ST'
  INNER JOIN dbp_data.art_umrechnung_faktor_per_2 AS EF ON EORD.mandant_id = EF.mandant_id AND EORD.art_id
       = EF.art_id AND TAG.dat BETWEEN EF.dat_von AND EF.dat_bis AND EF.altnv_menge_einh_id = 'KG' AND EF.gew_einh_id =
    'KG'
  INNER JOIN (SELECT MAW1.mandant_id,
    TAG0.dat,
    MAW1.art_id,
    MAW1.ausg_menge_einh_id AS einh_kolli,
     CASE
     WHEN MARM_KOL.umrech_zaehler IS NOT NULL AND MARM_KOL.umrech_nenner IS NOT NULL
     THEN MARM_KOL.umrech_zaehler / MARM_KOL.umrech_nenner
     ELSE 1
     END AS faktor_kolli
   FROM dbp_data.art_vorschlagswert_per_2 AS MAW1_2
    INNER JOIN dbp_data.tag_2 AS TAG0 ON TRUE
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS MARM_KOL ON TAG0.dat BETWEEN MARM_KOL.dat_von AND
        MARM_KOL.dat_bis AND MAW1.ausg_menge_einh_id = MARM_KOL.altnv_menge_einh_id AND MAW1.mandant_id = MARM_KOL.mandant_id
        AND MAW1.art_id = MARM_KOL.art_id
   WHERE TAG0.dat BETWEEN MAW1.dat_von AND MAW1.dat_bis
    AND TAG0.dat BETWEEN ${DAT_VON} AND ${DAT_BIS}) AS kolli ON EORD.mandant_id = kolli.mandant_id AND EORD.art_id =
     kolli.art_id AND TAG.dat = kolli.dat
  INNER JOIN dbp_data.art_wg_zu_per_2 AS WG ON EORD.mandant_id = WG.mandant_id AND EORD.art_id = WG.art_id
    AND TAG.dat BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
  INNER JOIN dbp_data.art_wup_status_per_2 AS MARC_2 ON EORD.mandant_id = MARC.mandant_id AND EORD.art_id =
      MARC.art_id AND EORD.wup_id = MARC.wup_id AND TAG.dat BETWEEN MARC.dat_von AND MARC.dat_bis
  INNER JOIN dbp_etl.art_wup_autodispo_flw_gp_temp_2 AS FLW_GP ON EORD.mandant_id = FLW_GP.mandant_id AND
    EORD.gp_id = FLW_GP.gp_id
 WHERE TAG.dat BETWEEN EORD.dat_von AND EORD.dat_bis
  AND EORD.nb_id = 0
  AND TAG.dat BETWEEN ${DAT_VON} AND ${DAT_BIS}
  AND (EORD.mandant_id, WG.wg_id) IN (SELECT (mandant_id, wg_id)
    FROM dbp_data.wg_filter_zu_2
    WHERE wg_filter_id = 51));


INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_temp_2 (mandant_id, kunde_id, wup_id, nb_id_kunde,
 nb_id_lieferant, art_id, dat, sa_af_fg, kollifaktor, basismenge_einh_id, umrech_faktor_marm, umrech_faktor_ef, wg_id,
 art_id_display)
(SELECT ZE1WBB06.mandant_id,
  ZE1WBB06.wup_id AS kunde_id,
   CASE
   WHEN ZE1WBB06_VZ.auslieferungsgruppe_id = 'DFV'
   THEN COALESCE(ZE1WBB06_DISP.gp_id, ZE1WBB06.gp_id)
   ELSE ZE1WBB06.gp_id
   END AS wup_id,
  ZE1WBB06.nb_id AS nb_id_kunde,
  - 111 AS nb_id_lieferant,
  ZE1WBB06.art_id,
  TAG.dat,
  0 AS sa_af_fg,
  CAST(CASE
    WHEN MARM_KOL.umrech_zaehler IS NOT NULL AND MARM_KOL.umrech_nenner IS NOT NULL
    THEN MARM_KOL.umrech_zaehler / MARM_KOL.umrech_nenner
    ELSE 1
    END AS NUMERIC) AS faktor_kolli,
  MARA.basismenge_einh_id,
  1 AS umrech_faktor_marm,
  1 AS umrech_faktor_ef,
  WG.wg_id,
  MAX(ZE1WBB06_DISP.art_id) AS art_id_display
 FROM dbp_data.art_gp_wup_dts_zu_per_2 AS ZE1WBB06
  INNER JOIN dbp_data.tag_2 AS TAG_2 ON TAG.dat BETWEEN ZE1WBB06.dat_von AND ZE1WBB06.dat_bis
  INNER JOIN dbp_data.art_wg_zu_per_2 AS WG ON ZE1WBB06.mandant_id = WG.mandant_id AND ZE1WBB06.art_id = WG
      .art_id AND TAG.dat BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
  INNER JOIN dbp_data.wg_per_2 AS WG_PER_2 ON WG.mandant_id = WG_PER.mandant_id AND WG.wg_id = WG_PER.wg_id
    AND TAG.dat BETWEEN WG_PER.dat_von AND WG_PER.dat_bis AND WG_PER.arthiertyp_id = 2
  INNER JOIN dbp_data.owg_per_2 AS OWG_PER_2 ON WG_PER.mandant_id = OWG_PER.mandant_id AND WG_PER.owg_id =
      OWG_PER.owg_id AND TAG.dat BETWEEN OWG_PER.dat_von AND OWG_PER.dat_bis AND OWG_PER.arthiertyp_id = 2
  INNER JOIN dbp_data.art_2 AS MARA_2 ON ZE1WBB06.mandant_id = MARA.mandant_id AND ZE1WBB06.art_id = MARA.art_id
    
  INNER JOIN dbp_data.art_vorschlagswert_per_2 AS MAW1_2 ON MARA.mandant_id = MAW1.mandant_id AND MARA.art_id
      = MAW1.art_id AND TAG.dat BETWEEN MAW1.dat_von AND MAW1.dat_bis
  LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS MARM_KOL ON TAG.dat BETWEEN MARM_KOL.dat_von AND
      MARM_KOL.dat_bis AND MAW1.ausg_menge_einh_id = MARM_KOL.altnv_menge_einh_id AND MAW1.mandant_id = MARM_KOL.mandant_id
      AND MAW1.art_id = MARM_KOL.art_id
  LEFT JOIN dbp_data.stueckliste_det_2 AS STPO_2 ON ZE1WBB06.mandant_id = STPO.mandant_id AND ZE1WBB06.art_id
       = STPO.art_id AND STPO.mandant_id = 1 AND TAG.dat BETWEEN STPO.dat_von AND STPO.dat_bis
  LEFT JOIN dbp_data.stueckliste_2 AS MAST_2 ON STPO.mandant_id = MAST.mandant_id AND STPO.stueckliste_id =
    MAST.stueckliste_id
  LEFT JOIN dbp_data.art_gp_wup_dts_zu_per_2 AS ZE1WBB06_DISP ON MAST.mandant_id = STPO.mandant_id AND MAST_2
      .art_id = ZE1WBB06_DISP.art_id AND ZE1WBB06.wup_id = ZE1WBB06_DISP.wup_id AND TAG.dat BETWEEN ZE1WBB06_DISP.dat_von
    AND ZE1WBB06_DISP.dat_bis
  LEFT JOIN dbp_data.art_gp_wup_dts_zu_per_2 AS ZE1WBB06_VZ ON ZE1WBB06_VZ.auslieferungsgruppe_id = 'DFV'
      AND STPO.mandant_id = ZE1WBB06_VZ.mandant_id AND ZE1WBB06.art_id = ZE1WBB06_VZ.art_id AND ZE1WBB06_DISP.gp_id =
     ZE1WBB06_VZ.wup_id AND TAG.dat BETWEEN ZE1WBB06_VZ.dat_von AND ZE1WBB06_VZ.dat_bis
 WHERE TAG.dat BETWEEN ${DAT_VON} AND ${DAT_BIS}
  AND ZE1WBB06.nb_id = 0
  AND (ZE1WBB06.auslieferungsgruppe_id <> 'VEN' OR ZE1WBB06_VZ.auslieferungsgruppe_id = 'DFV')
  AND ZE1WBB06.loesch_fg = 0
  AND OWG_PER.hwg_id IN (60, 61, 64)
  AND NOT EXISTS (SELECT 1
   FROM dbp_data.wg_filter_zu_2 AS WGF
   WHERE wg_filter_id = 51
    AND ZE1WBB06.mandant_id = mandant_id
    AND wg_id = WG.wg_id)
 GROUP BY ZE1WBB06.mandant_id,
  kunde_id,
  wup_id,
  nb_id_kunde,
  nb_id_lieferant,
  ZE1WBB06.art_id,
  TAG.dat,
  MARA.basismenge_einh_id,
  umrech_faktor_marm,
  umrech_faktor_ef,
  faktor_kolli,
  WG.wg_id,
  sa_af_fg);


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TMP SET
 vk_brutto = VKBR.vk_brutto FROM dbp_data.art_wup_zu_per_2 AS VKBR
WHERE VKBR.mandant_id = TMP.mandant_id AND VKBR.art_id = TMP.art_id AND VKBR.wup_id = TMP.kunde_id AND TMP.dat BETWEEN
   VKBR.dat_von AND VKBR.dat_bis AND NOT EXISTS (SELECT 1
  FROM dbp_data.wg_filter_zu_2 AS WGF
  WHERE wg_filter_id = 51
   AND TMP.mandant_id = mandant_id
   AND wg_id = TMP.wg_id);


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TMP SET
 marc_kdis = MARC.kdis,
 marc_dat_von = MARC.dat_von FROM dbp_data.art_wup_status_per_2 AS MARC_2
WHERE MARC.mandant_id = TMP.mandant_id AND MARC.art_id = TMP.art_id AND MARC.wup_id = TMP.kunde_id AND TMP.dat BETWEEN
   MARC.dat_von AND MARC.dat_bis AND NOT EXISTS (SELECT 1
  FROM dbp_data.wg_filter_zu_2 AS WGF
  WHERE wg_filter_id = 51
   AND TMP.mandant_id = mandant_id
   AND wg_id = TMP.wg_id);


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 bezugsvorschrift_kz = tbl.bezugsvorschrift_kz,
 ordersatz_dat_von = tbl.dat_von FROM (SELECT TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   TEMP.kdis,
   ordersatz.bezugsvorschrift_kz,
   ordersatz.dat_von
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN (SELECT mandant_id,
     wup_id,
     art_id,
     dat_von,
     COALESCE(MAX(DATE_SUB(dat_von, INTERVAL 1 DAY)) OVER (PARTITION BY mandant_id, wup_id, art_id ORDER BY dat_von
         IS NULL, dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), DATE('9999-12-31')) AS dat_bis_neu,
     bezugsvorschrift_kz
    FROM (SELECT mandant_id,
       wup_id,
       art_id,
       dat_von,
       dat_bis,
       bezugsvorschrift_kz,
        CASE
        WHEN bezugsvorschrift_kz <> COALESCE(MAX(bezugsvorschrift_kz) OVER (PARTITION BY mandant_id, wup_id, art_id
           ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), '0')
        THEN 1
        ELSE 0
        END AS chg_bezugsv
      FROM dbp_data.art_wup_ordersatz_2 AS T01
      QUALIFY CASE
         WHEN bezugsvorschrift_kz <> COALESCE(MAX(bezugsvorschrift_kz) OVER (PARTITION BY mandant_id, wup_id, art_id
            ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), '0')
         THEN 1
         ELSE 0
         END = 1) AS t0) AS ordersatz ON TEMP.mandant_id = ordersatz.mandant_id AND TEMP.art_id = ordersatz.art_id AND
      TEMP.kunde_id = ordersatz.wup_id AND TEMP.dat BETWEEN ordersatz.dat_von AND ordersatz.dat_bis_neu
  WHERE ordersatz.bezugsvorschrift_kz IS NOT NULL) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 we_bearbeitungszeit = tbl.we_bearbeitungszeit,
 planlieferzeit = tbl.planlieferzeit FROM (SELECT DISTINCT TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   STORETERM.we_bearbeitungszeit,
   STORETERM.planlieferzeit
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.art_wup_status_per_2 AS MARC_2 ON TEMP.mandant_id = MARC.mandant_id AND TEMP.art_id =
       MARC.art_id AND TEMP.kunde_id = MARC.wup_id AND TEMP.dat BETWEEN MARC.dat_von AND MARC.dat_bis
   LEFT JOIN (SELECT mandant_id,
     art_id,
     wup_id,
     gp_id,
     auslieferungsgruppe_id,
     dat_von,
     dat_bis
    FROM dbp_data.art_gp_wup_dts_zu_per_2
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, art_id, wup_id, gp_id ORDER BY dat_bis IS NULL DESC, dat_bis
          DESC, auslieferungsgruppe_id IS NULL, auslieferungsgruppe_id)) = 1) AS t0 ON TEMP.mandant_id = t0.mandant_id
       AND TEMP.art_id = t0.art_id AND TEMP.kunde_id = t0.wup_id AND TEMP.wup_id = t0.gp_id AND TEMP.dat BETWEEN t0.dat_von
     AND t0.dat_bis
   INNER JOIN dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2 AS STORETERM ON TEMP.mandant_id = STORETERM
             .mandant_id AND TEMP.wg_id = STORETERM.wg_id AND TEMP.kunde_id = STORETERM.kunde_id AND TEMP.wup_id =
           STORETERM.wup_id AND MARC.terminierungsgruppe_1_id = STORETERM.terminierungsgruppe_1_id AND MARC.terminierungsgruppe_2_id
          = STORETERM.terminierungsgruppe_2_id AND MARC.terminierungsgruppe_3_id = STORETERM.terminierungsgruppe_3_id
      AND STORETERM.sortimentslistenart_id = '' AND STORETERM.auslieferungsgruppe_id = CASE
       WHEN TEMP.mandant_id = 1 AND TEMP.wup_id IN (6912, 6922, 6916)
       THEN STORETERM.auslieferungsgruppe_id
       ELSE t0.auslieferungsgruppe_id
       END AND TEMP.dat BETWEEN STORETERM.dat_von AND STORETERM.dat_bis
  WHERE STORETERM.we_bearbeitungszeit IS NOT NULL
   OR STORETERM.planlieferzeit IS NOT NULL) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 we_bearbeitungszeit = COALESCE(art_wup_autodispo_flw_tag_temp.we_bearbeitungszeit, tbl.we_bearbeitungszeit),
 planlieferzeit = COALESCE(art_wup_autodispo_flw_tag_temp.planlieferzeit, tbl.planlieferzeit) FROM (SELECT TEMP.mandant_id
   ,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   MARC.we_bearbeitungszeit,
   MARC.planlieferzeit
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.art_wup_status_per_2 AS MARC_2 ON TEMP.mandant_id = MARC.mandant_id AND TEMP.art_id =
       MARC.art_id AND TEMP.kunde_id = MARC.wup_id AND TEMP.dat BETWEEN MARC.dat_von AND MARC.dat_bis) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 fur_prognose_menge_ungesteuert = tbl.fur_prognose_menge_ungesteuert,
 fur_prognose_menge_gesteuert = tbl.fur_prognose_menge_gesteuert,
 fur_prognose_menge_max = tbl.fur_prognose_menge_max,
 menge_ofc = tbl.menge_ofc FROM (SELECT TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
    FUR.menge_prognose - FUR.menge_prognose_bef AS fur_prognose_menge_ungesteuert,
   FUR.menge_prognose AS fur_prognose_menge_gesteuert,
   FUR.menge_prognose_max AS fur_prognose_menge_max,
   FUR.menge_ofc
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.fur_prognose_2 AS FUR ON TEMP.mandant_id = FUR.mandant_id AND TEMP.art_id = FUR.art_id
        AND TEMP.kunde_id = FUR.wup_id AND TEMP.dat = FUR.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 fur_bestand = CAST(CASE
   WHEN tbl.bestand <= 0
   THEN 0
   ELSE tbl.bestand
   END AS NUMERIC),
 optik = tbl.frp_mindestbestand,
 servicelevel = tbl.servicelevel,
 nullbestand_fg = CASE
  WHEN art_wup_autodispo_flw_tag_temp.fur_bestand <= 0
  THEN 1
  ELSE 0
  END FROM (SELECT TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   FRP.bestand,
   FRP.frp_mindestbestand,
   FRP.servicelevel
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.art_wup_frplauf_per_2 AS FRP ON TEMP.mandant_id = FRP.mandant_id AND TEMP.art_id =
       FRP.art_id AND TEMP.kunde_id = FRP.wup_id AND TEMP.dat BETWEEN FRP.dat_von AND FRP.dat_bis) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_bv = CAST(t0.menge_best_vor * COALESCE(art_wup_autodispo_flw_tag_temp.kollifaktor, 1) AS NUMERIC) FROM (SELECT
   TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   SUM(BV.menge_best_vor) AS menge_best_vor
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.fur_best_vor_2 AS BV ON TEMP.mandant_id = BV.mandant_id AND TEMP.art_id = BV.art_id
     AND TEMP.kunde_id = BV.wup_id AND TEMP.dat = BV.dat_dispo
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS t0
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = t0.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = t0.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = t0.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = t0.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = t0.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_we_offen = CAST(tbl.menge_einteil * COALESCE(art_wup_autodispo_flw_tag_temp.kollifaktor, 1) AS NUMERIC) FROM (SELECT
   TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   t0.menge_einteil
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN (SELECT EKPO.mandant_id,
     EKPO.wup_id,
     EKPO.art_id,
     EKET.dat_lief_wunsch,
     SUM(EKET.menge_einteil) AS menge_einteil
    FROM dbp_data.besch_best_det_2 AS EKPO_2
     INNER JOIN dbp_data.lief_einteilung_2 AS EKET ON EKPO.mandant_id = EKET.mandant_id AND EKPO.best_beleg_id
           = EKET.best_beleg_id AND EKPO.best_beleg_pos_id = EKET.best_beleg_pos_id AND EKPO.loesch_fg = 0 AND EKPO.endlief_fg
        = 0
    GROUP BY EKPO.mandant_id,
     EKPO.art_id,
     EKPO.wup_id,
     EKET.dat_lief_wunsch) AS t0 ON TEMP.mandant_id = t0.mandant_id AND TEMP.kunde_id = t0.wup_id AND TEMP.art_id = t0.art_id
       AND TEMP.dat = t0.dat_lief_wunsch) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_we = tbl.menge_lagerbew_bme FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(MSEG.menge_lagerbew_bme) AS menge_lagerbew_bme
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.lagerbew_det_2 AS MSEG ON TEMP.mandant_id = MSEG.mandant_id AND TEMP.kunde_id = MSEG
       .wup_id AND TEMP.art_id = MSEG.art_id AND TEMP.dat = MSEG.dat_buch
   INNER JOIN dbp_data.lagerbew_2 AS MKPF ON MSEG.mandant_id = MKPF.mandant_id AND MSEG.lagerbew_beleg_id =
       MKPF.lagerbew_beleg_id AND MKPF.vorgangsart_id = 'WE' AND MSEG.dat_buch = MKPF.dat_buch
  WHERE MSEG.lager_bewart_id NOT IN (SELECT lager_bewart_id
     FROM dbp_data.lager_bewart_spr_zu_2
     WHERE mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
      OR mandant_id > 1 AND lager_bewart_id = '641')
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_preisabschriften = tbl.menge_preisabschriften,
 menge_totalabschriften = tbl.menge_totalabschriften FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(CASE
     WHEN TEMP.mandant_id = 1 AND ABSCH.abschriftart_id IN (100, 101, 102, 103, 157, 190) OR TEMP.mandant_id > 1 AND
        ABSCH.abschriftart_id IN (973, 974, 905, 906, 983, 984, 971, 972, 987, 988, 993, 994)
     THEN CASE
      WHEN ABSCH.abschrift_menge_einh_id = 'G'
      THEN ABSCH.menge_abschrift / 1000
      ELSE ABSCH.menge_abschrift
      END
     ELSE 0
     END) AS menge_totalabschriften,
   SUM(CASE
     WHEN TEMP.mandant_id = 1 AND ABSCH.abschriftart_id IN (5, 7) OR TEMP.mandant_id > 1 AND ABSCH.abschriftart_id IN (2
         , 7, 10, 11)
     THEN CASE
      WHEN ABSCH.abschrift_menge_einh_id = 'G'
      THEN ABSCH.menge_abschrift / 1000
      ELSE ABSCH.menge_abschrift
      END
     ELSE 0
     END) AS menge_preisabschriften
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.marktabschriften_2 AS ABSCH ON TEMP.mandant_id = ABSCH.mandant_id AND TEMP.kunde_id
       = ABSCH.wup_id AND TEMP.art_id = ABSCH.art_id AND TEMP.dat = ABSCH.dat
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_preisabschriften = tbl.menge_preisabschriften FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(ABSCH.menge_erf) AS menge_preisabschriften
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.art_umbewertung_2 AS ABSCH ON TEMP.mandant_id = ABSCH.mandant_id AND TEMP.kunde_id =
       ABSCH.wup_id AND TEMP.art_id = ABSCH.art_id AND TEMP.dat = ABSCH.dat_umbew
  WHERE ABSCH.mandant_id = 6 AND ABSCH.preis_aend_grund_id = 2
   OR ABSCH.mandant_id IN (2, 4, 5, 7, 8) AND ABSCH.preis_aend_grund_id = 7
   OR ABSCH.mandant_id = 3 AND ABSCH.preis_aend_grund_id = 11
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 ret_bestand = tbl.ret_bestand FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   MARD.menge_lgbest_erp_frei_bme AS ret_bestand
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.marktbestand_erp_2 AS MARD_2 ON TEMP.mandant_id = MARD.mandant_id AND TEMP.art_id =
       MARD.art_id AND TEMP.kunde_id = MARD.wup_id AND DATE_SUB(TEMP.dat, INTERVAL 1 DAY) = MARD.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 sa_af_fg = 1 FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.art_id,
   TEMP.dat
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN (SELECT WAKP.mandant_id,
     WAKP.art_id,
     WAKP.wup_id,
     WAKH.dat_von,
     WAKH.dat_bis
    FROM dbp_data.aktion_2 AS WAKH_2
     INNER JOIN dbp_data.aktion_art_wup_zu_2 AS WAKP_2 ON WAKH.mandant_id = WAKP.mandant_id AND WAKH.aktion_id
        = WAKP.aktion_id
    WHERE WAKH.mandant_id = 1 AND WAKH.preisaktiviert_fg = 1 AND WAKP.dat_sperrung IS NULL
     OR WAKH.mandant_id > 1 AND WAKP.dat_preisaktiviert <> DATE '1900-01-01' AND WAKP.vk_aktion_brutto > 0
    GROUP BY WAKH.dat_von,
     WAKH.dat_bis,
     WAKP.mandant_id,
     WAKP.art_id,
     WAKP.wup_id) AS t1_2 ON TEMP.mandant_id = t1.mandant_id AND TEMP.art_id = t1.art_id AND TEMP.kunde_id = t1.wup_id AND
     TEMP.dat BETWEEN t1.dat_von AND t1.dat_bis
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_abverkauf = t1.menge_abverkauf FROM (SELECT TEMP.mandant_id,
   TEMP.art_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.dat,
   SUM(AB.menge) AS menge_abverkauf
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.artbew_2 AS AB ON TEMP.mandant_id = AB.mandant_id AND TEMP.art_id = AB.art_id AND
      TEMP.kunde_id = AB.wup_id AND TEMP.dat = AB.dat
  WHERE AB.menge IS NOT NULL
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS t1_2
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = t1.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = t1.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = t1.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = t1.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = t1.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP SET
 udf_prognose_menge_gesteuert = TEMP.fur_prognose_menge_ungesteuert
WHERE dat < ${UDF_CUTOVER_DATE};


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 udf_prognose_menge_gesteuert = tbl.menge_prognose FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(UDF.menge_prognose_gesteuert) AS menge_prognose
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.udf_prognose_2 AS UDF ON TEMP.mandant_id = UDF.mandant_id AND TEMP.art_id = UDF.art_id
         AND TEMP.kunde_id = UDF.wup_id AND TEMP.dat = UDF.dat AND UDF.dat_prognoselauf = CASE
      WHEN UDF.dat < CURRENT_DATE("Europe/Berlin")
      THEN UDF.dat
      ELSE DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
      END
  WHERE UDF.diagnose_id = ''
   AND UDF.dat >= ${UDF_CUTOVER_DATE}
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 udf_prognose_menge_gesteuert = tbl.menge_prognose FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(UDF.menge_prognose_gesteuert) AS menge_prognose
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.udf_prognose_2 AS UDF ON TEMP.mandant_id = UDF.mandant_id AND TEMP.art_id = UDF.art_id
         AND TEMP.kunde_id = UDF.wup_id AND TEMP.dat = UDF.dat AND UDF.dat_prognoselauf = CURRENT_DATE("Europe/Berlin")
  WHERE UDF.diagnose_id = ''
   AND UDF.dat >= ${UDF_CUTOVER_DATE}
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 udf_prognose_menge_ungesteuert = tbl.menge_prognose FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(COALESCE(UDF.menge_prognose_af, 0) + COALESCE(UDF.menge_prognose_sa, 0)) AS menge_prognose
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.udf_prognose_2 AS UDF ON TEMP.mandant_id = UDF.mandant_id AND TEMP.art_id = UDF.art_id
         AND TEMP.kunde_id = UDF.wup_id AND TEMP.dat = UDF.dat AND UDF.dat_prognoselauf = CASE
      WHEN UDF.dat < CURRENT_DATE("Europe/Berlin")
      THEN UDF.dat
      ELSE DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
      END
  WHERE UDF.diagnose_id = ''
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 udf_prognose_menge_ungesteuert = tbl.menge_prognose FROM (SELECT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   SUM(COALESCE(UDF.menge_prognose_af, 0) + COALESCE(UDF.menge_prognose_sa, 0)) AS menge_prognose
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS TEMP
   INNER JOIN dbp_data.udf_prognose_2 AS UDF ON TEMP.mandant_id = UDF.mandant_id AND TEMP.art_id = UDF.art_id
         AND TEMP.kunde_id = UDF.wup_id AND TEMP.dat = UDF.dat AND UDF.dat_prognoselauf = CURRENT_DATE("Europe/Berlin")
  WHERE UDF.diagnose_id = ''
  GROUP BY TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat) AS tbl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id AND art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_temp.dat = tbl.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 vklist_dat_von = DATE_ADD(DATE_ADD(COALESCE(art_wup_autodispo_flw_tag_temp.ordersatz_dat_von,
    art_wup_autodispo_flw_tag_temp.marc_dat_von), INTERVAL art_wup_autodispo_flw_tag_temp.we_bearbeitungszeit DAY),
  INTERVAL art_wup_autodispo_flw_tag_temp.planlieferzeit DAY)
WHERE TRUE;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 vklist_anz_schliesstage = (SELECT SUM(anz_schliesstage) AS anz_schliesstage
  FROM (SELECT mandant_id,
      wup_id,
      dat,
      offen,
      1 AS anz_schliesstage
     FROM dbp_data.wupcal_ereignis_zu_2
     WHERE offen = 0
     UNION DISTINCT
     SELECT mandant_id,
      wup_id,
      dat,
      offen,
      1 AS anz_schliesstage
     FROM dbp_data.wupcal_2
     WHERE offen = 0) AS w
  WHERE art_wup_autodispo_flw_tag_temp.mandant_id = mandant_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = wup_id
   AND dat BETWEEN COALESCE(art_wup_autodispo_flw_tag_temp.ordersatz_dat_von, art_wup_autodispo_flw_tag_temp.marc_dat_von
      ) AND art_wup_autodispo_flw_tag_temp.vklist_dat_von)
WHERE TRUE;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 kdis = CASE
  WHEN art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz = 'P'
  THEN 1
  WHEN art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz IS NULL AND art_wup_autodispo_flw_tag_temp.marc_kdis = 1
  THEN 1
  ELSE 0
  END,
 verkaufslistung_fg = CASE
  WHEN (art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz <> 'P' OR art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz
      IS NULL AND art_wup_autodispo_flw_tag_temp.marc_kdis = 0) AND art_wup_autodispo_flw_tag_temp.dat < DATE_ADD(art_wup_autodispo_flw_tag_temp_2
     .vklist_dat_von, INTERVAL COALESCE(art_wup_autodispo_flw_tag_temp.vklist_anz_schliesstage, 0) DAY)
  THEN 0
  WHEN (art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz = 'P' OR art_wup_autodispo_flw_tag_temp.bezugsvorschrift_kz
      IS NULL AND art_wup_autodispo_flw_tag_temp.marc_kdis = 1) AND DATE_DIFF(DATE_ADD(art_wup_autodispo_flw_tag_temp.vklist_dat_von
      ,INTERVAL COALESCE(art_wup_autodispo_flw_tag_temp.vklist_anz_schliesstage, 0) DAY),
     art_wup_autodispo_flw_tag_temp.dat, DAY) <= 0
  THEN 0
  ELSE 1
  END
WHERE TRUE;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS art_wup_autodispo_flw_tag_temp0 SET
 kdis = CASE
  WHEN kdis.kdis_ = 0
  THEN kdis.kdis_
  ELSE art_wup_autodispo_flw_tag_temp0.kdis
  END,
 verkaufslistung_fg = CASE
  WHEN kdis.verkaufslistung_fg_ = 1
  THEN kdis.verkaufslistung_fg_
  ELSE art_wup_autodispo_flw_tag_temp0.verkaufslistung_fg
  END FROM (SELECT mandant_id AS mandant_id_,
   kunde_id AS kunde_id_,
   wup_id AS wup_id_,
   art_id AS art_id_,
   dat AS dat_,
   kdis AS kdis_,
   verkaufslistung_fg AS verkaufslistung_fg_
  FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2) AS kdis
WHERE art_wup_autodispo_flw_tag_temp0.mandant_id = kdis.mandant_id_ AND art_wup_autodispo_flw_tag_temp0.kunde_id = kdis
     .kunde_id_ AND art_wup_autodispo_flw_tag_temp0.wup_id = kdis.wup_id_ AND art_wup_autodispo_flw_tag_temp0.art_id_display
    = kdis.art_id_ AND art_wup_autodispo_flw_tag_temp0.dat = kdis.dat_;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 komponentenmenge = stl.komponentenmenge_ FROM (SELECT MAST.mandant_id AS mandant_id_,
   STPO.art_id AS art_id_,
   STPO.komponentenmenge AS komponentenmenge_,
   STPO.komponentenmenge_einh_id,
   MAST.art_id AS art_id_display_,
   STPO.dat_von,
   STPO.dat_bis
  FROM dbp_data.stueckliste_det_2 AS STPO_2
   INNER JOIN dbp_data.stueckliste_2 AS MAST_2 ON STPO.mandant_id = MAST.mandant_id AND STPO.stueckliste_id =
     MAST.stueckliste_id) AS stl
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = stl.mandant_id_ AND art_wup_autodispo_flw_tag_temp.art_id = stl.art_id_
     AND art_wup_autodispo_flw_tag_temp.art_id_display = stl.art_id_display_ AND art_wup_autodispo_flw_tag_temp.dat
  BETWEEN stl.dat_von AND stl.dat_bis;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS art_wup_autodispo_flw_tag_temp0 SET
 komponentenmenge = stl.komponentenmenge_sum FROM (SELECT mandant_id_,
   art_id_display_,
   dat_,
   SUM(komponentenmenge) AS komponentenmenge_sum
  FROM (SELECT DISTINCT mandant_id AS mandant_id_,
     art_id,
     art_id_display AS art_id_display_,
     dat AS dat_,
     komponentenmenge
    FROM dbp_etl.art_wup_autodispo_flw_tag_temp_2
    WHERE art_id_display IS NOT NULL) AS stl_i
  GROUP BY mandant_id_,
   art_id_display_,
   dat_) AS stl
WHERE art_wup_autodispo_flw_tag_temp0.mandant_id = stl.mandant_id_ AND art_wup_autodispo_flw_tag_temp0.art_id = stl.art_id_display_
    AND art_wup_autodispo_flw_tag_temp0.dat = stl.dat_;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 best_anz_schliesstage = (SELECT SUM(anz_schliesstage) AS anz_schliesstage
  FROM (SELECT mandant_id,
      wup_id,
      dat,
      offen,
      1 AS anz_schliesstage
     FROM dbp_data.wupcal_ereignis_zu_2
     WHERE offen = 0
     UNION DISTINCT
     SELECT mandant_id,
      wup_id,
      dat,
      offen,
      1 AS anz_schliesstage
     FROM dbp_data.wupcal_2
     WHERE offen = 0) AS w
  WHERE art_wup_autodispo_flw_tag_temp.mandant_id = mandant_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = wup_id
   AND dat BETWEEN DATE_SUB(art_wup_autodispo_flw_tag_temp.dat, INTERVAL art_wup_autodispo_flw_tag_temp.planlieferzeit
     DAY) AND art_wup_autodispo_flw_tag_temp.dat)
WHERE TRUE;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 dat_best = CASE
  WHEN w.offen = 0
  THEN NULL
  ELSE DATE_SUB(DATE_SUB(art_wup_autodispo_flw_tag_temp.dat, INTERVAL art_wup_autodispo_flw_tag_temp.planlieferzeit
    DAY), INTERVAL COALESCE(art_wup_autodispo_flw_tag_temp.best_anz_schliesstage, 0) DAY)
  END FROM (SELECT mandant_id,
   wup_id,
   dat,
   MAX(offen) AS offen
  FROM (SELECT mandant_id,
      wup_id,
      dat,
      offen
     FROM dbp_data.wupcal_zukunft_2
     UNION DISTINCT
     SELECT mandant_id,
      wup_id,
      dat,
      offen
     FROM dbp_data.wupcal_2) AS t1_2
  GROUP BY mandant_id,
   wup_id,
   dat) AS w
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = w.mandant_id AND art_wup_autodispo_flw_tag_temp.kunde_id = w.wup_id
 AND art_wup_autodispo_flw_tag_temp.dat = w.dat;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 AS F SET
 menge_we_geplant = CAST(CASE
   WHEN F.dat < CURRENT_DATE("Europe/Berlin")
   THEN F.menge_we
   WHEN F.dat >= CURRENT_DATE("Europe/Berlin")
   THEN F.menge_we_offen
   ELSE NULL
   END AS NUMERIC)
WHERE TRUE;


UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 SET
 menge_we_geplant = COALESCE(FUR.menge_ofc, 0) + COALESCE(art_wup_autodispo_flw_tag_temp.menge_we_offen, 0) FROM
 dbp_data.fur_prognose_2 AS FUR
WHERE art_wup_autodispo_flw_tag_temp.mandant_id = FUR.mandant_id AND art_wup_autodispo_flw_tag_temp.art_id = FUR.art_id
   AND art_wup_autodispo_flw_tag_temp.kunde_id = FUR.wup_id AND art_wup_autodispo_flw_tag_temp.dat_best = FUR.dat AND
  art_wup_autodispo_flw_tag_temp.dat_best >= CURRENT_DATE("Europe/Berlin");