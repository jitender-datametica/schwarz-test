CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_2 (dat, wtag_id, kjtag_id, gjtag_id, dat_vj, dat_vvj, kjwo, wo_dat_von,
wo_dat_bis, kjmo, kjmo_vj, gj, mo_gj, kj, mo_kj, gjqu, akt_tag, akt_wo, akt_wo_komplett, akt_mo, akt_mo_komplett, akt_gj
, akt_gj_komplett, akt_kj, akt_kj_komplett, akt_gjqu, akt_gjqu_komplett, wo_von_bis, kjmo_dat, akt_qu, gjwo_neu, kjwo_kl
, tag_tag, referenz_tag, jdat) AS SELECT dat,
 wtag_id,
 kjtag_id,
 gjtag_id,
 dat_vj,
 DATE_SUB(dat_vj, INTERVAL 364 DAY) AS dat_vvj,
 kjwo,
 wo_dat_von,
 wo_dat_bis,
 kjmo,
 kjmo_vj,
 gj,
 mo_gj,
 kj,
 mo_kj,
 gjqu,
 akt_tag,
 akt_wo,
 akt_wo_komplett,
 akt_mo,
 akt_mo_komplett,
 akt_gj,
 akt_gj_komplett,
 akt_kj,
 akt_kj_komplett,
 akt_gjqu,
 akt_gjqu_komplett,
      TRIM(CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING FORMAT '00')) || ' (' || FORMAT_DATE('%d.%m', wo_dat_von)
    || '-' || FORMAT_DATE('%d.%m', wo_dat_bis) || ')' AS wo_von_bis,
  SUBSTR(CAST(dat AS STRING), 1, 8) || '01' AS kjmo_dat,
  akt_mo / 3 AS akt_qu,
  CASE
  WHEN snowconvert_public.teradata_numeric_date_to_date((kj - 1900) * 10000 + 301) BETWEEN wo_dat_von 
     AND wo_dat_bis 
  THEN kj * 100 + 1
  ELSE gjwo_kl
  END AS gjwo_neu,
 kjwo_kl,
 EXTRACT(DAY FROM dat) AS tag_tag,
 EXTRACT(DAY FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS referenz_tag,
    TRIM(CAST(EXTRACT(DAY FROM dat) AS STRING FORMAT '00')) || '.' || TRIM(CAST(EXTRACT(MONTH FROM dat) AS STRING FORMAT '00')
    ) || '.' AS jdat
FROM kfl_production_dbp_view.v_tag_2 AS V01
WHERE akt_gj BETWEEN -11 AND 1;

