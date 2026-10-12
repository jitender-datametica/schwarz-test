CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_EWM(
	LIEF_BELEG_ID,
	LIEF_TYP_ID,
	MANDANT_ID,
	BELOS_VORGANG_ID,
	NB_ID,
	DAT_LIEF_SOLL,
	DAT_LEISTUNG,
	SENDUNG_ID,
	LAGERORT_ID,
	TRANSPORTAUFTRAG_ID,
	SONDERABWICKLUNG_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	ADRESS_NAME,
	LAGERNUMMER_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	LEERGUT_ABH_FG,
	RETOUREN_FG,
	INDUSTRIE_ABH_FG,
	ANZ_STELLPLATZ,
	BELOS_SENDUNGSSTATUS_ID,
	RUNDLAUF_TRANSPORT_FG,
	FLEISCHWERK_FG,
	DISTRIBUTION_ABR_FG,
	BRTGEW_SENDUNG,
	BRTVOL_STAURAUM,
	ANZ_STELLPLATZ_BELOS,
	MENGE_LIEF_IST_KOLLI
) AS
SELECT
agg.lief_beleg_id,
agg.lief_typ_id,
agg.mandant_id,
belos.belos_vorgang_id,
belos.nb_id,
agg.dat_lief_soll,
belos.dat_leistung,
belos.sendung_id,
agg.lagerort_id,
belos.transportauftrag_id,
belos.sonderabwicklung_id,
belos.belos_adresse_absender_num_id,
belos.belos_adresse_empfaenger_id,
belos.belos_adresse_spedition_id,
belos_adresse.adress_name,
agg.lagernummer_id,
agg.transportation_unit_id,
YEAR(agg.dat_tour) AS KJ_TRANSPORTATION_UNIT,
belos.leergut_abh_fg,
belos.retouren_fg,
belos.industrie_abh_fg,
belos.anz_stellplatz,
belos.belos_sendungsstatus_id,
belos.rundlauf_transport_fg,
belos.fleischwerk_fg,
belos.distribution_abr_fg,
MAX(belos.brtgew_sendung) brtgew_sendung,
MAX(belos.brtvol_stauraum) brtvol_stauraum,
MAX(belos.anz_stellplatz_belos) anz_stellplatz_belos,
SUM(agg.menge_lief_ist_kolli) menge_lief_ist_kolli
FROM dbp_view.v_besch_lief_wa_det agg
LEFT JOIN dbp_view.v_belos_vorgang belos ON agg.mandant_id=belos.mandant_id AND agg.belos_vorgang_id=belos.belos_vorgang_id
LEFT JOIN dbp_view.v_belos_adresse belos_adresse ON belos_adresse.mandant_id=belos.mandant_id AND belos_adresse.belos_adresse_id=belos.belos_adresse_spedition_id
WHERE COALESCE(belos.belosart_fg,1) = 1
AND agg.lief_typ_id NOT IN ( 'YCD1', 'EL')
GROUP BY agg.lief_beleg_id
,agg.lief_typ_id
,agg.mandant_id
,belos.belos_vorgang_id
,belos.nb_id
,belos.dat_leistung
,agg.dat_lief_soll
,belos.sendung_id
,agg.lagerort_id
,belos.transportauftrag_id
,belos.sonderabwicklung_id
,belos.belos_adresse_absender_num_id
,belos.belos_adresse_empfaenger_id
,belos.belos_adresse_spedition_id
,belos_adresse.adress_name
,agg.lagernummer_id
,agg.transportation_unit_id
,YEAR(agg.dat_tour)
,belos.leergut_abh_fg
,belos.retouren_fg
,belos.industrie_abh_fg
,belos.anz_stellplatz
,belos.belos_sendungsstatus_id
,belos.rundlauf_transport_fg
,belos.fleischwerk_fg
,belos.distribution_abr_fg
;