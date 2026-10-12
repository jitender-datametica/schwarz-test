CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_lin_monat_2 (mo_kj, kj, kjmo, kj_kurz, mo_kbez, mo_bez,
mo_kj_bez, dat_von, kjmo_order, kjmo_vormonat, akt_mo_komplett) AS SELECT mo_kj,
 kj,
 kjmo,
 kj_kurz,
 mo_kbez,
 mo_bez,
 mo_kj_bez,
 dat_von,
 RANK() OVER (ORDER BY kjmo IS NULL, kjmo) AS kjmo_order,
 kjmo_vormonat,
 akt_mo_komplett
FROM (SELECT V01.mo_kj,
   V01.kj,
   V01.kjmo,
   SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 4), 3, 2) AS kj_kurz,
    SUBSTR(V02.mo_bez, 1, 3) || '.' AS mo_kbez,
   V02.mo_bez,
      SUBSTR(V02.mo_bez, 1, 3) || '.' || ' ' || SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 4), 3, 2) AS mo_kj_bez,
   V01.min_dat AS dat_von,
   MAX(V01.kjmo) OVER (ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kjmo_vormonat,
   V01.akt_mo_komplett
  FROM kfl_production_dbp_view.v_monat_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_2 AS V02 ON V01.mo_kj = V02.mo_id
  WHERE V02.spr_id = 22) AS dt1
WHERE akt_mo_komplett BETWEEN - 11 AND 1;