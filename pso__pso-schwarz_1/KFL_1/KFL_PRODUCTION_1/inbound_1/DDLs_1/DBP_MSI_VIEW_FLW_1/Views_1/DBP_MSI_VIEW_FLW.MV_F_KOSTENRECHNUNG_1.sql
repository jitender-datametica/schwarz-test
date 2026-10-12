CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_KOSTENRECHNUNG_1 
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
    kostenrechnung_betrag,
    wrg_id_orig,
    wrg_id
) AS
SELECT
    buchungskreis_id_ker,
    v01.buchungsperiode_id,
    v01.gj,
    v01.kjmo,
    v01.kostenart_id,
    v01.krk_id,
    v01.mandant_id,
    v01.pc_id,
    v01.plan_fg,
    v01.planvariante_id,
    kostenrechnung_betrag_org -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
,
    CAST(
        CASE
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.wrg_id_orig <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE(kostenrechnung_betrag_org, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.wrg_id_orig <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE(kostenrechnung_betrag_org, 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.wrg_id_orig = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE(kostenrechnung_betrag_org, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.wrg_id_orig = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE(kostenrechnung_betrag_org, 0)
        END AS DECIMAL(18, 6)
    ) kostenrechnung_betrag,
    wrg_id_orig -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
,
    v400.wrg_id AS wrg_id
FROM
    DBP_MSI_VIEW_FLW.TBL_MV_F_KOSTENRECHNUNG_1 v01
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300 --AND v300.kurstyp_id = 3
    JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400 ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id
        LEFT OUTER JOIN dbp_view.v_kurs_1 v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id_orig = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.max_dat BETWEEN v500.dat_von
    AND v500.dat_bis
    ;