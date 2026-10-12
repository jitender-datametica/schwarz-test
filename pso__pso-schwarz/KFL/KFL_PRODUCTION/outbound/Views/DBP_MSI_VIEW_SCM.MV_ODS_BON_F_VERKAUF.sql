-- Fakt-View
 -- 20140211 : Korrektur MWSt (CROSS JOIN auf LU)
 -- Gefiltert, d.h. nur nicht stornierte Bons enthalten

-- 2014KW05 : Anpassung MWSt (ID anstelle Satz)
 -- 2024-10-15,AP0242994, nwag2310, remove WG961

-- 201200620: MWST CROSS JOIN über Intervall wg. temp. Senkung in DE

-- 20190819: Einfuegen bon_dat in CROSS JOIN-Bedingung wegen Bondaten RDS

-- 2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- 20220804; richternic, AP0132142, SPEC0154921, Einfuegen der Auswahl der Waehrung

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_ods_bon_f_verkauf(USERID STRING) AS SELECT K.bon_id,
 K.bon_dat,
 K.bon_booking,
 K.dat_booking -- , k.wup_id

 -- , CASE WHEN TRY_CAST(k.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id
,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 K.mandant_id,
 K.kasse_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
 K.turnover_fg -- , wrg_typ.wrg_id --k.wrg_id
,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN KURS.nach_wrg_id
  ELSE MAN.default_wrg
  END AS wrg_id,
 K.kasse_typ_id,
 V.bon_zeile,
 V.kl_art_id,
 A.art_id,
 V.ean_kasse -- ,v.wg_id
,
 V.menge,
 V.einh_id -- , v.umsatz_brutto
,
  CASE
  WHEN K.wrg_id <> 'EUR' AND MAN.default_wrg = 'EUR' OR USER_WRG.wrg_typ_id = 0
  THEN V.umsatz_brutto * KURS.umrechnungskurs
  ELSE V.umsatz_brutto
  END AS umsatz_brutto,
 V.kpos_erfassung_id,
 M.mwst -- ,v.erfassung_id
 -- ,v.aktion_id

FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON K.mandant_id
    -- AND v05.wup_id = CASE WHEN TRY_CAST(k.wup_id  AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(k.wup_id  AS INTEGER) END

    = V05.mandant_id AND K.wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND
      V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf AS V ON K.bon_id = V.bon_id AND K.wup_id = V.wup_id AND K.mandant_id
     = V.mandant_id AND K.bon_dat = V.bon_dat
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS M ON V.mandant_id = M.mandant_id AND V.mwst_id = M.mwst_id AND V.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art AS A ON V.kl_art_id = A.kl_art_id AND V.mandant_id = A.mandant_id
   -- Fuer die Waehrungsauswahl

 INNER JOIN kfl_production_dbp_view.v_mandant AS MAN ON K.mandant_id = MAN.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_kurs AS KURS ON K.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS USER_WRG ON TRUE
WHERE V.wg_id <> 961
 AND (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno);