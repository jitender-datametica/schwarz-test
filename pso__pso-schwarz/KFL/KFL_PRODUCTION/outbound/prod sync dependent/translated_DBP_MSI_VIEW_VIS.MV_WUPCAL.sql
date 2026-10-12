CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wupcal (mandant_id, nb_id, wup_id, dat, wrg_id, offen,
offen_von, offen_bis, werbewoche, ereignistyp_id, ereignis_id, ereignis_bez_kurz, ereignis_bez_lang, ereignis_fg,
ereignis_pic, bonanzahl, bonanzahl_imbiss, datenlieferung, datenlieferung_bon, bonanzahl_sug, umsatz_brutto_ods_verkauf
, umsatz_brutto_ods_kassenabschluss, datenlieferung_artbew, datenlieferung_artbew_wg_sum, datenlieferung_bonanzahl,
datenlieferung_misvier, datenlieferung_qbm_status, pruef_grund_id_kunde, pruef_grund_id_umsatz, pruef_status_id_kunde,
pruef_status_id_umsatz, bonanzahl_kundenkarte, bonanzahl_kundenkarte_payback, bonanzahl_frischetheke_ohne_fisch,
umsatz_netto_kundenkarte
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene')) AS
WITH EREIGNIS AS (SELECT V010.mandant_id,
   V010.nb_id,
   V010.wup_id,
   V010.dat,
   MAX(CASE
     WHEN V010.ereignistyp_id IN (12310)
     THEN V010.ereignistyp_id
     ELSE NULL
     END) AS ereignistyp_id,
   MAX(CASE
     WHEN V010.ereignistyp_id IN (12310)
     THEN V010.ereignis_id
     ELSE NULL
     END) AS ereignis_id,
   MAX(CASE
     WHEN V010.ereignistyp_id IN (12310)
     THEN V020.ereignis_bez_kurz
     ELSE NULL
     END) AS ereignis_bez_kurz,
   MAX(CASE
     WHEN V010.ereignistyp_id IN (12310)
     THEN V020.ereignis_bez_lang
     ELSE NULL
     END) AS ereignis_bez_lang,
   MAX(CASE
     WHEN V010.mandant_id = 1 AND V010.ereignistyp_id = 2 AND V010.ereignis_id = 1
     THEN NULL
     ELSE 1
     END) AS ereignis_fg
  FROM kfl_production_dbp_view.v_tag AS V00
   INNER JOIN kfl_production_dbp_view.v_wupcal_ereignis_zu AS V010 ON V00.dat = V010.dat
   INNER JOIN kfl_production_dbp_view.v_ereignis_spr_zu AS V020 ON V010.mandant_id = V020.mandant_id AND V010.ereignis_id
       = V020.ereignis_id AND V010.ereignistyp_id = V020.ereignistyp_id
  WHERE V00.akt_gj BETWEEN -2 AND 0
   AND V010.nb_id IN (0, 2, 7)
   AND V020.spr_id = 22
  GROUP BY V010.mandant_id,
   V010.nb_id,
   V010.wup_id,
   V010.dat) (SELECT V01.mandant_id,
   V01.nb_id,
   W.aktuell_wup_id AS wup_id,
   V01.dat,
   K.nach_wrg_id AS wrg_id,
   V01.offen,
   V01.offen_von,
   V01.offen_bis,
   V01.werbewoche,
   v03.ereignistyp_id,
   v03.ereignis_id,
   v03.ereignis_bez_kurz,
   v03.ereignis_bez_lang,
   v03.ereignis_fg,
   CAST(CASE
     WHEN v03.ereignis_fg = 1
     THEN 'iconDetails.gif'
     ELSE 'demo/transparent.gif'
     END AS STRING) AS ereignis_pic,
   V01.bonanzahl,
   V01.bonanzahl_imbiss,
   V01.datenlieferung_artbew_wg_sum AS datenlieferung,
   V01.datenlieferung_bonanzahl AS datenlieferung_bon,
   V01.bonanzahl_sug,
    V01.umsatz_brutto_ods_verkauf * K.umrechnungskurs AS umsatz_brutto_ods_verkauf,
    V01.umsatz_brutto_ods_kassenabschluss * K.umrechnungskurs AS umsatz_brutto_ods_kassenabschluss,
   V01.datenlieferung_artbew,
   V01.datenlieferung_artbew_wg_sum,
   V01.datenlieferung_bonanzahl,
   V01.datenlieferung_misvier,
   V01.datenlieferung_qbm_status,
   V01.pruef_grund_id_kunde,
   V01.pruef_grund_id_umsatz,
   V01.pruef_status_id_kunde,
   V01.pruef_status_id_umsatz,
   V01.bonanzahl_kundenkarte,
   V01.bonanzahl_kundenkarte_payback,
   V01.bonanzahl_frischetheke_ohne_fisch,
    V01.betrag_vk_netto_kundenkarte * K.umrechnungskurs AS umsatz_netto_kundenkarte
  FROM kfl_production_dbp_view.v_wupcal AS V01
   INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = V02.dat
   LEFT JOIN EREIGNIS AS v03 ON V01.mandant_id = v03.mandant_id AND V01.nb_id = v03.nb_id AND V01.wup_id = v03.wup_id
    AND V01.dat = v03.dat
   INNER JOIN kfl_production_dbp_view.v_wup AS W ON V01.mandant_id = W.mandant_id AND V01.wup_id = W.wup_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung AS K ON V01.wrg_id = K.von_wrg_id
  WHERE V01.nb_id IN (0, 2, 7));