-- 18.10.2024
--
-- Rueckwirkende Aktualisierung der Werbeteams und -bereiche im Aktionsmanagement.


CREATE OR REPLACE TEMPORARY TABLE _murks AS
SELECT
    mandant_id,
    kjwo_ww,
    kjwo,
    mutter_wb_id,
    gp_id,
    COALESCE(konkat_aktion_thema_gruppe_id, '-1000') AS konkat_aktion_thema_gruppe_id,
    ROUND(CAST(value AS BIGNUMERIC), 0) AS kind_wg_id,
    CAST(NULL AS BIGNUMERIC) AS mutter_wg_id,
    '' AS konkat_werbeteam_cd,
    '' AS konkat_werbeteam_bez,
    '' AS werbebereich_cd
FROM (
    SELECT
        aktionsmanagement.mandant_id,
        aktionsmanagement.kjwo_ww,
        aktionsmanagement.kjwo,
        aktionsmanagement.mutter_wb_id,
        aktionsmanagement.konkat_kind_art_id,
        aktionsmanagement.konkat_aktion_thema_gruppe_id,
        aktionsmanagement.konkat_werbe_kat_id,
        aktionsmanagement.konkat_werbeteam_cd,
        aktionsmanagement.konkat_werbeteam_bez,
        aktionsmanagement.gp_id,
        aktionsmanagement.werbebereich_cd,
        aktionsmanagement.konkat_wg_id,
        aktionsmanagement.umsatz_netto_sa_west,
        aktionsmanagement.absatz_sa_west,
        aktionsmanagement.ek_mep_sa_west,
        aktionsmanagement.rohertrag_ek_mep_olk_sa_west,
        aktionsmanagement.spanne_ek_mep_olk_sa_west,
        aktionsmanagement.preisvorteil_west,
        aktionsmanagement.umsatz_netto_sa_ost,
        aktionsmanagement.absatz_sa_ost,
        aktionsmanagement.ek_mep_sa_ost,
        aktionsmanagement.rohertrag_ek_mep_olk_sa_ost,
        aktionsmanagement.spanne_ek_mep_olk_sa_ost,
        aktionsmanagement.preisvorteil_ost,
        aktionsmanagement.umsatz_netto_sa_sued,
        aktionsmanagement.absatz_sa_sued,
        aktionsmanagement.ek_mep_sa_sued,
        aktionsmanagement.rohertrag_ek_mep_olk_sa_sued,
        aktionsmanagement.spanne_ek_mep_olk_sa_sued,
        aktionsmanagement.preisvorteil_sued,
        aktionsmanagement.umsatz_netto_sa,
        aktionsmanagement.absatz_sa,
        aktionsmanagement.ek_mep_sa,
        aktionsmanagement.rohertrag_sa,
        aktionsmanagement.spanne_sa,
        aktionsmanagement.preisvorteil,
        aktionsmanagement.avq_1,
        aktionsmanagement.avq_3,
        aktionsmanagement.avq,
        aktionsmanagement.wareneingang_zl,
        aktionsmanagement.abverkaufte_menge_bestand,
        aktionsmanagement.abverkaufte_menge,
        aktionsmanagement.durchschnitt_menge_pro_filiale,
        aktionsmanagement.einheit_wb,
        aktionsmanagement.umsatz_netto,
        aktionsmanagement.durchschnitt_umsatz_pro_artike,
        aktionsmanagement.anz_nullbestand,
        aktionsmanagement.nullbestandsquote,
        aktionsmanagement.endbestand,
        aktionsmanagement.umschlagsquote,
        aktionsmanagement.anz_artikel,
        aktionsmanagement.anz_filialen,
        aktionsmanagement.umsatz_baseline,
        aktionsmanagement.umsatz_werbewoche,
        aktionsmanagement.umsatz_uplift,
        aktionsmanagement.umsatz_aktivierter_normalpreis,
        aktionsmanagement.absatz_baseline,
        aktionsmanagement.absatz_werbewoche,
        aktionsmanagement.absatz_uplift,
        aktionsmanagement.ertrag_baseline,
        aktionsmanagement.ertrag_werbewoche,
        aktionsmanagement.ertrag_uplift,
        aktionsmanagement.kaeufer_baseline,
        aktionsmanagement.kaeufer_werbewoche,
        aktionsmanagement.kaeufer_uplift,
        aktionsmanagement.kaeufer_reichweite_baseline,
        aktionsmanagement.kaeufer_reichweite_werbewoche,
        aktionsmanagement.kaeufer_reichweite_uplift,
        aktionsmanagement.cherrypicker_pp,
        aktionsmanagement.restbon_normalware,
        aktionsmanagement.restbon_gesamt,
        aktionsmanagement.restbon_tip,
        aktionsmanagement.anz_tage_sa,
        aktionsmanagement.anz_markt_sa,
        aktionsmanagement.baseline_wochen,
        aktionsmanagement.wa_kalk_nach_pv_sa,
        aktionsmanagement.wa_kalk_nach_pv_sa_sued,
        aktionsmanagement.wa_kalk_nach_pv_sa_ost,
        aktionsmanagement.wa_kalk_nach_pv_sa_west,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_sued,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_ost,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_west,
        aktionsmanagement.wa_kalk_nach_pv_sa_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_aktion_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_bby_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_kdn_bby_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_kdp_bby_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_non_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_aktion_non_loy,
        aktionsmanagement.wa_kalk_nach_pv_sa_bby_non_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_aktion_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_bby_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_kdn_bby_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_kdp_bby_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_non_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_aktion_non_loy,
        aktionsmanagement.spanne_wa_kalk_nach_pv_sa_bby_non_loy,
        aktionsmanagement.umsatz_netto_sa_aktion_loy,
        aktionsmanagement.umsatz_netto_sa_bby_loy,
        aktionsmanagement.umsatz_netto_sa_kdn_bby_loy,
        aktionsmanagement.umsatz_netto_sa_kdp_bby_loy,
        aktionsmanagement.umsatz_netto_sa_aktion_non_loy,
        aktionsmanagement.umsatz_netto_sa_bby_non_loy,
        aktionsmanagement.menge_sa_aktion_loy,
        aktionsmanagement.menge_sa_bby_loy,
        aktionsmanagement.menge_sa_kdn_bby_loy,
        aktionsmanagement.menge_sa_kdp_bby_loy,
        aktionsmanagement.menge_sa_aktion_non_loy,
        aktionsmanagement.menge_sa_bby_non_loy,
        aktionsmanagement.pv_aktion_loy,
        aktionsmanagement.pv_bby_loy,
        aktionsmanagement.pv_kdn_bby,
        aktionsmanagement.pv_kdp_bby,
        aktionsmanagement.pv_aktion_non_loy,
        aktionsmanagement.pv_bby_non_loy,
        aktionsmanagement.td_update,
        aktionsmanagement.td_insert,
        t.seq,
        ORDINALITY + 1 AS index,
        VALUE AS value
    FROM dbp_data.aktionsmanagement
    INNER JOIN (SELECT 1 AS seq) AS t ON TRUE
    INNER JOIN UNNEST(SPLIT(AKTIONSMANAGEMENT.KONKAT_WG_ID, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
) AS t1
WHERE t1.kjwo_ww BETWEEN (
    SELECT kjwo_ww
    FROM dbp_data.werbewoche_kl
    WHERE
        mandant_id = 1
        AND akt_kjwo_ww = -3
    GROUP BY kjwo_ww) AND (
    SELECT kjwo_ww
    FROM dbp_data.werbewoche_kl
    WHERE
        mandant_id = 1
        AND akt_kjwo_ww = 0
    GROUP BY kjwo_ww
);


DELETE FROM `_murks`
WHERE kind_wg_id IS NULL;


UPDATE `_murks` SET
    mutter_wg_id = b.wg_id FROM (
    SELECT
        B.mandant_id,
        B.art_id,
        B.wg_id
    FROM dbp_data.art AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE
        A.mandant_id = 1
        AND A.dat_bis = DATE '9999-12-31'
    GROUP BY
        B.mandant_id,
        B.art_id,
        B.wg_id
) AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.mutter_wb_id = b.art_id;


CREATE OR REPLACE TEMPORARY TABLE _wgs AS
SELECT
    A.mandant_id,
    A.wg_id,
    A.werbeteam_cd,
    B.werbeteam_bez,
    B.werbebereich_cd
FROM dbp_data.wg_per AS A
INNER JOIN dbp_data.l_werbeteam AS B
    ON
        A.mandant_id = B.mandant_id AND A.werbeteam_cd = B.werbeteam_cd
        AND A.arthiertyp_id = 2 AND A.dat_bis = DATE '9999-12-31'
WHERE A.mandant_id = 1;


UPDATE `_murks` SET
    konkat_werbeteam_cd = b.werbeteam_cd,
    konkat_werbeteam_bez = b.werbeteam_bez
FROM `_wgs` AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.kind_wg_id = b.wg_id;


UPDATE `_murks` SET
    werbebereich_cd = b.werbebereich_cd
FROM `_wgs` AS b
WHERE `_murks`.mandant_id = b.mandant_id AND `_murks`.mutter_wg_id = b.wg_id;


CREATE OR REPLACE TEMPORARY TABLE _upd1 AS
SELECT
    mandant_id,
    kjwo_ww,
    kjwo,
    mutter_wb_id,
    gp_id,
    konkat_aktion_thema_gruppe_id,
    werbebereich_cd,
    RTRIM(
        STRING_AGG(DISTINCT konkat_werbeteam_cd, ','), ',') AS
    konkat_werbeteam_cd_,
    RTRIM(STRING_AGG(DISTINCT konkat_werbeteam_bez, ','), ',')
        AS konkat_werbeteam_bez_
FROM `_murks`
GROUP BY
    mandant_id,
    kjwo_ww,
    kjwo,
    mutter_wb_id,
    gp_id,
    konkat_aktion_thema_gruppe_id,
    werbebereich_cd;


UPDATE dbp_data.aktionsmanagement SET
    konkat_werbeteam_cd = b.konkat_werbeteam_cd_,
    konkat_werbeteam_bez = b.konkat_werbeteam_bez_,
    werbebereich_cd = b.werbebereich_cd
FROM `_upd1` AS b
WHERE
    aktionsmanagement.mandant_id = b.mandant_id AND aktionsmanagement.kjwo_ww = b.kjwo_ww AND aktionsmanagement.kjwo =
    b.kjwo AND aktionsmanagement.mutter_wb_id = b.mutter_wb_id AND aktionsmanagement.gp_id = b.gp_id AND COALESCE(
        aktionsmanagement.konkat_aktion_thema_gruppe_id, '-1000'
    ) = b.konkat_aktion_thema_gruppe_id;
