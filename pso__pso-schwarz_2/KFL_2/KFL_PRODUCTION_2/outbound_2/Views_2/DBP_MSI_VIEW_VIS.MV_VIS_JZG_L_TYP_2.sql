CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_l_typ_2 (typ_id, typ_bez, typ_bez_cz, typ_bez_sk,
typ_bez_hr, typ_bez_pl, typ_bez_ro, typ_bez_bg) AS SELECT CAST(a1 AS BIGNUMERIC) AS typ_id,
 CAST(a2 AS STRING) AS typ_bez,
 CAST(a3 AS STRING) AS typ_bez_cz,
 CAST(a4 AS STRING) AS typ_bez_sk,
 CAST(a5 AS STRING) AS typ_bez_hr,
 CAST(a6 AS STRING) AS typ_bez_pl,
 CAST(a7 AS STRING) AS typ_bez_ro,
 CAST(a8 AS STRING) AS typ_bez_bg
FROM (SELECT 0 AS a1,
    'Filiale' AS a2,
    'Filiálka' AS a3,
    'Filiálka' AS a4,
    'Poslovnica' AS a5,
    'Market' AS a6,
    'Magazin' AS a7,
    'Филиал' AS a8
   UNION ALL
   SELECT 1,
    'Abteilung',
    'Oddělení',
    'Oddelenie',
    'Odjel',
    'Dział',
    'Departament',
    'Отдел'
   UNION ALL
   SELECT 2,
    'HWG',
    'HWG',
    'HWG',
    'HWG',
    'GGT',
    'HWG',
    'HWG'
   UNION ALL
   SELECT 3,
    'OWG',
    'OWG',
    'OWG',
    'OWG',
    'NGT',
    'OWG',
    'OWG') AS jzg;