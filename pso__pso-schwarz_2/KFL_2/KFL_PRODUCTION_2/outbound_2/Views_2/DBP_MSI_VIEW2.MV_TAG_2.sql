CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_tag_2 (dat, kjmo, kjmo_vj, wtag_id, kjwo, kjwo_vj, gjwo, gjwo_vj,
wo_dat_von, wo_dat_bis, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, kjtag_id, gjtag_id, kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis
, gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, dat_vj, akt_tag, akt_mo, akt_mo_komplett, akt_wo, akt_wo_komplett,
akt_gjwo_kl, akt_gjwo_kl_komplett, akt_kjwo_kl, akt_kjwo_kl_komplett, akt_gjqu, akt_gjqu_komplett, akt_kjqu,
akt_kjqu_komplett, akt_gj, akt_gj_komplett, akt_kj, akt_kj_komplett, mo_gj, mo_kj, dat_vvj, akt_qu, dat_vm, dat_vj_date
, dat_vj_kt, dat_vj_ostern, dat_vvj_ostern, dat_vvj_date) AS WITH KAR_WOCHE AS (SELECT DISTINCT V011.dat,
   V011.kjwo,
   V011.akt_wo
  FROM kfl_production_dbp_view.v_tag_2 AS V011
   INNER JOIN kfl_production_dbp_view.v_wupcal_ereignis_zu_2 AS V02 ON V011.dat = V02.dat
  WHERE V02.mandant_id = 1
   AND V02.ereignis_id = 5
   AND V02.ereignistyp_id = 1
   AND V011.dat >= DATE '2019-01-01'), OSTER_SAISON_ZEITRAUM AS (SELECT V010.dat,
   V010.akt_kj,
   V010.kjwo,
   DENSE_RANK() OVER (PARTITION BY CAST(V010.akt_kj AS STRING) ORDER BY V010.dat IS NULL, V010.dat) AS sort_id_ostertage
   
  FROM kfl_production_dbp_view.v_tag_2 AS V010
   INNER JOIN KAR_WOCHE AS t1_2 ON V010.akt_wo BETWEEN t1.akt_wo - 10 AND (t1.akt_wo + 2)), OSTERN_SAISON_VJ_VVJ_FAKTEN AS
  (SELECT v01.dat,
   vj.kjwo AS kjwo_vj_ostern,
   vj.dat AS dat_vj_ostern,
   vvj.kjwo AS kjwo_vvj_ostern,
   vvj.dat AS dat_vvj_ostern
  FROM OSTER_SAISON_ZEITRAUM AS v01
   LEFT JOIN OSTER_SAISON_ZEITRAUM AS vj ON v01.akt_kj - 1 = vj.akt_kj AND v01.sort_id_ostertage = vj.sort_id_ostertage
   LEFT JOIN OSTER_SAISON_ZEITRAUM AS vvj ON v01.akt_kj - 2 = vvj.akt_kj AND v01.sort_id_ostertage = vvj.sort_id_ostertage
     ) (SELECT V01.dat,
   V01.kjmo,
   V01.kjmo_vj,
   V01.wtag_id,
   V01.kjwo,
   V01.kjwo_vj,
   V01.gjwo,
   V01.gjwo_vj,
   V01.wo_dat_von,
   V01.wo_dat_bis,
   V01.gjmo,
   V01.gjmo_vj,
   V01.kjqu,
   V01.gjqu,
   V01.kj,
   V01.gj,
   V01.kjtag_id,
   V01.gjtag_id,
   V01.kjwo_kl,
   V01.kjwo_kl_dat_von,
   V01.kjwo_kl_dat_bis,
   V01.gjwo_kl,
   V01.gjwo_kl_dat_von,
   V01.gjwo_kl_dat_bis,
   V01.dat_vj,
   V01.akt_tag,
   V01.akt_mo,
   V01.akt_mo_komplett,
   V01.akt_wo,
   V01.akt_wo_komplett,
   V01.akt_gjwo_kl,
   V01.akt_gjwo_kl_komplett,
   V01.akt_kjwo_kl,
   V01.akt_kjwo_kl_komplett,
   V01.akt_gjqu,
   V01.akt_gjqu_komplett,
   V01.akt_kjqu,
   V01.akt_kjqu_komplett,
   V01.akt_gj,
   V01.akt_gj_komplett,
   V01.akt_kj,
   V01.akt_kj_komplett,
   V01.mo_gj,
   V01.mo_kj,
   DATE_SUB(V01.dat_vj, INTERVAL 364 DAY),
    V01.akt_mo / 3,
   IF(V01.dat = LAST_DAY(V01.dat), LAST_DAY(DATE_ADD(V01.dat, INTERVAL - 1 MONTH)), DATE_ADD(V01.dat, INTERVAL - 1 MONTH)
    ),
   IF(V01.dat = LAST_DAY(V01.dat), LAST_DAY(DATE_ADD(V01.dat, INTERVAL - 12 MONTH)), DATE_ADD(V01.dat, INTERVAL - 12
     MONTH)),
   V01.dat_vj_kt,
   v02.dat_vj_ostern,
   v02.dat_vvj_ostern,
   IF(V01.dat_vj_kt = LAST_DAY(V01.dat_vj_kt), LAST_DAY(DATE_ADD(V01.dat_vj_kt, INTERVAL - 12 MONTH)), DATE_ADD(V01.dat_vj_kt
     ,INTERVAL - 12 MONTH)) AS dat_vvj_kt
  FROM kfl_production_dbp_view.v_tag_2 AS V01
   LEFT JOIN OSTERN_SAISON_VJ_VVJ_FAKTEN AS v02 ON V01.dat = v02.dat);