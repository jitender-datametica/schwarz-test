CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm_materialized.mv_ods_bon_f_retoure(USERID STRING) AS SELECT K.bon_id,
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
 R.bon_zeile,
 R.kl_art_id,
 A.art_id,
 R.ean_kasse,
 R.menge,
 R.einh_id,
 R.umsatz_brutto AS test,
  CASE
  WHEN K.wrg_id <> 'EUR' AND MAN.default_wrg = 'EUR' OR USER_WRG.wrg_typ_id = 0
  THEN R.umsatz_brutto * KURS.umrechnungskurs
  ELSE R.umsatz_brutto
  END AS umsatz_brutto,
 M.mwst,
 R.reklamationsgrund_id,
 R.reklamationstyp_id,
 R.menge_fg,
 R.mhd,
 R.los_charge,
 R.kunden_text,
 R.art_id_ref,
 R.kpos_erfassung_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON K.mandant_id = V05.mandant_id AND V05.wup_id = CASE
      WHEN SAFE_CAST(ROUND(K.wup_id) AS INTEGER) = 0
      THEN NULL
      ELSE SAFE_CAST(ROUND(K.wup_id) AS INTEGER)
      END AND K.wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id =
      0)
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_retoure AS R ON K.bon_id = R.bon_id AND K.wup_id = R.wup_id AND K.mandant_id
    = R.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS M ON R.mandant_id = M.mandant_id AND R.mwst_id = M.mwst_id AND K.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art AS A ON R.kl_art_id = A.kl_art_id AND R.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS MAN ON K.mandant_id = MAN.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_kurs AS KURS ON K.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS USER_WRG ON TRUE
WHERE (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno);