CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_lagerbestand_erp_per_2(USERID STRING) 
AS
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- 04.04.2022, AP0111566, SPEC0134176, dknop, changing to akt_msi_user_ek_anzeige_zu_log_2
--2 022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU
--2024-01-08, dknop, moving whole logic tbl_mv_lagerbestand_erp_per_2 to mv

SELECT
  v01.art_id AS art_id,
  v01.gjmo_buch AS gjmo_buch,
  v01.lagerort_id AS lagerort_id,
  v01.lagerort_loesch_fg AS lagerort_loesch_fg,
  v01.mandant_id AS mandant_id,
  v01.menge_lgbest_erp_frei_bme AS menge_lgbest_erp_frei_bme,
  v01.menge_lgbest_erp_gesp_bme AS menge_lgbest_erp_gesp_bme,
  v01.menge_lgbest_erp_kolli AS menge_lgbest_erp_kolli,
  v01.menge_lgbest_erp_nf_charge_bme AS menge_lgbest_erp_nf_charge_bme,
  v01.menge_lgbest_erp_palette AS menge_lgbest_erp_palette,
  v01.menge_lgbest_erp_qual_bme AS menge_lgbest_erp_qual_bme,
  v01.menge_lgbest_erp_ret_gesp_bme AS menge_lgbest_erp_ret_gesp_bme,
  v01.menge_lgbest_erp_umlag_bme AS menge_lgbest_erp_umlag_bme,
  CAST((v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_gesp_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_ret_gesp_bme + v01.menge_lgbest_erp_umlag_bme) AS NUMERIC) AS menge_lgbest_erp_bme,
  CASE
    WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_lgbest_erp * v02.umrechnungskurs * v05.ek_anzeige_fg)
    ELSE (v01.betrag_lgbest_erp * v05.ek_anzeige_fg) 
  END AS betrag_lgbest_erp,
  v01.nb_id AS nb_id,
  v01.pflege_status AS pflege_status,
  v01.sperr_id AS sperr_id,
  v01.wup_id AS wup_id,
  v04.dat AS dat,
  v03.wrg_id AS wrg_id,
  v03.wrg_typ_id AS wrg_typ_id,
  CASE
    WHEN v03.wrg_typ_id = 0 THEN (v01.vk_netto_lgbest_erp * v02.umrechnungskurs)
    ELSE v01.vk_netto_lgbest_erp 
  END AS vk_netto_lgbest_erp
FROM kfl_production_dbp_view.v_lagerbestand_erp_per_2 AS v01

JOIN (
  SELECT
    umrechnungskurs,
    von_wrg_id
  FROM kfl_production_dbp_view.v_kurs_2
  WHERE dat_bis = DATE('9999-12-31') AND kurstyp_id = 3
) AS v02
ON v01.wrg_id = v02.von_wrg_id

JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS v03
ON v01.mandant_id = v03.mandant_id
-- dbp_msi.akt_msi_user_wrg_typ_zu_2 v06
JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS v06 
ON v03.wrg_typ_id = v06.wrg_typ_id

JOIN kfl_production_dbp_view.v_tag_2 AS v04
ON v04.dat BETWEEN v01.dat_von AND v01.dat_bis

CROSS JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_log_2(USERID) AS v05;