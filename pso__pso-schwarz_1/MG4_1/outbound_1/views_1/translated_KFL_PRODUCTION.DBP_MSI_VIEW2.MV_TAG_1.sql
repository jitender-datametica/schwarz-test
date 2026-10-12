-- Karwoche identifizieren
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_tag_1 (dat, kjmo, kjmo_vj, wtag_id,
kjwo, kjwo_vj, gjwo, gjwo_vj, wo_dat_von, wo_dat_bis, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, kjtag_id, gjtag_id, kjwo_kl,
kjwo_kl_dat_von, kjwo_kl_dat_bis, gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, dat_vj, akt_tag, akt_mo, akt_mo_komplett,
akt_wo, akt_wo_komplett, akt_gjwo_kl, akt_gjwo_kl_komplett, akt_kjwo_kl, akt_kjwo_kl_komplett, akt_gjqu,
akt_gjqu_komplett, akt_kjqu, akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj, akt_kj_komplett, mo_gj, mo_kj, dat_vvj
, akt_qu, dat_vm, dat_vj_date, dat_vj_kt, dat_vj_ostern, dat_vvj_ostern, dat_vvj_date) AS WITH kar_woche AS (SELECT
  DISTINCT v011.dat,
   v011.kjwo,
   v011.akt_wo
  FROM kfl_production_dbp_view.v_tag_1 AS v011
   INNER JOIN kfl_production_dbp_view.v_wupcal_ereignis_zu_1 AS v02 ON v011.dat = v02.dat
  WHERE v02.mandant_id = 1
   AND v02.ereignis_id = 5
   AND v02.ereignistyp_id = 1
   AND v011.dat >= DATE '2019-01-01'), oster_saison_zeitraum AS (SELECT v010.dat,
   v010.akt_kj,
   v010.kjwo,
   DENSE_RANK() OVER (PARTITION BY v010.akt_kj ORDER BY v010.dat IS NULL, v010.dat) AS sort_id_ostertage
  FROM kfl_production_dbp_view.v_tag_1 AS v010
   INNER JOIN kar_woche AS t1_1 ON v010.akt_wo BETWEEN t1.akt_wo - 10 AND (t1.akt_wo + 2)), ostern_saison_vj_vvj_fakten AS
  (SELECT v01.dat,
   vj.kjwo AS kjwo_vj_ostern,
   vj.dat AS dat_vj_ostern,
   vvj.kjwo AS kjwo_vvj_ostern,
   vvj.dat AS dat_vvj_ostern
  FROM oster_saison_zeitraum AS v01
   LEFT JOIN oster_saison_zeitraum AS vj ON v01.akt_kj - 1 = vj.akt_kj AND v01.sort_id_ostertage = vj.sort_id_ostertage
   LEFT JOIN oster_saison_zeitraum AS vvj ON v01.akt_kj - 2 = vvj.akt_kj AND v01.sort_id_ostertage = vvj.sort_id_ostertage
     ) (-- Zeitraum fuer Ostern definieren
 -- Karwoche - 10 Wochen + 2 Wochen
 -- VJ / VVJ Dat ermitteln

  -- AP0186806/SPEC0228450 steaeblern 01.03.2024 / Tagesreporting NF - Dat_vvj_kt da derzeit nicht im DM vorhanden

  SELECT v01.dat,
   v01.kjmo,
   v01.kjmo_vj,
   v01.wtag_id,
   v01.kjwo,
   v01.kjwo_vj,
   v01.gjwo,
   v01.gjwo_vj,
   v01.wo_dat_von,
   v01.wo_dat_bis,
   v01.gjmo,
   v01.gjmo_vj,
   v01.kjqu,
   v01.gjqu,
   v01.kj,
   v01.gj,
   v01.kjtag_id,
   v01.gjtag_id,
   v01.kjwo_kl,
   v01.kjwo_kl_dat_von,
   v01.kjwo_kl_dat_bis,
   v01.gjwo_kl,
   v01.gjwo_kl_dat_von,
   v01.gjwo_kl_dat_bis,
   v01.dat_vj,
   v01.akt_tag,
   v01.akt_mo,
   v01.akt_mo_komplett,
   v01.akt_wo,
   v01.akt_wo_komplett,
   v01.akt_gjwo_kl,
   v01.akt_gjwo_kl_komplett,
   v01.akt_kjwo_kl,
   v01.akt_kjwo_kl_komplett,
   v01.akt_gjqu,
   v01.akt_gjqu_komplett,
   v01.akt_kjqu,
   v01.akt_kjqu_komplett,
   v01.akt_gj,
   v01.akt_gj_komplett,
   v01.akt_kj,
   v01.akt_kj_komplett,
   v01.mo_gj,
   v01.mo_kj,
   DATE_SUB(v01.dat_vj, INTERVAL 364 DAY),
    v01.akt_mo / 3,
   IF(v01.dat = LAST_DAY(v01.dat), LAST_DAY(DATE_ADD(v01.dat, INTERVAL - 1 MONTH)), DATE_ADD(v01.dat, INTERVAL - 1 MONTH)
    ),
   IF(v01.dat = LAST_DAY(v01.dat), LAST_DAY(DATE_ADD(v01.dat, INTERVAL - 12 MONTH)), DATE_ADD(v01.dat, INTERVAL - 12
     MONTH)),
   -- AP0168833/SPEC0213188 sschuecke 25.08.2023 / Erweiterung um Spalte DAT_VJ_KT für Schaltjahre
 v01.dat_vj_kt,
   -- AP0186806/SPEC0228449 steaeblern 29.02.2024 / Saison Reporting fuer Ostern ermittlung der VJ/ VVJ Metriken
 v02.dat_vj_ostern
   ,
   v02.dat_vvj_ostern,
   IF(v01.dat_vj_kt = LAST_DAY(v01.dat_vj_kt), LAST_DAY(DATE_ADD(v01.dat_vj_kt, INTERVAL - 12 MONTH)), DATE_ADD(v01.dat_vj_kt
     ,INTERVAL - 12 MONTH)) AS dat_vvj_kt
  FROM kfl_production_dbp_view.v_tag_1 AS v01
   LEFT JOIN ostern_saison_vj_vvj_fakten AS v02 ON v01.dat = v02.dat);