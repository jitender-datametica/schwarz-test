DELETE FROM dbp_data.artbew_dat_ek_cp_sum_1
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT MAX(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
) AND transaktion_typ_id = 0;


INSERT INTO dbp_data.artbew_dat_ek_cp_sum_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat,
    wrg_id,
    wup_bereinigt_fg,
    zek_id,
    gp_id,
    eigenmarke_fg,
    umsatz_netto,
    umsatz_netto_vj,
    betrag_kmep_kw,
    betrag_kmep_kw_vj,
    betrag_kmep_ww,
    betrag_kmep_ww_vj,
    betrag_kmep_km,
    betrag_kmep_km_vj,
    betrag_kmep_o_fwu_kw,
    betrag_kmep_o_fwu_kw_vj,
    betrag_kmep_o_fwu_ww,
    betrag_kmep_o_fwu_ww_vj,
    betrag_kmep_o_fwu_km,
    betrag_kmep_o_fwu_km_vj,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    preis_abschrift_netto,
    preis_abschrift_netto_vj, umrechnungskurs_hist
)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    wup_bereinigt_fg,
    zek_id,
    gp_id,
    eigenmarke_fg,
    umsatz_netto,
    umsatz_netto_vj,
    ROUND(CAST(betrag_kmep_kw AS NUMERIC), 4) AS betrag_kmep_kw,
    ROUND(CAST(betrag_kmep_kw_vj AS NUMERIC), 4) AS betrag_kmep_kw_vj,
    ROUND(CAST(betrag_kmep_ww AS NUMERIC), 4) AS betrag_kmep_ww,
    ROUND(CAST(betrag_kmep_ww_vj AS NUMERIC), 4) AS betrag_kmep_ww_vj,
    ROUND(CAST(betrag_kmep_km AS NUMERIC), 4) AS betrag_kmep_km,
    ROUND(CAST(betrag_kmep_km_vj AS NUMERIC), 4) AS betrag_kmep_km_vj,
    ROUND(CAST(a_betrag_kmep_o_fwu_kw AS NUMERIC), 4) AS a_betrag_kmep_o_fwu_kw,
    ROUND(CAST(a_betrag_kmep_o_fwu_kw_vj AS NUMERIC), 4)
        AS a_betrag_kmep_o_fwu_kw_vj,
    ROUND(CAST(a_betrag_kmep_o_fwu_ww AS NUMERIC), 4) AS a_betrag_kmep_o_fwu_ww,
    ROUND(CAST(a_betrag_kmep_o_fwu_ww_vj AS NUMERIC), 4)
        AS a_betrag_kmep_o_fwu_ww_vj,
    ROUND(CAST(a_betrag_kmep_o_fwu_km AS NUMERIC), 4) AS a_betrag_kmep_o_fwu_km,
    ROUND(CAST(a_betrag_kmep_o_fwu_km_vj AS NUMERIC), 4)
        AS a_betrag_kmep_o_fwu_km_vj,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    preis_abschrift_netto,
    preis_abschrift_netto_vj,
    umrechnungskurs_hist
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        A.umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_cz_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        A.umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_pl_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        A.umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_md_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        1 AS umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_sk_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        1 AS umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_hr_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        A.umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_ro_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        1 AS umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_bg_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_km, 0) AS a_betrag_kmep_o_fwu_km,
        COALESCE(A.betrag_kmep_o_fwu_km_vj, 0) AS a_betrag_kmep_o_fwu_km_vj,
        COALESCE(A.betrag_kmep_o_fwu_kw, 0) AS a_betrag_kmep_o_fwu_kw,
        COALESCE(A.betrag_kmep_o_fwu_kw_vj, 0) AS a_betrag_kmep_o_fwu_kw_vj,
        COALESCE(A.betrag_kmep_o_fwu_ww, 0) AS a_betrag_kmep_o_fwu_ww,
        COALESCE(A.betrag_kmep_o_fwu_ww_vj, 0) AS a_betrag_kmep_o_fwu_ww_vj,
        1 AS umrechnungskurs_hist,
        COALESCE(B.gp_id, -1) AS gp_id
    FROM dbp_etl.tag_wa_kalk_final_de_1 AS A
    LEFT JOIN
        dbp_etl.art_gp_nm_zu_per_fww_1
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.dat = B.dat
) AS t7);
