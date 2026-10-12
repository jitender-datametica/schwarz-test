-- 3rd check - dups on KLs inside SL?


CREATE OR REPLACE TEMPORARY TABLE _dup1 AS
SELECT
    mandant_id,
    art_id,
    kjwo_update,
    COUNT(DISTINCT matching_id) AS anz,
    MAX(matching_id) AS max_match_id,
    MIN(matching_id) AS min_match_id
FROM dbp_data.sortiment_leistung_2
WHERE
    art_id IS NOT NULL
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
    )
GROUP BY
    mandant_id,
    kjwo_update,
    art_id
HAVING anz > 1;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, art_id, kjwo_update) IN (SELECT (mandant_id, art_id, kjwo_update)
FROM `_dup1`) AND (mandant_id, art_id, matching_id) NOT IN (
    SELECT (mandant_id, art_id, art_matching_id)
    FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            A.art_matching_id
        FROM dbp_etl.art_matching_nielsen_per_kmo_2 AS A
        INNER JOIN `_dup1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.art_matching_id = B.max_match_id

        UNION DISTINCT
        SELECT
            A.mandant_id,
            A.art_id,
            A.art_matching_id
        FROM dbp_etl.art_matching_nielsen_per_kmo_2 AS A
        INNER JOIN `_dup1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.art_matching_id = B.min_match_id
    ) AS t2
);


CREATE OR REPLACE TEMPORARY TABLE _dup_free_2 AS
SELECT
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    MAX(kl_wg_id) AS kl_wg_id,
    MAX(kl_owg_id) AS kl_owg_id,
    MAX(kl_uwg_id) AS kl_uwg_id,
    MAX(owg_id) AS owg_id,
    MAX(wg_id) AS wg_id,
    MAX(wug_id) AS wug_id,
    MAX(rang_umsatz_wg) AS rang_umsatz_wg,
    MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
    MAX(rang_absatz_uwg) AS rang_absatz_uwg,
    MAX(art_id) AS art_id,
    MAX(kl_art_id) AS kl_art_id,
    MAX(art_bez) AS art_bez,
    MAX(art_status) AS art_status,
    MAX(gp_id) AS gp_id,
    MAX(akt_lieferant) AS akt_lieferant,
    MAX(disc_pe) AS disc_pe,
    MAX(disc_marke) AS disc_marke,
    MAX(lcf) AS lcf,
    MAX(vegan) AS vegan,
    MAX(gluten) AS gluten,
    MAX(bio) AS bio,
    MAX(eigenmarke) AS eigenmarke,
    MAX(tierwohl) AS tierwohl,
    MAX(posten_food) AS posten_food,
    MAX(posten_nonfood) AS posten_nonfood,
    MAX(mwst) AS mwst,
    MAX(listung_k_sst_mvke) AS listung_k_sst_mvke,
    MAX(gewichtete_distribution) AS gewichtete_distribution,
    MAX(index_af_id) AS index_af_id,
    MAX(umsatz_af_pro_markt_woche) AS umsatz_af_pro_markt_woche,
    MAX(absatz_af_pro_markt_woche) AS absatz_af_pro_markt_woche,
    MAX(ertrag_af_pro_markt_woche) AS ertrag_af_pro_markt_woche,
    MAX(bonreichweite_af) AS bonreichweite_af,
    MAX(spanne_af) AS spanne_af,
    MAX(index_sa_id) AS index_sa_id,
    MAX(umsatz_sa_pro_markt_woche) AS umsatz_sa_pro_markt_woche,
    MAX(absatz_sa_pro_markt_woche) AS absatz_sa_pro_markt_woche,
    MAX(ertrag_sa_pro_markt_woche) AS ertrag_sa_pro_markt_woche,
    MAX(bonreichweite_sa) AS bonreichweite_sa,
    MAX(spanne_sa) AS spanne_sa,
    MAX(aktionsanteil_absatz) AS aktionsanteil_absatz,
    MAX(absatz_total) AS absatz_total,
    MAX(schnelldreherquote) AS schnelldreherquote,
    MAX(schnelldreherquote_wg) AS schnelldreherquote_wg,
    MAX(schnelldreherquote_owg) AS schnelldreherquote_owg,
    MAX(kolliabverkaufsquote) AS kolliabverkaufsquote,
    MAX(kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
    MAX(kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
    MAX(abschriftsanteil) AS abschriftsanteil,
    MAX(abschriftsanteil_wg) AS abschriftsanteil_wg,
    MAX(abschriftsanteil_owg) AS abschriftsanteil_owg,
    MAX(cherrypicker_quote) AS cherrypicker_quote,
    MAX(cherrypicker_quote_wg) AS cherrypicker_quote_wg,
    MAX(cherrypicker_quote_owg) AS cherrypicker_quote_owg,
    MAX(restbon) AS restbon,
    MAX(restbon_wg) AS restbon_wg,
    MAX(restbon_owg) AS restbon_owg,
    MAX(vk_preis) AS vk_preis,
    MAX(durchschnittspreis) AS durchschnittspreis,
    MAX(preislagenverteilung) AS preislagenverteilung,
    MAX(marktanteilbewertung) AS marktanteilbewertung,
    MAX(produktwissen_vp) AS produktwissen_vp,
    MAX(lieferantenwissen_vp) AS lieferantenwissen_vp,
    MAX(produktwissen_pflege) AS produktwissen_pflege,
    MAX(lieferantenwissen_pflege) AS lieferantenwissen_pflege,
    MAX(listung_sst_pflege) AS listung_sst_pflege,
    MAX(ost_basis_pflege) AS ost_basis_pflege,
    MAX(ost_gross_pflege) AS ost_gross_pflege,
    MAX(sued_ost_pflege) AS sued_ost_pflege,
    MAX(sued_west_pflege) AS sued_west_pflege,
    MAX(west_pflege) AS west_pflege,
    MAX(nord_pflege) AS nord_pflege,
    MAX(vorschlag) AS vorschlag,
    MAX(stk_re_pflege) AS stk_re_pflege,
    MAX(umsatz_hr) AS umsatz_hr,
    MAX(absatz_hr) AS absatz_hr,
    MAX(rohertrag_hr) AS rohertrag_hr,
    MAX(nielsen_art_bez) AS nielsen_art_bez,
    MAX(gtin) AS gtin,
    MAX(distr_gew) AS distr_gew,
    MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
    MAX(umsatz_anteil_uwg_kumuliert) AS umsatz_anteil_uwg_kumuliert,
    MAX(durchschnitt_anz_maerkte) AS durchschnitt_anz_maerkte,
    MAX(durchschnitt_preis) AS durchschnitt_preis,
    MAX(kl_markt_anteil_owg) AS kl_markt_anteil_owg,
    MAX(umsatz_artikel) AS umsatz_artikel,
    MAX(absatz_artikel) AS absatz_artikel,
    MAX(anz_monate) AS anz_monate,
    MAX(anz_wochen) AS anz_wochen,
    MAX(eigenmarke_fg) AS eigenmarke_fg,
    MAX(listung_sst_mvke) AS listung_sst_mvke,
    MAX(ost_basis) AS ost_basis,
    MAX(ost_gross) AS ost_gross,
    MAX(sued_ost) AS sued_ost,
    MAX(sued_west) AS sued_west,
    MAX(west) AS west,
    MAX(nord) AS nord,
    MAX(anz_maerkte_sst) AS anz_maerkte_sst,
    MAX(anz_maerkte_baustein_sonstige) AS anz_maerkte_baustein_sonstige,
    MAX(anz_maerkte_listung_einzel) AS anz_maerkte_listung_einzel,
    MAX(anz_maerkte_listung_gesamt) AS anz_maerkte_listung_gesamt,
    MAX(listungsaktion) AS listungsaktion,
    MAX(anz_maerkte_k_sst) AS anz_maerkte_k_sst,
    MAX(listung_k_sst_pflege) AS listung_k_sst_pflege,
    MAX(muki_wb_kz) AS muki_wb_kz,
    MAX(muki_wb_kl_art_id_verkettung) AS muki_wb_kl_art_id_verkettung,
    MAX(muki_vk_kz) AS muki_vk_kz,
    MAX(muki_vk_kl_art_id_verkettung) AS muki_vk_kl_art_id_verkettung,
    MAX(muki_ek_kz) AS muki_ek_kz,
    MAX(muki_ek_kl_art_id_verkettung) AS muki_ek_kl_art_id_verkettung,
    MAX(absatz_total_vj) AS absatz_total_vj,
    MAX(max_anz_maerkte_sst) AS max_anz_maerkte_sst,
    MAX(max_anz_maerkte_k_sst) AS max_anz_maerkte_k_sst,
    MAX(kassenumsatz_kl_absolut_brutto) AS kassenumsatz_kl_absolut_brutto,
    MAX(kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto,
    MAX(abschriften_wert_netto_absolut) AS abschriften_wert_netto_absolut,
    MAX(td_insert) AS td_insert,
    MAX(td_update) AS td_update,
    MAX(zek_id) AS zek_id,
    MAX(wrg_id) AS wrg_id
FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id)
    FROM dbp_data.sortiment_leistung_2
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung_2
        )
    GROUP BY
        mandant_id,
        matching_id,
        kjwo_update
    HAVING COUNT(*) > 1
)
GROUP BY
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (
    mandant_id, kjwo_update, matching_id) IN (
    SELECT (mandant_id, kjwo_update, matching_id)
    FROM `_dup_free_2`
);


INSERT INTO dbp_data.sortiment_leistung_2
(SELECT
    mandant_id,
    kjmo,
    matching_id,
    kjwo_update,
    kl_wg_id, --pe_review
    kl_owg_id,
    kl_uwg_id,
    owg_id,
    wg_id,
    wug_id,
    rang_umsatz_wg,
    rang_umsatz_uwg,
    rang_absatz_uwg,
    art_id,
    kl_art_id,--pe_review
    art_bez,
    art_status,
    gp_id, --pe_review
    akt_lieferant, --pe_review
    disc_pe, --pe_review
    disc_marke,--pe_review
    lcf, --pe_review
    vegan,--pe_review
    gluten,
    bio,
    eigenmarke,
    tierwohl,
    posten_food,
    posten_nonfood,
    mwst, --pe_review
    listung_k_sst_mvke,
    gewichtete_distribution,
    index_af_id,--pe_review
    umsatz_af_pro_markt_woche,
    absatz_af_pro_markt_woche ,
    ertrag_af_pro_markt_woche,
    bonreichweite_af,
    spanne_af,
    index_sa_id,
    umsatz_sa_pro_markt_woche,
    absatz_sa_pro_markt_woche,
    ertrag_sa_pro_markt_woche,
    bonreichweite_sa,
    spanne_sa,
    aktionsanteil_absatz,
    absatz_total,
    schnelldreherquote,
    schnelldreherquote_wg,
    schnelldreherquote_owg,
    kolliabverkaufsquote,
    kolliabverkaufsquote_wg,
    kolliabverkaufsquote_owg,
    abschriftsanteil,
    abschriftsanteil_wg,
    abschriftsanteil_owg,
    cherrypicker_quote,
    cherrypicker_quote_wg,
    cherrypicker_quote_owg,
    restbon,
    restbon_wg,
    restbon_owg,
    vk_preis,
    durchschnittspreis,
    preislagenverteilung,
    marktanteilbewertung,
    produktwissen_vp,
    lieferantenwissen_vp,
    produktwissen_pflege,
    lieferantenwissen_pflege,
    listung_sst_pflege,
    ost_basis_pflege,
    ost_gross_pflege,
    sued_ost_pflege,
    sued_west_pflege,
    west_pflege,
    nord_pflege,
    vorschlag,
    stk_re_pflege,
    umsatz_hr,--pe_review
    absatz_hr,--pe_review
    rohertrag_hr,
    nielsen_art_bez,
    gtin,
    distr_gew,--pe_review
    umsatz_anteil_uwg,--pe_review
    umsatz_anteil_uwg_kumuliert,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    kl_markt_anteil_owg,
    umsatz_artikel,
    absatz_artikel,
    anz_monate,
    anz_wochen,
    eigenmarke_fg,
    listung_sst_mvke,--pe_review
    ost_basis,--pe_review
    ost_gross,
    sued_ost,
    sued_west,
    west,
    nord,
    anz_maerkte_sst,--pe_review
    anz_maerkte_baustein_sonstige,--pe_review
    anz_maerkte_listung_einzel,
    anz_maerkte_listung_gesamt,
    listungsaktion,--pe_review
    anz_maerkte_k_sst,
    listung_k_sst_pflege,
    muki_wb_kz,--pe_review
    muki_wb_kl_art_id_verkettung,
    muki_vk_kz,
    muki_vk_kl_art_id_verkettung,
    muki_ek_kz,
    muki_ek_kl_art_id_verkettung,
    absatz_total_vj,--pe_review
    max_anz_maerkte_sst,--pe_review
    max_anz_maerkte_k_sst,
    kassenumsatz_kl_absolut_brutto,
    kassenumsatz_kl_absolut_netto ,
    abschriften_wert_netto_absolut,
    td_insert,
    td_update,
    zek_id,--pe_review
    wrg_id --pe_review
FROM _dup_free_2);
