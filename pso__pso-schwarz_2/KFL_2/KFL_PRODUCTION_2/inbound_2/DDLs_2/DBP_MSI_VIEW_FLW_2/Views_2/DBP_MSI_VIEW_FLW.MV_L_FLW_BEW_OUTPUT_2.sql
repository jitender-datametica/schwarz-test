CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_BEW_OUTPUT_2 -- 26.10.2011 system_id entfernt
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
    status_mb
) AS
SELECT
    mandant_id --, system_id
,
    bde_vorgang_id,
    werk_id,
    beleg_gruppe_id,
    in_art_id,
    in_art_nr,
    art_bez,
    flw_beleg_typ_id,
    status_mb
FROM
    DBP_MSI_VIEW_FLW.TBL_MV_L_FLW_BEW_OUTPUT_2 v01
    JOIN dbp_msi.akt_msi_user_spr_zu_2 v04 ON v01.spr_id = v04.spr_id
;