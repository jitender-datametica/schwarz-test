CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_KOSTENRECHNUNG_1 
-- 26.10.2011 system_id entfernt
(
    buchungskreis_id_ker,
    buchungsperiode_id,
    gj,
    kjmo,
    kostenart_id,
    krk_id,
    mandant_id,
    pc_id,
    plan_fg,
    planvariante_id --, system_id
,
    kostenrechnung_betrag_org,
    wrg_id_orig,
    max_dat,
    default_wrg
) AS
SELECT
    buchungskreis_id_ker,
    v01.buchungsperiode_id,
    v01.gj,
    v01.kj_ker_mo_id,
    v01.kostenart_id,
    v01.krk_id,
    v01.mandant_id,
    v01.pc_id,
    v01.plan_fg,
    v01.planvariante_id,
    v01.kostenrechnung_betrag AS kostenrechnung_betrag_org -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
,
    v01.wrg_id AS wrg_id_orig -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
    ,v450.max_dat
    ,v100.default_wrg
FROM
    dbp_view.v_kostenrechnung_1 v01
    JOIN dbp_view.v_mandant_1 v100 ON v01.mandant_id = v100.mandant_id
    JOIN (
        SELECT
            MAX(dat) AS max_dat,
            MAX(kjmo) AS kjmo,
            gjmo AS gjmo
        FROM
            dbp_view.v_tag_1
        GROUP BY
            gjmo
    ) v450 ON v450.gjmo = CASE
        WHEN buchungsperiode_id > 12 THEN gj * 100 + 12
        ELSE gj * 100 + buchungsperiode_id
    END
    ;