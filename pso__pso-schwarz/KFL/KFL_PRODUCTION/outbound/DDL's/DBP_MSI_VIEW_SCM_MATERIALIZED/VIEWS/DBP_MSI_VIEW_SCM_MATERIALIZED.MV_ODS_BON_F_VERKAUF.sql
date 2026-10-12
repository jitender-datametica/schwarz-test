CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm_materialized.mv_ods_bon_f_verkauf(USERID STRING) AS SELECT K.bon_id,
 K.bon_dat,
 K.bon_booking,
 K.dat_booking,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 K.mandant_id,
 K.kasse_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
 K.turnover_fg,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN KURS.nach_wrg_id
  ELSE MAN.default_wrg
  END AS wrg_id,
 K.kasse_typ_id,
 V.bon_zeile,
 V.kl_art_id,
 A.art_id,
 V.ean_kasse,
 V.menge,
 V.einh_id,
  CASE
  WHEN K.wrg_id <> 'EUR' AND MAN.default_wrg = 'EUR' OR USER_WRG.wrg_typ_id = 0
  THEN V.umsatz_brutto * KURS.umrechnungskurs
  ELSE V.umsatz_brutto
  END AS umsatz_brutto,
 V.kpos_erfassung_id,
 M.mwst
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON K.mandant_id = V05.mandant_id AND K.wup_id = V05.wup_id AND (V05.nb_id
       IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf AS V ON K.bon_id = V.bon_id AND K.wup_id = V.wup_id AND K.mandant_id
     = V.mandant_id AND K.bon_dat = V.bon_dat
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS M ON V.mandant_id = M.mandant_id AND V.mwst_id = M.mwst_id AND V.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art AS A ON V.kl_art_id = A.kl_art_id AND V.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS MAN ON K.mandant_id = MAN.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_kurs AS KURS ON K.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS USER_WRG ON TRUE
WHERE V.wg_id <> 961
 AND (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno);