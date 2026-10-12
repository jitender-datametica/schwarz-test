CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_bestellentwicklung_agg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  wewa_wwc.ekbe_mandant_id AS mandant_id,
  wewa_wwc.ekbe_wup_id AS ekbe_werks,
  wewa_wwc.ekbe_nb_id AS nb_id,
  wewa_wwc.ref_gj AS ekbe_lfgja,
  MIN(wewa_wwc.mkpf_dat_buch) AS mkpf_budat,
  MIN(wewa_wwc.mkpf_dat_beleg) AS mkpf_bldat,
  wewa_wwc.ekbe_best_beleg_id AS ekbe_ebeln,
  wewa_wwc.ekbe_best_beleg_pos_id AS ekbe_ebelp,
  TRIM(CAST(MIN(wewa_wwc.ekbe_best_beleg_id) AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(MIN(wewa_wwc.ekbe_best_beleg_pos_id) AS STRING FORMAT '0000')) AS ekbe_ebeln_zeile,
  wewa_wwc.ref_beleg_id AS ekbe_lfbnr,
  wewa_wwc.ref_beleg_pos_id AS ekbe_lfbpos,
  TRIM(CAST(MIN(wewa_wwc.ref_beleg_id) AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(MIN(wewa_wwc.ref_beleg_pos_id) AS STRING FORMAT '0000')) AS ekbe_lfbnr_zeile,
  CASE
    WHEN SUM(
      CASE
        WHEN wewa_wwc.ekbe_best_entw_typ_id_rech IN ('Q', 'N', 'K')
        THEN 1
        ELSE NULL
      END
    ) > 1
    THEN NULL
    ELSE MIN(wewa_wwc.rseg_wert_bestand_buchung)
  END AS rseg_stock_posting,
  CASE
    WHEN SUM(
      CASE
        WHEN wewa_wwc.ekbe_best_entw_typ_id_rech IN ('Q', 'N', 'K')
        THEN 1
        ELSE NULL
      END
    ) > 1
    THEN NULL
    ELSE MIN(wewa_wwc.rseg_wert_bestand_buchung_vp)
  END AS rseg_stock_posting_pp,
  MIN(wewa_wwc.mkpf_dat_buch) AS ekbe_budat_we,
  MIN(wewa_wwc.mkpf_dat_erfasst) AS mkpf_cpudt,
  MIN(CAST(TRIM(SUBSTR(CAST(wewa_wwc.mkpf_zeit_erfasst AS STRING), 1, 8)) AS TIME)) AS mkpf_cputm,
  CAST(REPLACE(
    SUBSTR(CAST(MIN(wewa_wwc.mkpf_dat_erfasst) AS STRING), 1, 11) || ' ' || COALESCE(
      SUBSTR(
        CAST(MIN(CAST(TRIM(SUBSTR(CAST(wewa_wwc.mkpf_zeit_erfasst AS STRING), 1, 8)) AS TIME)) AS STRING),
        1,
        8
      ),
      '00:00:00'
    ),
    ',',
    ':'
  ) AS DATETIME) AS mkpf_cpudt_cputm,
  SUM(
    wewa_wwc.ekbe_menge_basis * CASE WHEN wewa_wwc.ekbe_soll_haben_kz = 'H' THEN -1 ELSE 1 END
  ) AS ekbe_menge,
  SUM(
    wewa_wwc.ekbe_betrag * CASE WHEN wewa_wwc.ekbe_soll_haben_kz = 'H' THEN -1 ELSE 1 END
  ) AS ekbe_dmbtr_we,
  SUM(wewa_wwc.ekbe_menge_best) AS ekbe_bpmng_we,
  SUM(
    wewa_wwc.ekbe_betrag_wrbtr * CASE WHEN wewa_wwc.ekbe_soll_haben_kz = 'H' THEN -1 ELSE 1 END
  ) AS ekbe_wrbtr_we,
  MIN(CASE WHEN wewa_wwc.mseg_wrg_id = '' THEN NULL ELSE wewa_wwc.mseg_wrg_id END) AS ekbe_waers_we,
  SUM(CASE WHEN wewa_wwc.ekbe_best_entw_typ_id_we = 'E' THEN 1 ELSE NULL END) AS counter_we,
  SUM(
    wewa_wwc.ekbe_betrag_rech * CASE WHEN wewa_wwc.rseg_soll_haben_kz = 'H' THEN -1 ELSE 1 END
  ) AS ekbe_dmbtr_re,
  SUM(
    CASE
      WHEN wewa_wwc.ekbe_best_entw_typ_id_rech = 'N'
      THEN 0
      ELSE wewa_wwc.ekbe_menge_best_rech
    END
  ) AS ekbe_bpmng_re,
  SUM(
    wewa_wwc.ekbe_betrag_wrbtr_rech * CASE WHEN wewa_wwc.rseg_soll_haben_kz = 'H' THEN -1 ELSE 1 END
  ) AS ekbe_wrbtr_re,
  MIN(wewa_wwc.rseg_wrg_id) AS ekbe_waers_re,
  SUM(
    CASE
      WHEN wewa_wwc.ekbe_best_entw_typ_id_rech IN ('Q', 'N', 'K')
      THEN 1
      ELSE NULL
    END
  ) AS counter_re,
  MIN(wewa_wwc.ekko_dat_best_beleg) AS ekko_dat_best_beleg,
  MIN(wewa_wwc.ekpo_art_id) AS ekpo_matnr,
  MIN(CASE WHEN wewa_wwc.mseg_gp_id = 0 THEN NULL ELSE wewa_wwc.mseg_gp_id END) AS mseg_lifnr,
  MIN(
    CASE
      WHEN wewa_wwc.mseg_lager_bewart_id = ''
      THEN NULL
      ELSE wewa_wwc.mseg_lager_bewart_id
    END
  ) AS mseg_bwart,
  SUM(bznk.ekbz_dmbtr) AS ekbz_dmbtr
FROM kfl_production_dbp_view.v_wewa_wwc_1 AS wewa_wwc_1
LEFT JOIN (
  SELECT
    folge_beleg_id,
    folge_beleg_pos_id,
    kj,
    mandant_id,
    SUM(CASE WHEN soll_haben_kko = 'S' THEN -1 ELSE 1 END * betrag_kondition) AS ekbz_dmbtr
  FROM kfl_production_dbp_view.v_best_belegfluss_bnk_1
  GROUP BY
    folge_beleg_id,
    folge_beleg_pos_id,
    kj,
    mandant_id
) AS bznk
  ON wewa_wwc.mseg_beleg_id = bznk.folge_beleg_id
  AND wewa_wwc.mseg_beleg_pos_id = bznk.folge_beleg_pos_id
  AND wewa_wwc.mseg_kj = bznk.kj
  AND wewa_wwc.ekbe_mandant_id = bznk.mandant_id
GROUP BY
  mandant_id,
  ekbe_werks,
  nb_id,
  ekbe_lfgja,
  ekbe_ebeln,
  ekbe_ebelp,
  ekbe_lfbnr,
  ekbe_lfbpos;