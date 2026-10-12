
-- 2012KW46  TBac Erweiterung kjtag_id und gjtag_id
 -- 2018.0822 : Review GJ-Quartal > GJ-Halbjahr (DELETED)

-- ZEIT_1/Hierachie : Tag_1
 -- 2013KW28: Erweiterung um kjwo_kl
 -- 2020.0121 ssch0611 : Synch. E/Q/PROD

-- 2013KW37: K.Kaiser Erweiterung um  tag_tag + referent_tag (3 Monatslogik)

-- 2013KW04: Erweiterung 11 Jahre (historische Umsatzdaten)
 -- 2025-01-27 muellerpatri : Erweiterung um Spalte JMO

-- 2021.1116 snik1809: v01.akt_gj BETWEEN -10 AND 1 --> -11 AND 1
 -- 2011KW28 Review/Verschlankung
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_1 AS SELECT dat,
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
  WHEN snowconvert_public.teradata_numeric_date_to_date((kj - 1900) * 10000 + 301) BETWEEN wo_dat_von AND wo_dat_bis
  THEN kj * 100 + 1
  ELSE gjwo_kl
  END AS gjwo_neu,
 kjwo_kl,
 EXTRACT(DAY FROM dat) AS tag_tag,
 EXTRACT(DAY FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS referenz_tag,
    TRIM(CAST(EXTRACT(DAY FROM dat) AS STRING FORMAT '00')) || '.' || TRIM(CAST(EXTRACT(MONTH FROM dat) AS STRING FORMAT '00')
    ) || '.' AS jdat
FROM kfl_production_dbp_view.v_tag_1 AS V01
WHERE akt_gj BETWEEN - 11 AND 1;

