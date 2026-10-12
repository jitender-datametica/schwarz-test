CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG
-- 23.03.2015, srom ANF 612515 Erweiterungta_prio, dat_prio_upd, zeit_prio_upd
-- 14.05.2018, mkub1811 AP0028125 - Erweiterung um nb_id, wup_id Spalten
-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
-- 2022-02.24, dknop, adding additional columns dat_lief_soll,dat_bereitstellung,datzeit_bereitstellung, datzeit_start_ta, datzeit_end_ta,werbeware_id,lief_pal_typ_id,referenznummer
    (
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
	REFERENZNUMMER
) AS

SELECT
    dat_erstellung,
    zeit_erstellung,
    TIMESTAMP_FROM_PARTS(dat_erstellung,COALESCE(zeit_erstellung,'00:00:00')) AS erstellung_dt,
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
    referenznummer
	
FROM
    dbp_view.v_transportauftrag
     WHERE EXTRACT(YEAR FROM dat_erstellung) >= YEAR(CURRENT_TIMESTAMP) - 2;