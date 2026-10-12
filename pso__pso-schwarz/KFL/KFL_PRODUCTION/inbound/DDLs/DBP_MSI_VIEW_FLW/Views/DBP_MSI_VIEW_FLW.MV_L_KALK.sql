CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_KALK -- 11.10.2011 AL neue Spalte plan_soll_kz aufgenommen
-- 13.10.2011 AL Left  Outer Join auf INNER Join bei spr Tabellen angepast
-- 26.10.2011 system_id entfernt
(
    mandant_id --, system_id
,
    schnittliste_id,
    werk_id,
    dat_kalk_ab,
    dat_kalk_bis,
    fortgesch_kalk_fg,
    kalk_nr,
    kalk_bez,
    kalk_kennz,
    kalk_variante_id,
    plan_soll_kz
) AS
SELECT
    mandant_id --, system_id
,
    schnittliste_id,
    werk_id,
    dat_kalk_ab,
    dat_kalk_bis,
    fortgesch_kalk_fg,
    kalk_nr,
    kalk_bez,
    kalk_kennz,
    kalk_variante_id,
    plan_soll_kz
FROM
    DBP_MSI_VIEW_FLW.TBL_MV_L_KALK v01
    JOIN dbp_msi.akt_msi_user_spr_zu v06 ON v01.spr_id = v06.spr_id;