-- 20220804; richternic, AP0132142, SPEC0154921, Einfuegen der Auswahl der Waehrung

-- 201200620: MWST CROSS JOIN über Intervall wg. temp. Senkung in DE
 -- Fakt-View

-- 20190819: Einfuegen bon_dat in CROSS JOIN-Bedingung wegen Bondaten RDS

-- Gefiltert, d.h. nur nicht stornierte Bons enthalten
 -- 20140211 : Korrektur MWSt (CROSS JOIN auf LU)

-- 2014KW05 : Anpassung MWSt (ID anstelle Satz)

-- 2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_ods_bon_f_retoure_1(USERID STRING) AS -- wieder löschen
 SELECT K.bon_id,
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
 R.bon_zeile,
 R.kl_art_id,
 A.art_id,
 R.ean_kasse,
 R.menge,
 R.einh_id,
 R.umsatz_brutto AS test_1,
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
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS K
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON K.mandant_id = V05.mandant_id AND V05.wup_id = CASE
      WHEN SAFE_CAST(K.wup_id AS BIGNUMERIC) = 0
      THEN NULL
      ELSE SAFE_CAST(K.wup_id AS BIGNUMERIC)
      END AND K.wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id
       = 0)
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_retoure_1 AS R ON K.bon_id = R.bon_id AND K.wup_id = R.wup_id AND K.mandant_id
    = R.mandant_id -- AND k.bon_dat = r.bon_dat

 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS M ON R.mandant_id = M.mandant_id AND R.mwst_id = M.mwst_id AND K.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON R.kl_art_id = A.kl_art_id AND R.mandant_id = A.mandant_id
   -- Fuer die Waehrungsauswahl

 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS MAN ON K.mandant_id = MAN.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_kurs_1 AS KURS_1 ON K.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS USER_WRG ON TRUE
WHERE (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_1);