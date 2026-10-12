CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_leergut_denorm (mandant_id, wup_id, wup_id_einloesung,
barcode_leergut, bon_dat, bon_zeile, wrg_id, bon_tmsp, bon_tmsp_einloesung, kl_art_id, plu_gruppe, leerguttyp,
menge_denorm, bon_zeilen_wert_denorm, mit_ohne_bon, quelle_erstellung, quelle_einloesung, status_einloesung) AS SELECT
 er.mandant_id,
 WP_ER.aktuell_wup_id AS wup_id,
 WP_EI.aktuell_wup_id AS wup_id_einloesung,
 er.barcode_leergut,
 er.bon_dat,
 er.bon_zeile,
 er.wrg_id,
 er.bon_tmsp,
 ei.bon_tmsp AS bon_tmsp_einloesung,
 er.kl_art_id,
 er.plu_gruppe,
 er.leerguttyp,
 er.menge AS menge_denorm,
 er.bon_zeilen_wert AS bon_zeilen_wert_denorm,
  CASE
  WHEN er.quelle = 'INFO'
  THEN 'ohne Bon'
  ELSE 'mit Bon'
  END AS mit_ohne_bon,
 er.quelle AS quelle_erstellung,
 COALESCE(ei.quelle, '') AS quelle_einloesung,
 COALESCE(ei.eistatus, er.erstatus) AS status_einloesung
FROM (SELECT EK.barcode_leergut,
    EK.mandant_id,
    EK.wup_id,
    EK.bon_dat,
    krs.nach_wrg_id AS wrg_id,
    EK.bon_tmsp,
    EK.bon_nr,
    EK.system_bez,
    EK.system_typ_bez,
    EK.system_hersteller_bez,
    EP.bon_zeile,
     CASE
     WHEN EP.kl_art_id BETWEEN 1 AND 9999
     THEN CAST(- 1 AS BIGNUMERIC)
     ELSE EP.kl_art_id
     END AS kl_art_id,
    EP.plu_gruppe,
     CASE
     WHEN EP.plu_gruppe IN ('0000000000100', '0000000000300')
     THEN 'MW'
     WHEN EP.plu_gruppe IN ('0000000000200', '0000000000400')
     THEN 'EW'
     ELSE 'UNKNOWN'
     END AS leerguttyp,
    ROUND(CAST('' AS BIGNUMERIC), 0) AS ean_kasse,
     EP.bon_zeilen_wert / EP.menge AS pfand_st,
    EP.menge,
     EP.bon_zeilen_wert * krs.umrechnungskurs AS bon_zeilen_wert,
    'ELS' AS quelle,
    '0' AS erstatus
   FROM kfl_production_dbp_v_ods.v_els_leergut_kopf AS EK
    INNER JOIN kfl_production_dbp_v_ods.v_els_leergut_position AS EP ON EK.mandant_id = EP.mandant_id AND EK.barcode_leergut
       = EP.barcode_leergut
    INNER JOIN (SELECT von_wrg_id,
       nach_wrg_id,
       umrechnungskurs
      FROM kfl_production_dbp_data.kurs AS KRS1
      WHERE kurstyp_id = 3
       AND dat_bis = DATE '9999-12-31'
       AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
      UNION ALL
      SELECT von_wrg_id,
       von_wrg_id AS von_wrg_id0,
       1.0000
      FROM kfl_production_dbp_data.kurs AS KRS2
      WHERE kurstyp_id = 3
       AND dat_bis = DATE '9999-12-31'
       AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON EK.wrg_id = krs.von_wrg_id
   UNION ALL
   SELECT LE.barcode_leergut,
    LE.mandant_id,
    LE.wup_id,
    LE.bon_dat,
    krs.nach_wrg_id AS wrg_id,
    LE.start_bon_zeile AS bon_tmsp,
    LE.bon_nr_extern AS bon_nr,
    '' AS system_bez,
    '' AS system_typ_bez,
    '' AS system_hersteller_bez,
    LE.bon_zeile,
    LE.kl_art_id,
    '' AS plu_gruppe,
     CASE
     WHEN LE.ean_kasse IS NULL
     THEN 'frei'
     WHEN LE.umsatz_brutto / LE.menge = - 0.25
     THEN 'EW'
     ELSE 'MW'
     END AS leerguttyp,
    LE.ean_kasse,
     LE.umsatz_brutto / LE.menge AS pfand_st,
    LE.menge,
     LE.umsatz_brutto * krs.umrechnungskurs AS bon_zeilen_wert,
     CASE
     WHEN K.kasse_typ_id = 3
     THEN 'EMPTIES'
     WHEN K.kasse_typ_id = 2
     THEN 'INFO'
     ELSE 'NONE'
     END AS quelle,
    '0' AS erstatus
   FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
    INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_leergut AS LE ON K.bon_id = LE.bon_id AND K.mandant_id = LE.mandant_id
         AND K.bon_dat = LE.bon_dat AND K.wup_id = LE.wup_id
    INNER JOIN (SELECT von_wrg_id,
       nach_wrg_id,
       umrechnungskurs
      FROM kfl_production_dbp_data.kurs AS KRS1
      WHERE kurstyp_id = 3
       AND dat_bis = DATE '9999-12-31'
       AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
      UNION ALL
      SELECT von_wrg_id,
       von_wrg_id AS von_wrg_id0,
       1.0000
      FROM kfl_production_dbp_data.kurs AS KRS2
      WHERE kurstyp_id = 3
       AND dat_bis = DATE '9999-12-31'
       AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON K.wrg_id = krs.von_wrg_id) AS er
 INNER JOIN kfl_production_dbp_view.v_wup AS WP_ER ON er.mandant_id = WP_ER.mandant_id AND er.wup_id = WP_ER.wup_id
 LEFT JOIN ((SELECT T2.barcode_leergut,
     T1.mandant_id,
     T1.wup_id,
     T1.bon_dat,
     T1.bon_nr,
     'KPOS_Verkauf' AS quelle,
     '1' AS eistatus,
     MIN(T2.start_bon_zeile) AS bon_tmsp
    FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS T1
     INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf AS T2 ON T1.bon_id = T2.bon_id AND T1.mandant_id = T2.mandant_id
          AND T1.bon_dat = T2.bon_dat AND T1.wup_id = T2.wup_id
    WHERE T2.barcode_leergut <> ''
     AND T2.wg_id <> 961
     AND T1.turnover_fg = 1
    GROUP BY T2.barcode_leergut,
     T1.mandant_id,
     T1.wup_id,
     T1.bon_dat,
     T1.bon_nr,
     quelle,
     eistatus
    UNION ALL
    SELECT Z.barcode_leergut,
     T1.mandant_id,
     T1.wup_id,
     T1.bon_dat,
     T1.bon_nr,
     'KPOS_Zahlung_BBN' AS quelle,
     '1' AS eistatus,
     MIN(Z.start_bon_zeile) AS bon_tmsp
    FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS T1
     INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_zahlung AS Z ON T1.bon_id = Z.bon_id AND T1.mandant_id = Z.mandant_id
          AND T1.bon_dat = Z.bon_dat AND T1.wup_id = Z.wup_id
    WHERE Z.barcode_leergut <> ''
     AND Z.kpos_zahlung_typ_id = 'BBN'
    GROUP BY Z.barcode_leergut,
     T1.mandant_id,
     T1.wup_id,
     T1.bon_dat,
     T1.bon_nr,
     quelle,
     eistatus) AS ei INNER JOIN kfl_production_dbp_view.v_wup AS WP_EI ON ei.mandant_id = WP_EI.mandant_id AND ei.wup_id
     = WP_EI.wup_id) ON er.barcode_leergut = ei.barcode_leergut AND er.mandant_id = ei.mandant_id;