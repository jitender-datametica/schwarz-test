CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG_EINLAGERSTRATEGIE_2
-- 01.02.2018,  AP0022537 - Reporting Einlagerstrategie, mkub1811, transportauftrag_einlagerstrategie_2 View implementierung
(
mandant_id
,transport_beleg_id
,lagernummer_id
,wup_id
,nb_id
,entfernung_horz_1
,aufschlag_gangwechsel_1
,aufschlag_hoehe_1
,lagerplatz_typ_aufschlag_1
,entfernung_horz_2
,aufschlag_gangwechsel_2
,aufschlag_hoehe_2
,lagerplatz_typ_aufschlag_2
,palettensteuerung_indiv_fg
,alternative_griffzone_fg
,von_lagertyp_id
,nach_lagertyp_id
)
AS
   SELECT
  v01.mandant_id, v01.transport_beleg_id, v01.lagernummer_id, v01.wup_id, v01.nb_id, v01.entfernung_horz_1, v01.aufschlag_gangwechsel_1, v01.aufschlag_hoehe_1, v01.lagerplatz_typ_aufschlag_1, v01.entfernung_horz_2, v01.aufschlag_gangwechsel_2, v01.aufschlag_hoehe_2, v01.lagerplatz_typ_aufschlag_2, v01.palettensteuerung_indiv_fg, v01.alternative_griffzone_fg, v02.von_lagertyp_id, v02.nach_lagertyp_id
   FROM dbp_view.v_transportauftrag_einlagerstrategie_2 v01
   INNER JOIN dbp_view.v_transportauftrag_det_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND     v01.transport_beleg_id = v02.transport_beleg_id
   AND    v01.lagernummer_id = v02.lagernummer_id;