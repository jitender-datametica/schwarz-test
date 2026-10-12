create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_IN_LAGERBEW_DET_ROH_2(
	MANDANT_ID,
	WERK_ID,
	DAT_BUCH,
	WRG_ID_ORG,
	WRG_ID,
	BEST_BELEG_ID,
	IN_ART_ID,
	WA_INTERN
) as
SELECT
    v01.mandant_id,
    werk_id,
    dat_buch,
    wrg_id_org,
    v01.wrg_id,
    best_beleg_id,
    in_art_id,
    CAST(
        CASE
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.betrag_lagerbew), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.betrag_lagerbew), 0) -- Standardpreis
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew_altnv), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.betrag_lagerbew_altnv), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew_altnv), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.betrag_lagerbew_altnv), 0)
        END AS DECIMAL(18, 6)
    ) AS wa_intern
FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_IN_LAGERBEW_DET_ROH_2 v01
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300 -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
    JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400 ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs
    JOIN dbp_view.v_kurs_2 v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.dat_buch BETWEEN v500.dat_von
    AND v500.dat_bis -- Einschraenkgung auf bestimmte Materialarten ueber artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZFLV');