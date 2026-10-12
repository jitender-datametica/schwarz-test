create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_SOLL_IST_HALB_1(
	WERK_NR,
	WERK_NAME,
	MANDANT_ID,
	AUFTRAG_ID,
	HALB_IN_ART_ID,
	HALB_IN_ART_NR,
	IN_ART_ID,
	TYP,
	BASISMENGE_EINH_ID,
	IN_ART_NR,
	ARTIKELART_ID,
	WERK_ID,
	DAT_START,
	MENGE_LAGERBEW_BME,
	BEWERTUNGSPREIS_ME,
	INPUT_MENGE_IST,
	INPUT_MENGE_SOLL,
	BEWERTUNGSPREIS_KG,
	MENGE_KG
) as
SELECT
    v01.werk_nr,
    v01.werk_name,
    v01.mandant_id,
    v01.auftrag_id,
    v01.halb_in_art_id,
    v01.halb_in_art_nr,
    v01.in_art_id,
    v01.typ,
    v01.basismenge_einh_id,
    v01.in_art_nr,
    v01.artikelart_id,
    v01.werk_id,
    v01.dat_start,
    v01.menge_lagerbew_bme,
    CAST(
        CASE
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.gld / v01.preis_faktor), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.gld / v01.preis_faktor), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.gld / v01.preis_faktor), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.gld / v01.preis_faktor), 0) -- Standardpreis
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.standard_preis / v01.preis_faktor), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.standard_preis / v01.preis_faktor), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.standard_preis / v01.preis_faktor), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.standard_preis / v01.preis_faktor), 0)
        END AS DECIMAL(18, 6)
    ) AS bewertungspreis_me,
    v01.input_menge_ist,
    v01.input_menge_soll,
    CASE
        WHEN v01.basismenge_einh_id = 'ST' THEN CAST(
            (bewertungspreis_me / v01.umrech_faktor) AS DECIMAL(18, 6)
        )
        ELSE bewertungspreis_me
    END AS bewertungspreis_kg,
    CASE
        WHEN v01.basismenge_einh_id = 'ST' THEN CAST(
            v01.menge_lagerbew_bme * v01.umrech_faktor AS DECIMAL(18, 6)
        )
    END AS menge_kg
FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_SOLL_IST_HALB_1 v01
 
       CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
       CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300
    -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
       JOIN
       dbp_view.v_mandant_wrg_typ_zu_1 v400
       ON v01.mandant_id = v400.mandant_id
       AND v200.wrg_typ_id = v400.wrg_typ_id
   -- Umrechnung Standardkurs, Tageskurs
    JOIN dbp_view.v_kurs_1 v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.dat_start BETWEEN v500.dat_von
    AND v500.dat_bis;