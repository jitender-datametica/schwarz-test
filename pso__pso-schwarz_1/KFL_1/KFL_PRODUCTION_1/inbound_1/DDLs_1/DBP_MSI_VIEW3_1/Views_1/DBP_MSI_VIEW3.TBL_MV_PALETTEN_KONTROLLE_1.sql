create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.TBL_MV_PALETTEN_KONTROLLE_1(
	MANDANT_ID,
	SYSTEM_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	HANDLING_UNIT_ID,
	FEHLER_LFD_NR,
	WAQFK_FEHLER_ID,
	WAQFK_KENNZIFFER_ID,
	ZLV_MERKMAL,
	LAGERNUMMER_ID,
	MENGE_WAQFK_KOLLI_SOLL_,
	MENGE_WAQFK_KOLLI_IST_,
	ANZAHL_FEHLER_KOLLI,
	DAT_QUITTIERUNG,
	DAT_KONTROLLE,
	SAP_USER_BENUTZER,
	KUNDE_ID_NEU,
	SAP_USER_KONTROLLE,
	MANDANT_ID_KUNDE,
	DAT_LIEF_SOLL,
	ANZAHL_GEPRUEFTE_PALETTEN,
	ANZAHL_WAQFK_KUNDEN,
	ANZAHL_WAQFK_KOMMISIONIERER,
	ANZAHL_WAQFK_FEHLER,
	ANZAHL_WAQFK_FEHLER1,
	ANZAHL_WAQFK_FEHLER2,
	ANZAHL_WAQFK_FEHLER3,
	ANZAHL_WAQFK_FEHLER4,
	ANZAHL_WAQFK_FEHLER5,
	ANZAHL_OK_PALETTEN,
	WRG_ID,
	WRG_TYP_ID,
	VK_NETTO_WAQFK_SOLL,
	VK_NETTO_WAQFK_IST,
	VK_NETTO_WAQFK_FEHLER_ABS,
	VK_NETTO_WAQFK_FEHLER_SAL,
	MENGE_WAQFK_KOLLI_SOLL,
	MENGE_WAQFK_KOLLI_IST,
	KUNDE_ID
) as



   SELECT
    v01.mandant_id,
    v01.system_id,
    v01.nb_id,
    v01.wup_id,
    v01.art_id,
    v01.handling_unit_id,
    v01.fehler_lfd_nr,
    v01.waqfk_fehler_id,
    v01.waqfk_kennziffer_id,
    v01.zlv_merkmal,
    MIN(v01.lagernummer_id) AS lagernummer_id,
    CASE
        WHEN v01.zlv_merkmal IN ('A', 'E', 'L') THEN v01.menge_waqfk_kolli_soll
        ELSE 0
    END AS menge_waqfk_kolli_soll_,
    CASE
        WHEN v01.zlv_merkmal IN ('A', 'E', 'L') THEN v01.menge_waqfk_kolli_ist
        ELSE 0
    END AS menge_waqfk_kolli_ist_,
    ABS(
        CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN v01.menge_waqfk_kolli_soll
            ELSE 0
        END - CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN v01.menge_waqfk_kolli_ist
            ELSE 0
        END
    ) AS anzahl_fehler_kolli,
    v01.dat_quittierung,
    v01.dat_kontrolle,
    MIN(v01.sap_user_benutzer) AS sap_user_benutzer,
    
    CASE WHEN TRY_CAST(SUBSTR(MIN(v01.kunde_id), 7, 4) AS INTEGER) IS NULL THEN -3  ELSE MIN(v05.aktuell_wup_id)  END AS kunde_id_neu,




    MIN(v01.sap_user_kontrolle) AS sap_user_kontrolle,
    CASE
        WHEN v01.mandant_id_kunde IS NULL
        OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
        ELSE v01.mandant_id_kunde
    END AS mandant_id_kunde,
    v01.dat_lief_soll,
    CASE
        WHEN (
            (v01.handling_unit_id) - (
                SUM(v01.handling_unit_id) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.handling_unit_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        v01.art_id,
                        v01.waqfk_fehler_id ASC ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            ) <> 0
            OR (
                SUM(v01.handling_unit_id) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.handling_unit_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        v01.art_id,
                        v01.waqfk_fehler_id ASC ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            ) IS NULL
        ) THEN 1
        ELSE 0
    END AS anzahl_gepruefte_paletten,
    CASE
        WHEN (
            (MIN(v01.kunde_id)) - (
                SUM(v01.kunde_id) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.kunde_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        1 ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            ) <> 0
            OR (
                SUM(v01.kunde_id) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.kunde_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        1 ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            ) IS NULL
        ) THEN 1
        ELSE 0
    END AS anzahl_waqfk_kunden,
    CASE
        WHEN (
            MIN(v01.sap_user_benutzer) <> (
                MAX(v01.sap_user_benutzer) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        v01.sap_user_benutzer ASC ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            )
            OR (
                MAX(v01.sap_user_benutzer) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                    ORDER BY
                        v01.sap_user_benutzer ASC ROWS BETWEEN 1 PRECEDING
                        AND 1 PRECEDING
                )
            ) IS NULL
        ) THEN 1
        ELSE 0
    END AS anzahl_waqfk_kommisionierer,
    1 AS anzahl_waqfk_fehler,
    CASE
        WHEN waqfk_fehler_id = 1 THEN 1
        ELSE 0
    END AS anzahl_waqfk_fehler1,
    CASE
        WHEN waqfk_fehler_id = 2 THEN 1
        ELSE 0
    END AS anzahl_waqfk_fehler2,
    CASE
        WHEN waqfk_fehler_id = 3 THEN 1
        ELSE 0
    END AS anzahl_waqfk_fehler3,
    CASE
        WHEN waqfk_fehler_id = 4 THEN 1
        ELSE 0
    END AS anzahl_waqfk_fehler4,
    CASE
        WHEN waqfk_fehler_id = 5 THEN 1
        ELSE 0
    END AS anzahl_waqfk_fehler5,
    CASE
        WHEN (anzahl_gepruefte_paletten = 1) THEN CASE
            WHEN (
                SUM(v01.waqfk_fehler_id) OVER (
                    PARTITION BY v01.mandant_id,
                    v01.lagernummer_id,
                    v01.handling_unit_id,
                    v01.dat_lief_soll,
                    v03.wrg_typ_id
                ) = 0
            ) THEN 1
            ELSE 0
        END
        ELSE 0
    END AS anzahl_ok_paletten,
     MIN(v03.wrg_id) AS wrg_id,
    v03.wrg_typ_id,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN betrag_vk_netto_soll
            ELSE 0
        END * v02.umrechnungskurs
        ELSE CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN betrag_vk_netto_soll
            ELSE 0
        END
    END AS vk_netto_waqfk_soll,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN betrag_vk_netto_ist
            ELSE 0
        END * v02.umrechnungskurs
        ELSE CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN betrag_vk_netto_ist
            ELSE 0
        END
    END AS vk_netto_waqfk_ist,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN ABS(betrag_vk_netto_ist - betrag_vk_netto_soll)
            ELSE 0
        END * v02.umrechnungskurs
        ELSE CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN ABS(betrag_vk_netto_ist - betrag_vk_netto_soll)
            ELSE 0
        END
    END AS vk_netto_waqfk_fehler_abs,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN (betrag_vk_netto_ist - betrag_vk_netto_soll)
            ELSE 0
        END * v02.umrechnungskurs
        ELSE CASE
            WHEN v01.zlv_merkmal IN ('A', 'E') THEN betrag_vk_netto_ist - betrag_vk_netto_soll
            ELSE 0
        END
    END AS vk_netto_waqfk_fehler_sal,
    v01.menge_waqfk_kolli_soll,
    v01.menge_waqfk_kolli_ist,
       MIN(v01.kunde_id) AS kunde_id

   FROM dbp_view.v_paletten_kontrolle_1 v01

   INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END 
   AND v05.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   JOIN dbp_msi_view3.mv_kurs_1 v02
   ON v01.wrg_id = v02.von_wrg_id

   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
   ON v01.mandant_id = v03.mandant_id
   WHERE TRY_TO_NUMBER(v01.kunde_id) IS NOT NULL
    GROUP BY
   v01.mandant_id
   , v01.system_id
   , v01.nb_id
   , v01.wup_id
   , v01.art_id
   , v01.handling_unit_id
   , v01.fehler_lfd_nr
   , v01.waqfk_fehler_id
   , v01.waqfk_kennziffer_id
   , v01.zlv_merkmal
   , v01.lagernummer_id
   , v01.menge_waqfk_kolli_soll
   , v01.menge_waqfk_kolli_ist
   , v01.dat_quittierung
   , v01.dat_kontrolle
   , v01.sap_user_benutzer
   , v01.kunde_id
   , v01.sap_user_kontrolle
   , v01.mandant_id_kunde
   , v01.dat_lief_soll
   , v03.wrg_id
   , v03.wrg_typ_id
   , vk_netto_waqfk_soll
   , vk_netto_waqfk_ist
   , vk_netto_waqfk_fehler_abs
   , vk_netto_waqfk_fehler_sal
;
