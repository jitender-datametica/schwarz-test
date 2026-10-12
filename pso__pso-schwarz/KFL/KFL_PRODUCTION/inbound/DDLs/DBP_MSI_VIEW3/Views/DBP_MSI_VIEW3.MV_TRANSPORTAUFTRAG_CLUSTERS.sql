CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG_CLUSTERS(
	DAT_ERSTELLUNG,
	ZEIT_ERSTELLUNG,
	ERSTELLUNG_DT,
	DAT_QUITTIERUNG,
	DAT_LIEF_SOLL,
	DAT_BEREITSTELLUNG,
	DATZEIT_BEREITSTELLUNG,
	DATZEIT_START_TA,
	DATZEIT_END_TA,
	LAGERNUMMER_ID,
	MANDANT_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORTART_ID,
	LVS_BEWART_ID,
	LIEF_BELEG_ID,
	TA_PRIO,
	DAT_PRIO_UPD,
	ZEIT_PRIO_UPD,
	NB_ID,
	WUP_ID,
	KJ_LIEF_BELEG,
	WERBEWARE_ID,
	LIEF_PAL_TYP_ID,
	REFERENZNUMMER,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ID
) AS
--2023-01-05, AP0150311, SPEC0174516, dknop, initial, copy of MV_TRANSPORTAUFTRAG but with clusters
--
SELECT
    dat_erstellung,
    zeit_erstellung,
    timestamp_from_parts(dat_erstellung,COALESCE(zeit_erstellung,'00:00:00')) AS erstellung_dt,
    dat_quittierung,
    dat_lief_soll,
    dat_bereitstellung,
    datzeit_bereitstellung,
    datzeit_start_ta,
    datzeit_end_ta,
    lagernummer_id,
    mandant_id,
    transport_beleg_id,
    transportart_id,
    lvs_bewart_id,
    lief_beleg_id,
    ta_prio,
    dat_prio_upd,
    zeit_prio_upd,
    nb_id,
    wup_id,
    kj_lief_beleg,
    werbeware_id,
    lief_pal_typ_id,
    referenznummer,
	CASE WHEN clusters.cluster_element_id=4 AND clusters.cluster_id=4 THEN 3 ELSE clusters.cluster_element_id END AS cluster_element_id,
    clusters.cluster_id
FROM
    dbp_view.v_transportauftrag
LEFT JOIN dbp_msi_data.ts_scm_cluster clusters
   ON zeit_erstellung BETWEEN clusters.zeit_von AND clusters.zeit_bis 
   AND clusters.cluster_typ_bez='Uhrzeit'	
       WHERE EXTRACT(YEAR FROM dat_erstellung) >= YEAR(CURRENT_TIMESTAMP) - 2 
    --and (zeit_erstellung between '00:00:00' and '05:59:59')
    --and transport_beleg_id=64053630 and cluster_id=4
    ;