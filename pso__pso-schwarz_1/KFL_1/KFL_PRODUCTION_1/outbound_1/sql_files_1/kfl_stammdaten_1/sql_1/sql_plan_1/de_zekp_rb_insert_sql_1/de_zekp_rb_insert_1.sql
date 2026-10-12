DELETE FROM dbp_data.art_gp_wup_zu_per_1
WHERE mandant_id = 1;

--PE-Review
INSERT INTO dbp_data.art_gp_wup_zu_per_1
(mandant_id, gp_id, wup_id, nb_id, dat_von, bezugsweg_id, art_id, einkaufsorganisation_id, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten, zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id, td_insert, td_update, ek_mep_vor_fwu, ek_brutto_normal)
SELECT
    mandant_id,
    gp_id,
    wup_id,
    nb_id,
    dat_von,
    bezugsweg_id,
    art_id,
    einkaufsorganisation_id,
    dat_bis,
    ek_brutto,
    ek_netto,
    ek_nettonetto,
    ek_kal_basis,
    ek_mep,
    einstandspreis,
    logistikkostenzuschlag,
    wrg_id,
    komponentenmenge,
    ek_brutto_nrfb_rab,
    bonusbasis,
    bezugsnebenkosten,
    zollwert,
    ek_netto_bnk,
    ek_netto_bnk_sachk,
    cycle_id,
    td_insert,
    td_update,
    null,
    null
FROM dbp_etl.zekp_original
WHERE mandant_id = 1;
