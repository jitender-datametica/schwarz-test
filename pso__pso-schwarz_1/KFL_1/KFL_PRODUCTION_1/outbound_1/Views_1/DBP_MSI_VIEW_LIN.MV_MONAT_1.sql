CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_monat_1 (mo_kj, kj, kjmo, dat_von, kjmo_order, kjmo_vormonat,
akt_mo, akt_mo_komplett) AS SELECT mo_kj,
 kj,
 kjmo,
 dat_von,
 RANK() OVER (ORDER BY kjmo IS NULL, kjmo) AS kjmo_order,
 kjmo_vormonat,
 akt_mo,
 akt_mo_komplett
FROM (SELECT mo_kj,
   kj,
   kjmo,
   min_dat AS dat_von,
   MAX(kjmo) OVER (ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kjmo_vormonat,
   akt_mo,
   akt_mo_komplett
  FROM kfl_production_dbp_view.v_monat_1 AS V01) AS dt1
WHERE akt_mo_komplett BETWEEN - 3 AND 12;