CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_transportauftrag_einlagerstrategie_1 (mandant_id,
transport_beleg_id, lagernummer_id, wup_id, nb_id, entfernung_horz_1, aufschlag_gangwechsel_1, aufschlag_hoehe_1,
lagerplatz_typ_aufschlag_1, entfernung_horz_2, aufschlag_gangwechsel_2, aufschlag_hoehe_2, lagerplatz_typ_aufschlag_2,
palettensteuerung_indiv_fg, alternative_griffzone_fg, von_lagertyp_id, nach_lagertyp_id) AS SELECT V01.mandant_id,
 V01.transport_beleg_id,
 V01.lagernummer_id,
 V01.wup_id,
 V01.nb_id,
 V01.entfernung_horz_1,
 V01.aufschlag_gangwechsel_1,
 V01.aufschlag_hoehe_1,
 V01.lagerplatz_typ_aufschlag_1,
 V01.entfernung_horz_2,
 V01.aufschlag_gangwechsel_2,
 V01.aufschlag_hoehe_2,
 V01.lagerplatz_typ_aufschlag_2,
 V01.palettensteuerung_indiv_fg,
 V01.alternative_griffzone_fg,
 V02.von_lagertyp_id,
 V02.nach_lagertyp_id
FROM kfl_production_dbp_view.v_transportauftrag_einlagerstrategie_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_transportauftrag_det_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.transport_beleg_id
     = V02.transport_beleg_id AND V01.lagernummer_id = V02.lagernummer_id;