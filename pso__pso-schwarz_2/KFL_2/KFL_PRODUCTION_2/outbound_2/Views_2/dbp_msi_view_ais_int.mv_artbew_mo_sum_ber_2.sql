CREATE OR REPLACE VIEW `kfl_production_dbp_msi_view_ais_int.mv_artbew_mo_sum_ber_2`
AS
SELECT
  v01.kjmo,
  v01.art_id,
  v01.mandant_id,
  v01.gp_id,
  v01.nb_id,
  v01.wup_id,
  v01.bewart_id,
  v01.bewart_det_id,
  v01.bq_findung_id,
  v01.bezugsweg_id,
  v01.posten_id,
  v01.posten_kz,
  v01.posten_id_per,
  v01.posten_kz_per,
  v01.wup_bereinigt_fg,
  v01.wup_bereinigt_fg_vj,
  v01.ean_kasse,

  COALESCE(
    CASE 
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
      ELSE CAST(v01.umsatz_netto AS NUMERIC) 
    END, 
    0
  ) AS umsatz_netto,


  COALESCE(CAST(v01.menge AS NUMERIC), 0) AS vk_menge,


  COALESCE(
    CASE 
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
      WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN (1001, 1010) THEN CAST(v01.umsatz_netto AS NUMERIC)
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001, 1010) THEN CAST(v01.umsatz_netto AS NUMERIC) 
    END, 
    0
  ) AS umsatz_netto_af,


  COALESCE(
    CASE 
      WHEN v01.bewart_id IN (1001, 1010) THEN CAST(v01.menge AS NUMERIC) 
    END, 
    0
  ) AS vk_menge_af,


  COALESCE(
    CASE 
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
      WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMERIC)
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMERIC) 
    END, 
    0
  ) AS umsatz_netto_sa,


  COALESCE(
    CASE 
      WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMERIC) 
    END, 
    0
  ) AS vk_menge_sa

FROM `kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_mo_sum_ber_2` AS v01
CROSS JOIN `kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2` AS v02;