create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_LAGERBEW_DET(
	LAGERBEW_BELEG_ID,
	LAGERBEW_BELEG_POS_ID,
	MANDANT_ID,
	KJ,
	WUP_ID,
	NB_ID,
	IN_KUNDE_ID,
	DAT_BUCH,
	ART_ID,
	IN_ART_ID,
	LAGER_BEWART_ID,
	BETRAG_VK_NETTO,
	BETRAG_VK_BRUTTO,
	MENGE_LAGERBEW_BME,
	MENGE_LAGERBEW_KG,
	WRG_ID
) as
SELECT
    v01.lagerbew_beleg_id,
    v01.lagerbew_beleg_pos_id,
    v01.mandant_id,
    v01.kj,
    v01.wup_id,
    v01.nb_id,
    v01.in_kunde_id,
    v01.dat_buch,
    v01.art_id,
    v01.in_art_id,
    v01.lager_bewart_id,
    CASE
        -- Landesbeleg in Euro wird in Euro angezeigt
        WHEN v01.wrg_id <> v01.default_wrg
        AND v200.wrg_typ_id = 0 -- 0 = Euro
        THEN betrag_vk_netto -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
        WHEN v01.wrg_id <> v01.default_wrg
        AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
        THEN (betrag_vk_netto / v500.umrechnungskurs) --Landesbeleg in Landeswaehrung wird in Euro angezeigt
        WHEN v01.wrg_id = v01.default_wrg
        AND v200.wrg_typ_id = 0 -- 0 = Euro
        THEN betrag_vk_netto * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
        WHEN v01.wrg_id = v01.default_wrg
        AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
        THEN betrag_vk_netto
    END AS betrag_vk_netto,
    betrag_vk_netto * ((v01.mwst / 100) + 1) AS betrag_vk_brutto -- zu loeschen nach P3/2014, inkl. v06
,
    menge_lagerbew_bme,
    menge_lagerbew_kg,
    v400.wrg_id
FROM
    DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_LAGERBEW_DET v01
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300 -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
    JOIN dbp_view.v_mandant_wrg_typ_zu v400 ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs
    JOIN dbp_view.v_kurs v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.dat_buch BETWEEN v500.dat_von
    AND v500.dat_bis;