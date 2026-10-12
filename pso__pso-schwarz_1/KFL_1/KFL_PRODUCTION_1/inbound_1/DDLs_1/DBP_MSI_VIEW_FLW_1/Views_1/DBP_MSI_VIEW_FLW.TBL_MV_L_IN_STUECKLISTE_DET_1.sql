CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_IN_STUECKLISTE_DET_1 -- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
    mandant_id --, system_id
,
    stueckliste_id,
    stueckliste_pos_id,
    stueckliste_typ_id,
    in_art_id,
    in_art_nr,
    art_bez,
    spr_id
) AS
SELECT
    v01.mandant_id,
    v01.stueckliste_id,
    v01.stueckliste_pos_id,
    v01.stueckliste_typ_id,
    v01.flw_art_id AS in_art_id,
    v02.flw_art_nr AS in_art_nr,
    v03.art_bez,
    v03.spr_id
FROM
    dbp_view.v_flw_stueckliste_det_1 v01
    JOIN dbp_view.v_flw_art_1 v02 ON v01.mandant_id = v02.mandant_id
    AND v01.flw_art_id = v02.flw_art_id
    LEFT JOIN dbp_view.v_flw_art_spr_zu_1 v03 ON v02.mandant_id = v03.mandant_id
    AND v02.flw_art_id = v03.flw_art_id
WHERE
    stueckliste_pos_typ_id IN ('G', 'X')
    AND komponentenmenge > 0.001
    AND v01.mandant_id IN (1, 2);