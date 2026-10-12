CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_KALK -- 11.10.2011 AL neue Spalte plan_soll_kz aufgenommen
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
    plan_soll_kz, 
    spr_id
) AS
SELECT
    v01.mandant_id,
    v01.schnittliste_id,
    v01.werk_id,
    v01.dat_kalk_ab,
    v01.dat_kalk_bis,
    v01.fortgesch_kalk_fg,
    v01.plan_kalk_id AS kalk_nr,
    v02.plan_kalk_bez AS kalk_bez,
    CAST('PK' AS CHAR(3)) AS kalk_kennz,
    v01.kalk_variante_id,
    v01.plan_soll_kz -- spmeatclpk
    , v02.spr_id
FROM
    dbp_view.v_flw_kalk_plan v01 -- spmeatclpkt
    JOIN dbp_view.v_flw_kalk_plan_spr_zu v02 ON v01.mandant_id = v02.mandant_id
    AND v01.plan_kalk_id = v02.plan_kalk_id
UNION
ALL
SELECT
    v04.mandant_id,
    v04.schnittliste_id,
    v04.werk_id,
    v04.dat_kalk_ab,
    v04.dat_kalk_bis,
    v04.fortgesch_kalk_fg,
    v04.materialwert_kalk_id AS kalk_nr,
    v05.material_kalk_bez AS kalk_bez,
    'MWK' AS kalk_kennz,
    v04.kalk_variante_id,
    v04.plan_soll_kz -- spmeatclck
    , v05.spr_id
FROM
    dbp_view.v_flw_kalk_material v04 -- spmeatclckt
    JOIN dbp_view.v_flw_kalk_material_spr_zu v05 ON v04.mandant_id = v05.mandant_id
    AND v04.materialwert_kalk_id = v05.materialwert_kalk_id
    ;