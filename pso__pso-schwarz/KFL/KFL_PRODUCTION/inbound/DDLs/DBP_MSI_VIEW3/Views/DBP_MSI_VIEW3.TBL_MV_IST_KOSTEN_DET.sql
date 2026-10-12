CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_IST_KOSTEN_DET
-- 02.02.2016, INC0638955, srom, Waehrungsumrechnung eingebaut
-- 18.10.2016, AP0002373, srom, separater Ausweis der Material und Lohnkosten
(
mandant_id
,psp_id
,gj
,buchungsperiode_id
,krk_id
,soll_haben_kz
,kostenart_id
,dat_beleg
,beleg_id
,beleg_pos_id
,betrag
,wrg_id
,wrg_typ_id
,geschaeftsbereich_id
,beleg_bez
,in_lief_id
,nebenkontierung_id
,nebenkontierungsart_id
,berichts_position_it_id
,berichts_position_invest_id
,sparte_id
,auftrag_id
,in_art_id
,buchungskreis_id
,anlage_id
,anlage_sub_id
,dat_buch
,menge
,menge_einh_id
,kostenstelle_id
,gegenkonto_id
,gegenkontoart_id
,ref_beleg_id
,ref_fi_beleg_id
,in_fi_belegkopftext
,best_beleg_id
,best_beleg_pos_id
,partner_objektart_id
,partner_objekt_id
,bestell_text
,ref_buchungskreis_id
,belegart_id
,belastungs_kz
,ref_vorgang_id
,co_leistungsart_id
)
AS
   SELECT
   v01.mandant_id, v01.psp_id, v01.gj, v01.buchungsperiode_id, v01.krk_id, v01.soll_haben_kz, v01.kostenart_id, v01.dat_beleg, v01.beleg_id, v01.beleg_pos_id, CASE WHEN v03.wrg_typ_id = 0
   THEN (v01.betrag * v02.umrechnungskurs)
   ELSE v01.betrag
   END AS betrag, v03.wrg_id, v03.wrg_typ_id, v01.geschaeftsbereich_id, v01.beleg_bez, v01.in_lief_id, v01.nebenkontierung_id, COALESCE(v01.nebenkontierungsart_id,'') AS nebenkontierungsart_id, v01.berichts_position_it_id, v01.berichts_position_invest_id, v01.sparte_id, v01.auftrag_id, v01.in_art_id, v01.buchungskreis_id, v01.anlage_id, v01.anlage_sub_id, v01.dat_buch, v01.menge, v01.menge_einh_id, v01.kostenstelle_id, v01.gegenkonto_id, v01.gegenkontoart_id, v01.ref_beleg_id, v01.ref_fi_beleg_id, v01.in_fi_belegkopftext, v01.best_beleg_id, v01.best_beleg_pos_id, v01.partner_objektart_id, v01.partner_objekt_id, v01.bestell_text, v01.ref_buchungskreis_id, v01.belegart_id, v01.belastungs_kz, v01.ref_vorgang_id, v01.co_leistungsart_id
   FROM dbp_view.v_ist_kosten_det v01

   JOIN dbp_msi_view3.mv_kurs v02
   ON v01.wrg_id = v02.von_wrg_id

   JOIN dbp_view.v_mandant_wrg_typ_zu v03
   ON v01.mandant_id = v03.mandant_id
   WHERE extract(year from v01.dat_buch) >= year(current_timestamp) - 2
   ;