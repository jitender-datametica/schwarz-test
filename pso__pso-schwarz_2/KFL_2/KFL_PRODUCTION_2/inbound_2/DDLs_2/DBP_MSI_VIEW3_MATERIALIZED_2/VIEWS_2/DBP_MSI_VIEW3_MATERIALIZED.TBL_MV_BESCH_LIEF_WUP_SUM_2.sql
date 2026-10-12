create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_BESCH_LIEF_WUP_SUM_2(
	DAT_LIEF_SOLL,
	KUNDE_ID,
	LAGERORT_ID,
	LIEF_PAL_TYP_ID,
	LIEF_TYP_ID,
	MANDANT_ID,
	NB_ID,
	VERTR_BELEG_TYP_ID,
	WUP_ID,
	WG_VERKETT_LIEF,
	MENGE_LIEF_IST_KOLLI,
	ANZAHL_PACKSTUECK,
	ANZAHL_POSITION,
	MENGE_LIEF_IST_BME,
	BETRAG_LIEF_IST,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_SOLL_KOLLI,
	WERBEWARE_ID,
	BETRAG_LIEF_SOLL,
	WRG_ID,
	MANDANT_ID_KUNDE,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	BRTVOL_LADUNG_LITER,
	BESTELLART_ID,
	HU_STATUS_ID,
	BRTVOL_LADUNG_LITER_GEDECKELT,
	MENGE_LIEF_FEHL_BME,
	MENGE_LIEF_FEHL_KOLLI,
	BETRAG_LIEF_FEHL,
	VK_NETTO_LIEF_FEHL,
	DAT_BIS,
	WRG_TYP_ID,
	KURSTYP_ID
) as
SELECT
    v01.dat_lief_soll,
    CASE
        WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL
        ELSE TRY_CAST(kunde_id AS INTEGER)
    END kunde_id,
    v01.lagerort_id,
    v01.lief_pal_typ_id,
    v01.lief_typ_id,
    v01.mandant_id,
    v01.nb_id,
    v01.vertr_beleg_typ_id,
    v01.wup_id,
    v01.wg_verkett_lief,
    v01.menge_lief_ist_kolli,
    v01.anzahl_packstueck,
    v01.anzahl_position,
    v01.menge_lief_ist_bme,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN v01.betrag_lief_ist * v02.umrechnungskurs
        ELSE v01.betrag_lief_ist
    END AS betrag_lief_ist,
    CASE
        WHEN v01.dat_lief_soll < '2005-04-12' THEN 0
        ELSE v01.menge_lief_soll_bme
    END AS menge_lief_soll_bme,
    CASE
        WHEN v01.dat_lief_soll < '2005-04-12' THEN 0
        ELSE v01.menge_lief_soll_kolli
    END AS menge_lief_soll_kolli,
    v01.werbeware_id,
    CASE
        WHEN v01.dat_lief_soll < '2005-04-12' THEN 0
        ELSE v01.betrag_lief_soll
    END AS betrag_lief_soll,
    v01.wrg_id,
    CASE
        WHEN v01.mandant_id_kunde IS NULL
        OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
        ELSE v01.mandant_id_kunde
    END AS mandant_id_kunde,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN v01.vk_netto_lief_soll * v02.umrechnungskurs
        ELSE v01.vk_netto_lief_soll
    END AS vk_netto_lief_soll,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN v01.vk_netto_lief_ist * v02.umrechnungskurs
        ELSE v01.vk_netto_lief_ist
    END AS vk_netto_lief_ist,
    v01.brtvol_ladung_liter,
    v01.bestellart_id,
    v01.hu_status_id,
    v01.brtvol_ladung_liter_gedeckelt -- die dazugehörige netvol_ladung_liter wird mit FrontEnd Metriken gedeckelt
,
    CASE
        WHEN dat_lief_soll < '2005-04-12' THEN 0
        ELSE (v01.menge_lief_soll_bme - v01.menge_lief_ist_bme)
    END AS menge_lief_fehl_bme,
    CASE
        WHEN dat_lief_soll < '2005-04-12' THEN 0
        ELSE (
            v01.menge_lief_soll_kolli - v01.menge_lief_ist_kolli
        )
    END AS menge_lief_fehl_kolli,
    CASE
        WHEN v01.dat_lief_soll < '2005-04-12' THEN 0
        ELSE CASE
            WHEN v03.wrg_typ_id = 0 THEN (
                (v01.betrag_lief_soll - v01.betrag_lief_ist) * v02.umrechnungskurs
            )
        END
    END AS betrag_lief_fehl,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN (
            (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist) * v02.umrechnungskurs
        )
        ELSE (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist)
    END AS vk_netto_lief_fehl,
    v02.dat_bis,
    v03.wrg_typ_id,
    v02.kurstyp_id
    --,v01.menge_lief_ist_kolli_gp
    --,v01.anzahl_position_gp
    --,v01.anzahl_palette_gp
    --,v01.anzahl_palette_mp
FROM
    dbp_view.v_besch_lief_wup_sum_2 v01
    INNER JOIN dbp_view.v_kurs_2 v02 ON v01.wrg_id = v02.von_wrg_id
    INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 v03 ON v01.mandant_id = v03.mandant_id --    INNER JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04
    --    ON v03.wrg_typ_id = v04.wrg_typ_id
WHERE v02.dat_bis = '9999-12-31'
    AND v02.kurstyp_id = 3
    AND extract(year from v01.dat_lief_soll) >= year(current_timestamp) - 2;