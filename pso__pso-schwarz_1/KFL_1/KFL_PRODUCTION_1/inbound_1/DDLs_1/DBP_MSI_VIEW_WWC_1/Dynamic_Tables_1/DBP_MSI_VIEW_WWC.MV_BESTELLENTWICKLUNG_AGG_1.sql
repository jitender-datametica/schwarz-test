CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_BESTELLENTWICKLUNG_AGG_1
-- Die Logik ist analog mv_bestellentwicklung_1
-- Sinn dieser View ist eine_1 Aggregierte Sicht im Bericht Preisentwicklung
-- Die auskommentierten Felder bleiben ersteinmal enthalten
-- Kann entfernt werden, wenn nach einer 'gewissen' Zeit_1 auf P keine Änderungen mehr erforderlich sind
(
mandant_id
,EKBE_WERKS
,nb_id
--,EKBE_BELNR
--,EKBE_BUZEI
--,EKBE_BELNR_ZEILE
,EKBE_LFGJA
--,EKBE_GJAHR
,MKPF_BUDAT
,MKPF_BLDAT
,EKBE_EBELN
,EKBE_EBELP
,EKBE_EBELN_ZEILE
,EKBE_LFBNR
,EKBE_LFBPOS
,EKBE_LFBNR_ZEILE
--,EKBE_SHKZ
--,EKBE_BEWTP
--,RBKP_BLART
--,RBKP_BLDAT
--,RSEG_GJAHR
--,RSEG_BELNR
--,RSEG_BUZEI
--,RSEG_BELNR_ZEILE
--,RSEG_SHKZG
--,RSEG_SALK3
--,RSEG_LBKUM
--,RSEG_VMSAL
--,RSEG_VRKUM
,RSEG_STOCK_POSTING
,RSEG_STOCK_POSTING_PP
--,XRUEB

/* Wareneingänge */
--,EKBE_BEWTP_WE
,EKBE_BUDAT_WE
,MKPF_CPUDT
,MKPF_CPUTM
,MKPF_CPUDT_CPUTM
,EKBE_MENGE
,EKBE_DMBTR_WE
,EKBE_BPMNG_WE
,EKBE_WRBTR_WE
,EKBE_WAERS_WE
,counter_we

/* Rechnungen */
--,EKBE_BEWTP_RE
--,EKBE_BUDAT_RE
--,RBKP_CPUDT
--,RBKP_CPUTM
--,RBKP_CPUDT_CPUTM
,EKBE_DMBTR_RE
,EKBE_BPMNG_RE
,EKBE_WRBTR_RE
,EKBE_WAERS_RE
,counter_re

,ekko_dat_best_beleg

,EKPO_MATNR
--,MSEG_LBKUM
--,MSEG_SALK3
,MSEG_LIFNR
,MSEG_BWART

,EKBZ_DMBTR


) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
   SELECT
   mandant_id
   , EKBE_WERKS
   , nb_id
   , EKBE_LFGJA
   , MIN(MKPF_BUDAT) AS MKPF_BUDAT
   , MIN(MKPF_BLDAT) AS MKPF_BLDAT
   , EKBE_EBELN
   , EKBE_EBELP
   , TO_VARCHAR(MIN(EKBE_EBELN), 'FM0000000000') ||' ' || TO_VARCHAR(MIN(EKBE_EBELP), 'FM0000') AS EKBE_EBELN_ZEILE
   , EKBE_LFBNR
   , EKBE_LFBPOS
   , TO_VARCHAR(MIN(EKBE_LFBNR), 'FM0000000000') ||' ' || TO_VARCHAR(MIN(EKBE_LFBPOS), 'FM0000') AS EKBE_LFBNR_ZEILE
   , CASE WHEN SUM(counter_re) > 1 THEN NULL ELSE MIN(RSEG_STOCK_POSTING)    END AS RSEG_STOCK_POSTING
   , CASE WHEN SUM(counter_re) > 1 THEN NULL ELSE MIN(RSEG_STOCK_POSTING_PP) END AS RSEG_STOCK_POSTING_PP
   , MIN(EKBE_BUDAT_WE) AS EKBE_BUDAT_WE, MIN(MKPF_CPUDT) AS MKPF_CPUDT, MIN(MKPF_CPUTM) AS MKPF_CPUTM
   , CAST(CAST(MIN(MKPF_CPUDT) AS CHAR(11))|| ' ' ||COALESCE(CAST(MIN(MKPF_CPUTM) AS CHAR(8)),'00:00:00') AS TIMESTAMP) AS MKPF_CPUDT_CPUTM
   , SUM(EKBE_MENGE) AS EKBE_MENGE
   , SUM(EKBE_DMBTR_WE) AS EKBE_DMBTR_WE
   , SUM(EKBE_BPMNG_WE) AS EKBE_BPMNG_WE
   , SUM(EKBE_WRBTR_WE) AS EKBE_WRBTR_WE
   , MIN(EKBE_WAERS_WE) AS EKBE_WAERS_WE
   , SUM(counter_we) AS counter_we
   , SUM(EKBE_DMBTR_RE) AS EKBE_DMBTR_RE
   , SUM(EKBE_BPMNG_RE) AS EKBE_BPMNG_RE
   , SUM(EKBE_WRBTR_RE) AS EKBE_WRBTR_RE
   , MIN(EKBE_WAERS_RE) AS EKBE_WAERS_RE
   , SUM(counter_re) AS counter_re
   , MIN(ekko_dat_best_beleg) AS ekko_dat_best_beleg
   , MIN(EKPO_MATNR) AS EKPO_MATNR
   , MIN(MSEG_LIFNR) AS MSEG_LIFNR
   , MIN(MSEG_BWART) AS MSEG_BWART
   , SUM(EKBZ_DMBTR)

   FROM
   (
   SELECT
   wewa_wwc.ekbe_mandant_id              AS mandant_id, wewa_wwc.ekbe_wup_id                  AS EKBE_WERKS, wewa_wwc.ekbe_nb_id                   AS nb_id, wewa_wwc.ref_gj                       AS EKBE_LFGJA, wewa_wwc.mkpf_dat_buch                AS MKPF_BUDAT, wewa_wwc.mkpf_dat_beleg               AS MKPF_BLDAT, wewa_wwc.ekbe_best_beleg_id           AS EKBE_EBELN, wewa_wwc.ekbe_best_beleg_pos_id       AS EKBE_EBELP, wewa_wwc.ref_beleg_id                 AS EKBE_LFBNR, wewa_wwc.ref_beleg_pos_id             AS EKBE_LFBPOS, TO_VARCHAR(wewa_wwc.ref_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(wewa_wwc.ref_beleg_pos_id, 'FM0000') AS EKBE_LFBNR_ZEILE, wewa_wwc.rseg_wert_bestand_buchung    AS RSEG_STOCK_POSTING, wewa_wwc.rseg_wert_bestand_buchung_vp AS RSEG_STOCK_POSTING_PP, CASE WHEN wewa_wwc.ekbe_soll_haben_kz = 'H' THEN -1 ELSE 1 END AS vorzeichen, CASE WHEN wewa_wwc.rseg_soll_haben_kz = 'H' THEN -1 ELSE 1 END AS vorzeichen_rseg, wewa_wwc.mkpf_dat_buch                                         AS EKBE_BUDAT_WE, wewa_wwc.mkpf_dat_erfasst                                      AS MKPF_CPUDT, CAST(CAST(wewa_wwc.mkpf_zeit_erfasst AS CHAR(8)) AS TIME)      AS MKPF_CPUTM, wewa_wwc.ekbe_menge_basis  * vorzeichen                        AS EKBE_MENGE, wewa_wwc.ekbe_betrag       * vorzeichen                        AS EKBE_DMBTR_WE, wewa_wwc.ekbe_menge_best                                       AS EKBE_BPMNG_WE, wewa_wwc.ekbe_betrag_wrbtr * vorzeichen                        AS EKBE_WRBTR_WE, CASE wewa_wwc.mseg_wrg_id WHEN '' THEN NULL ELSE wewa_wwc.mseg_wrg_id END AS EKBE_WAERS_WE, CASE WHEN wewa_wwc.ekbe_best_entw_typ_id_we = 'E' THEN 1 ELSE NULL END AS counter_we, wewa_wwc.ekbe_best_entw_typ_id_rech                            AS EKBE_BEWTP_RE, wewa_wwc.ekbe_dat_buch_rech                                    AS EKBE_BUDAT_RE, wewa_wwc.rbkp_dat_erfasst                                      AS RBKP_CPUDT, CAST(CAST(wewa_wwc.rbkp_zeit_erfasst AS CHAR(8)) AS TIME)      AS RBKP_CPUTM, CAST(CAST(wewa_wwc.rbkp_dat_erfasst AS CHAR(11))|| ' '||COALESCE(CAST(wewa_wwc.rbkp_zeit_erfasst AS CHAR(8)),'00:00:00') AS TIMESTAMP) AS RBKP_CPUDT_CPUTM, wewa_wwc.ekbe_betrag_rech       * vorzeichen_rseg              AS EKBE_DMBTR_RE, CASE WHEN wewa_wwc.ekbe_best_entw_typ_id_rech = ('N') THEN 0 ELSE wewa_wwc.ekbe_menge_best_rech END AS EKBE_BPMNG_RE, wewa_wwc.ekbe_betrag_wrbtr_rech * vorzeichen_rseg              AS EKBE_WRBTR_RE, wewa_wwc.rseg_wrg_id                                           AS EKBE_WAERS_RE, CASE WHEN wewa_wwc.ekbe_best_entw_typ_id_rech IN ('Q','N','K') THEN 1 ELSE NULL END AS counter_re, wewa_wwc.ekko_dat_best_beleg    AS ekko_dat_best_beleg, wewa_wwc.ekpo_art_id            AS EKPO_MATNR, CASE WHEN wewa_wwc.mseg_gp_id = 0 THEN NULL ELSE wewa_wwc.mseg_gp_id END AS MSEG_LIFNR, CASE wewa_wwc.mseg_lager_bewart_id WHEN '' THEN NULL ELSE wewa_wwc.mseg_lager_bewart_id END AS MSEG_BWART, EKBZ_DMBTR

   FROM dbp_view.v_wewa_wwc_1 AS wewa_wwc_1
   LEFT JOIN
   (SELECT folge_beleg_id, folge_beleg_pos_id, kj, mandant_id, SUM((CASE WHEN soll_haben_kko = 'S' THEN -1 ELSE 1 END) * betrag_kondition) AS EKBZ_DMBTR
   FROM dbp_view.v_best_belegfluss_bnk_1
   GROUP BY folge_beleg_id
   ,folge_beleg_pos_id
   ,kj
   ,mandant_id
   ) AS bznk
   ON wewa_wwc.mseg_beleg_id     = bznk.folge_beleg_id
   AND wewa_wwc.mseg_beleg_pos_id = bznk.folge_beleg_pos_id
   AND wewa_wwc.mseg_kj           = bznk.kj
   AND wewa_wwc.ekbe_mandant_id   = bznk.mandant_id

   ) t1_1

   GROUP BY
   mandant_id
   ,EKBE_WERKS
   ,nb_id

   ,EKBE_LFGJA
   --,EKBE_GJAHR
   ,EKBE_EBELN
   ,EKBE_EBELP

   ,EKBE_LFBNR
   ,EKBE_LFBPOS
;