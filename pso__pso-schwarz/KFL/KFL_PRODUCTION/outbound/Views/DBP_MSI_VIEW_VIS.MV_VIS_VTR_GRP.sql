CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_vtr_grp (vtr_grp_id, vtr_grp_bez, vtr_grp_bez_cz,
vtr_grp_bez_sk, vtr_grp_bez_hr, vtr_grp_bez_pl, vtr_grp_bez_ro, vtr_grp_bez_bg) AS SELECT 0 AS vtr_grp_id,
 CAST('Gesamt' AS STRING) AS vtr_grp_bez,
 CAST('Celkem' AS STRING) AS vtr_grp_bez_cz,
 CAST('Celkom' AS STRING) AS vtr_grp_bez_sk,
 CAST('Ukupno' AS STRING) AS vtr_grp_bez_hr,
 CAST('Razem' AS STRING) AS vtr_grp_bez_pl,
 CAST('Total' AS STRING) AS vtr_grp_bez_ro,
 CAST('Общо' AS STRING) AS vtr_grp_bez_bg
FROM (SELECT 0,
    'Gesamt',
    'Celkem',
    'Celkom',
    'Ukupno',
    'Razem',
    'Total',
    'Общо'
   UNION ALL
   SELECT 1,
    'Umsatz & Leistung',
    'Obrat & V\u00fdkon',
    'Obrat a V\u00fdkon',
    'Promet & produktivnost',
    'Obrót i produktywność',
    'Vânzăre & Eficiență',
    'Оборот и Продуктивност'
   UNION ALL
   SELECT 3,
    'Abschriften & Inventur',
    'Odpisy & Inventura',
    'Odpisy a inventúra',
    'Otpisi & inventura',
    'Odpisy i inwentaryzacja',
    'Pierderi & Inventar',
    'Загуби & Инвент.'
   UNION ALL
   SELECT 5,
    'Kunden\u00adversprechen',
    'Zákaznické záruky',
    'Zákaznícke záruky / servis',
    'Garancije kupcima',
    'Obietnice dla klientów',
    'Garanții pentru clienți',
    'Клиентски обещеания'
   UNION ALL
   SELECT 7,
    'FWWS',
    'FWWS',
    'FWWS',
    'FWWS',
    'FWWS',
    'FWWS',
    'FWWS') AS vtr_grp;