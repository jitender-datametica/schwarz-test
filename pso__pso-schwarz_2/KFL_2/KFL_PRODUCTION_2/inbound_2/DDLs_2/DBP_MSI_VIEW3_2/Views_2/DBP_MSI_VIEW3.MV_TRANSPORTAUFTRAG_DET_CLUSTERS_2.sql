CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG_DET_CLUSTERS_2(
	ART_ID,
	LAGERNUMMER_ID,
	LAGERORT_ID,
	MANDANT_ID,
	NACH_LAGERTYP_ID,
	NACH_LAGERPLATZ_ID,
	NB_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORT_BELEG_POS_ID,
	GLOBAL_VON_LAGERTYP_ID,
	VON_LAGERTYP_ID,
	VON_LAGERPLATZ_ID,
	WUP_ID,
	DAT_ERSTELLUNG,
	DAT_QUITTIERUNG,
	ZEIT_QUITTIERUNG,
	QUITTIERUNG_DT,
	MENGE_TRANSPORTAUFTRAG_KOLLI,
	DAT_ENTNAHME_QUITTIERUNG,
	ZEIT_ENTNAHME_QUITTIERUNG,
	ENTNAHME_QUITTIERUNG_DT,
	LAGER_EINHEIT_ID_VON,
	LAGER_EINHEIT_ID_NACH,
	MENGE_IST_NACH,
	MENGE_SOLL_VON,
	STATUS_QUITTIERUNG,
	LAGER_EINHEITEN_TYP,
	TRANSPORT_VORGANG_ID,
	DAT_VERFALL,
	BRUTTOGEW_KG,
	NACHSCHUBZEIT_SEKUNDEN,
	PLATZ_LEER_FG,
	MENGE_SOLL_NACH_ALTNV,
	MIN_NACHSCHUB_KDR,
	DISTANZ,
	MENGE_IST,
	EINL_EBENE,
	SAP_USER,
	USER_FLAG,
	HANDLING_UNIT_ID_EXT,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ID
) AS
--2022-12-15, AP0150311, SPEC0174516, dknop, initial, copy of MV_TRANSPORTAUFTRAG_DET_2 but with clusters
SELECT

    ltap.art_id,
    ltap.lagernummer_id,
    ltap.lagerort_id,
    ltap.mandant_id,
    ltap.nach_lagertyp_id,
    ltap.nach_lagerplatz_id,
    ltap.nb_id,
    ltap.transport_beleg_id,
    ltap.transport_beleg_pos_id,
    CASE
        WHEN SUBSTR(ltap.von_lagertyp_id, 1, 2) = 'R0' THEN 'Regal Erdgeschoss'
        WHEN SUBSTR(ltap.von_lagertyp_id, 1, 2) = 'R1' THEN 'Regal Obergeschoss'
        WHEN ltap.von_lagertyp_id = 'H01' THEN 'Hochregal'
        WHEN ltap.von_lagertyp_id IN ('RH1', 'RT1') THEN 'AKL-Hochregal'
        ELSE 'Sonstige'
    END global_von_lagertyp_id,
    ltap.von_lagertyp_id,
    ltap.von_lagerplatz_id,
    ltap.wup_id,
    ltap.dat_erstellung,
    ltap.dat_quittierung,
    ltap.zeit_quittierung,
    TIMESTAMP_FROM_PARTS(ltap.dat_quittierung, COALESCE(ltap.zeit_quittierung,'00:00:00')) AS quittierung_dt,
    ltap.menge_transportauftrag_kolli,
    ltap.dat_entnahme_quittierung,
    ltap.zeit_entnahme_quittierung,
    TIMESTAMP_FROM_PARTS(ltap.dat_entnahme_quittierung, COALESCE(ltap.zeit_entnahme_quittierung,'00:00:00')) AS entnahme_quittierung_dt,
    ltap.lager_einheit_id_von,
    ltap.lager_einheit_id_nach,
    ltap.menge_ist_nach,
    ltap.menge_soll_von,
 
    CASE
        WHEN ltap.quittierung_fg = 1
        AND (
            ltap.menge_soll_von = ltap.menge_ist_nach
            OR (
                ltap.menge_soll_von = 0
                AND ltap.menge_ist_nach > 0
            )
        )
        AND COALESCE(ltap.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'voll quittiert'
        WHEN ltap.quittierung_fg = 1
        AND ltap.menge_soll_von > ltap.menge_ist_nach
        AND COALESCE(ltap.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'teil quittiert'
        WHEN ltap.quittierung_fg = 1
        AND ltap.transport_vorgang_id IN ('st', 'sl') THEN 'storniert'
        WHEN ltap.quittierung_fg = 0 THEN 'offen'
        ELSE 'sonstiges'
    END :: VARCHAR(14) AS status_quittierung,
    --Anf 584954
    ltap.lager_einheiten_typ,
    ltap.transport_vorgang_id,
    ltap.dat_verfall,
    ltap.bruttogew_kg,
    ltap.nachschubzeit_sekunden,
    ltap.platz_leer_fg,
    ltap.menge_soll_nach_altnv,
    ltap.min_nachschub_kdr,
    ltap.distanz,
    CASE
        WHEN ltap.menge_soll_von <> 0 THEN menge_soll_von
        ELSE ltap.menge_ist_nach
    END AS menge_ist,
    ltap.einl_ebene,
    ltap.sap_user,
    CASE
        WHEN ltap.sap_user = 'ZBATCHANBRNS' THEN 1
        ELSE 0
    END AS user_flag,
    ltap.handling_unit_id_ext,
    clusters.cluster_element_id,
    clusters.cluster_id
FROM dbp_view.v_transportauftrag_det_2 ltap


   LEFT JOIN dbp_msi_data.ts_scm_cluster_2 AS clusters
   ON ltap.nachschubzeit_sekunden BETWEEN clusters.wert_von AND clusters.wert_bis
   AND clusters.cluster_typ_bez='Dauer'
   
 
 
WHERE EXTRACT(YEAR FROM dat_erstellung) >= YEAR(CURRENT_TIMESTAMP) - 2 --and ltap.transport_beleg_id=137189988  and ltap.art_id=94372200
;