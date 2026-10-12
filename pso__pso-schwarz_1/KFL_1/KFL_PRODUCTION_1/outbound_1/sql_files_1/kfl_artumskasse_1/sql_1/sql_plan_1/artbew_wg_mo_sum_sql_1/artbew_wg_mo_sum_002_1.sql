DELETE FROM dbp_data.artbew_wg_mo_sum_1
WHERE (
    mandant_id, kjmo) IN (
    SELECT (CAST(a.mandant_id AS INTEGER), CAST(T.kjmo AS INTEGER)) 		--pe_review
    FROM (SELECT
        mandant_id,
        ROUND(CAST(FORMAT_DATE('%Y%m', MAX(dat)) AS BIGNUMERIC), 0) AS max_kjmo,
        ROUND(CAST(FORMAT_DATE('%Y%m', MIN(dat)) AS BIGNUMERIC), 0) AS min_kjmo
    FROM dbp_data.artbew_agg_wt_1
    GROUP BY mandant_id) AS a
    INNER JOIN dbp_data.tag_1 AS T ON T.kjmo BETWEEN a.min_kjmo AND a.max_kjmo
    GROUP BY a.mandant_id,
    T.kjmo
);


INSERT INTO dbp_data.artbew_wg_mo_sum_1 (
    mandant_id, wup_id, nb_id, kjmo, bewart_id, posten_id,
    wg_id, arthiertyp_id, bewart_det_id, wrg_id, umrechnungskurs_hist, menge, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz,
    ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz,
    ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, ek_gld, diff_ek_gld_konz,
    bonusbasis, bonusbasis_konz, pv_aktion, pv_aktion_konz, pv_bby, pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz, pv_kdp_bby,
    pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz, pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby,
    pv_aktion_kdp_bby_konz, pv_bonrabatt_bby, pv_bonrabatt_bby_konz
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', dat) AS BIGNUMERIC), 0) AS INTEGER) AS kjmo,
        bewart_id,
        posten_id,
        wg_id,
        arthiertyp_id,
        bewart_det_id,
        wrg_id,
        MAX(umrechnungskurs_hist),
        SUM(menge),
        SUM(umsatz_netto),
        SUM(diff_umsatz_netto_konz),
        SUM(umsatz_mwst_betrag),
        SUM(diff_umsatz_mwst_betrag_konz),
        SUM(ek_brutto),
        SUM(diff_ek_brutto_konz),
        SUM(ek_netto),
        SUM(diff_ek_netto_konz),
        SUM(ek_nettonetto),
        SUM(diff_ek_nettonetto_konz),
        SUM(ek_kal_basis),
        SUM(diff_ek_kal_basis_konz),
        SUM(ek_mep),
        SUM(diff_ek_mep_konz),
        SUM(ek_mep_vor_fwu),
        SUM(ek_mep_vor_fwu_konz),
        SUM(einstandspreis),
        SUM(diff_einstandspreis_konz),
        SUM(logkostenzuschlag),
        SUM(diff_logkostenzuschlag_konz),
        SUM(ek_netto_bnk),
        SUM(diff_ek_netto_bnk_konz),
        SUM(ek_netto_bnk_sachk),
        SUM(diff_ek_netto_bnk_sachk_konz),
        SUM(ek_gld),
        SUM(diff_ek_gld_konz),
        SUM(bonusbasis),
        SUM(bonusbasis_konz),
        SUM(pv_aktion),
        SUM(pv_aktion_konz),
        SUM(pv_bby),
        SUM(pv_bby_konz),
        SUM(pv_kdn_bby),
        SUM(pv_kdn_bby_konz),
        SUM(pv_kdp_bby),
        SUM(pv_kdp_bby_konz),
        SUM(pv_aktion_bby),
        SUM(pv_aktion_bby_konz),
        SUM(pv_aktion_kdn_bby),
        SUM(pv_aktion_kdn_bby_konz),
        SUM(pv_aktion_kdp_bby),
        SUM(pv_aktion_kdp_bby_konz),
        SUM(pv_bonrabatt_bby),
        SUM(pv_bonrabatt_bby_konz)
    FROM dbp_data.artbew_wg_tp2_sum_1
    WHERE (
        mandant_id, dat) IN (
        SELECT (CAST(a.mandant_id AS INTEGER), T.dat)	--pe_review
        FROM (SELECT
            mandant_id,
            CAST((FORMAT_DATE('%Y-%m', MIN(dat)) || '-01') AS DATE) AS dat_von,       --pe_review
            DATE_SUB(IF(
                DATE(CAST((FORMAT_DATE('%Y-%m', MAX(dat)) || '-01') AS DATE)) = LAST_DAY(DATE(CAST((FORMAT_DATE('%Y-%m', MAX(dat)) || '-01') AS DATE))), LAST_DAY(DATE_ADD(DATE(CAST((FORMAT_DATE('%Y-%m', MAX(dat)) || '-01') AS DATE)), INTERVAL 1 MONTH)),        --pe_review
                DATE_ADD(DATE(CAST((FORMAT_DATE('%Y-%m', MAX(dat)) || '-01') AS DATE)), INTERVAL 1 MONTH)
            ), INTERVAL 1 DAY) AS dat_bis     --pe_review
        FROM dbp_data.artbew_agg_wt_1
        GROUP BY mandant_id) AS a
        INNER JOIN dbp_data.tag_1 AS T ON T.dat BETWEEN a.dat_von AND a.dat_bis
        GROUP BY a.mandant_id,
        T.dat
    )
    AND arthiertyp_id = 2
    GROUP BY
        bewart_id,
        bewart_det_id,
        arthiertyp_id,
        wg_id,
        wup_id,
        posten_id,
        mandant_id,
        nb_id,
        kjmo,
        wrg_id
);
