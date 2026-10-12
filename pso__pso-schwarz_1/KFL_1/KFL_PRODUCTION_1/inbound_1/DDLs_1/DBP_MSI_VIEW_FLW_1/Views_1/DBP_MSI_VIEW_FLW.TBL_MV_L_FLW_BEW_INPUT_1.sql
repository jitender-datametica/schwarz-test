CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_FLW_BEW_INPUT_1 -- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
    mandant_id --, system_id
,
    bde_vorgang_id,
    werk_id,
    beleg_gruppe_id,
    in_art_id,
    in_art_nr,
    art_bez,
    flw_beleg_typ_id,
    status_mb,
    spr_id
) AS
SELECT
    v01.mandant_id,
    v01.bde_vorgang_id,
    v01.werk_id,
    v01.beleg_gruppe_id,
    v01.flw_art_id AS in_art_id,
    v02.flw_art_nr AS in_art_nr,
    v03.art_bez,
    v01.flw_beleg_typ_id,
    v01.status_mb,
    v03.spr_id
FROM
    dbp_view.v_flw_bew_1 v01
    JOIN dbp_view.v_flw_art_1 v02 ON v01.mandant_id = v02.mandant_id
    AND v01.flw_art_id = v02.flw_art_id
    LEFT OUTER JOIN dbp_view.v_flw_art_spr_zu_1 v03 ON v02.mandant_id = v03.mandant_id
    AND v02.flw_art_id = v03.flw_art_id
WHERE
    flw_beleg_typ_id = 'WA'
    AND beleg_gruppe_id IN ('C', 'D')
    AND status_mb <> ''
    AND v01.mandant_id IN (1, 2);