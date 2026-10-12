CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_ARTBEW_WG_TAG_SUM_1 -- 26.10.2011 system_id entfernt
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 22.10.2013 twie: Join zu in_kunde_1 vereinfacht ueber wup_id
-- 29.01.2014 twie: Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.
-- 13.02.2014 twie: ek_mep ausgeben, diff_umsatz_netto_konz entfernen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--18.09.2018 naku:  WG Umstellung und Anpassungen
(
    dat,
    mandant_id,
    wg_id,
    arthiertyp_id,
    in_kunde_id,
    ek_mep_umsatz_temp,
    bewart_id,
    default_wrg,
    umsatz_netto
) AS
SELECT
    v01.dat,
    v01.mandant_id,
    v01.wg_id,
    v01.arthiertyp_id,
    v02.flw_kunde_id AS in_kunde_id,
    CASE
        WHEN v01.wg_id IN (122, 128, 146, 147, 184, 186) THEN v01.ek_mep
        ELSE NULL
    END AS ek_mep_umsatz_temp,
    v01.bewart_id,
    v100.default_wrg,
    v01.umsatz_netto
FROM
    dbp_view.v_artbew_wg_tp2_sum_1 v01
    INNER JOIN dbp_view.v_flw_kunde_1 v02 ON v02.wup_id = v01.wup_id
    AND v02.mandant_id = v01.mandant_id
    JOIN dbp_view.v_mandant_1 v100 ON v01.mandant_id = v100.mandant_id 
WHERE
    v01.mandant_id IN (1, 2)
    AND v01.arthiertyp_id = 2;

