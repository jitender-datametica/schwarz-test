create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORTAUFTRAG_EINLAGERSTRATEGIE(
	MANDANT_ID,
	TRANSPORT_BELEG_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	ENTFERNUNG_HORZ_1,
	AUFSCHLAG_GANGWECHSEL_1,
	AUFSCHLAG_HOEHE_1,
	LAGERPLATZ_TYP_AUFSCHLAG_1,
	ENTFERNUNG_HORZ_2,
	AUFSCHLAG_GANGWECHSEL_2,
	AUFSCHLAG_HOEHE_2,
	LAGERPLATZ_TYP_AUFSCHLAG_2,
	PALETTENSTEUERUNG_INDIV_FG,
	ALTERNATIVE_GRIFFZONE_FG,
	VON_LAGERTYP_ID,
	NACH_LAGERTYP_ID
) as
   SELECT
  v01.mandant_id, v01.transport_beleg_id, v01.lagernummer_id, v01.wup_id, v01.nb_id, v01.entfernung_horz_1, v01.aufschlag_gangwechsel_1, v01.aufschlag_hoehe_1, v01.lagerplatz_typ_aufschlag_1, v01.entfernung_horz_2, v01.aufschlag_gangwechsel_2, v01.aufschlag_hoehe_2, v01.lagerplatz_typ_aufschlag_2, v01.palettensteuerung_indiv_fg, v01.alternative_griffzone_fg, v02.von_lagertyp_id, v02.nach_lagertyp_id
   FROM dbp_view.v_transportauftrag_einlagerstrategie v01
   INNER JOIN dbp_view.v_transportauftrag_det v02
   ON v01.mandant_id = v02.mandant_id
   AND     v01.transport_beleg_id = v02.transport_beleg_id
   AND    v01.lagernummer_id = v02.lagernummer_id;