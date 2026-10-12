CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_KALK_MATERIAL_DET 
-- 26.10.2011 system_id entfernt
-- 25.09.2012 twie: weitere 8 Kostenstellen hinzugefuegt
--15.10.2012 twie: Filter auf vorstufe_fg = 0
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2016 twie SPEC0005119: KST023 gefiltert auf DE und CZ
-- 26.08.2019 twie: SPEC0049505 kalk_variante_id hinzugefuegt, damit nicht aus der mv_f_in_kalk_denorm ermittelt werden muss
AS
SELECT
    v01.mandant_id,
    v01.kalk_id,
    v01.kalkulationsart_id,
    v01.dat_kalk,
    v01.kalk_version_id,
    v01.bewertung_variante_id,
    v01.vorstufe_fg,
    CAST(
        CASE
            WHEN v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN 1 -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (1 / v500.umrechnungskurs) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN 1 * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN 1
        END AS DECIMAL(18, 6)
    ) AS waehrungzahl,
    CAST(
        COALESCE(v01.KST001, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST001,
    CAST(
        COALESCE(v01.KST002, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST002,
    CAST(
        COALESCE(v01.KST003, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST003,
    CAST(
        COALESCE(v01.KST004, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST004,
    CAST(
        COALESCE(v01.KST005, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST005,
    CAST(
        COALESCE(v01.KST006, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST006,
    CAST(
        COALESCE(v01.KST007, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST007,
    CAST(
        COALESCE(v01.KST008, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST008,
    CAST(
        COALESCE(v01.KST010, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST010,
    CAST(
        COALESCE(v01.KST012, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST012,
    CAST(
        COALESCE(v01.KST014, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST014,
    CAST(
        COALESCE(v01.KST017, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST017,
    CAST(
        COALESCE(v01.KST019, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST019,
    CAST(
        COALESCE(v01.KST021, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST021,
    CAST(
        COALESCE(v01.KST023, 0) * waehrungzahl AS DECIMAL(18, 6)
    ) AS KST023,
    CASE
        WHEN v01.mandant_id = 1 THEN CAST(
            COALESCE(v01.KST023, 0) * waehrungzahl AS DECIMAL(18, 6)
        )
        ELSE 0
    END AS KST023_DE,
    CASE
        WHEN v01.mandant_id = 2 THEN CAST(
            COALESCE(v01.KST023, 0) * waehrungzahl AS DECIMAL(18, 6)
        )
        ELSE 0
    END AS KST023_CZ,
    v400.wrg_id,
    dat_kalk_ab,
    dat_kalk_bis,
    dat,
    werk_id,
    in_art_id,
    kalk_variante_id
FROM DBP_MSI_VIEW_FLW.TBL_MV_F_IN_KALK_MATERIAL_DET v01
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
    JOIN dbp_view.v_mandant_wrg_typ_zu v400 ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id
    LEFT OUTER JOIN dbp_view.v_kurs v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.dat_kalk_ab BETWEEN v500.dat_von
    AND v500.dat_bis
where
    v01.vorstufe_fg = 0;