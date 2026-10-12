CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_vorgang (mandant_id, belos_vorgang_id, komplettlieferung_fg
, loesch_fg, in_time_fg, av_fg, sammel_ladung_fg, nb_id, sendung_gew_einh_id, sendung_vol_einh_id, dat_lief_soll,
dat_zustellung, sendung_id, wup_id, lagerort_id, hgp_id, gewicht_sendung, zustellart_id, belos_vorgangart_id,
transportauftrag_id, sonderabwicklung_id, belos_adresse_absender_num_id, belos_adresse_abholung_id,
belos_adresse_empfaenger_id, belos_adresse_spedition_id, vol_stauraum, debitor_id, anz_unterverpackung,
unterverpackung_menge_einh_id, anlieferart_id, belos_sendungsstatus_id, k_na_fg, belos_auftrag_id_extern,
belos_lieferschein_id, belos_sendung_id_extern, belos_bestell_beleg_id_extern, mandant_id_debitor, referenznr) AS SELECT
 V01.mandant_id,
 V01.belos_vorgang_id,
 V01.komplettlieferung_fg,
 V01.loesch_fg,
 V01.in_time_fg,
 V01.av_fg,
 V01.sammel_ladung_fg,
 V01.nb_id,
 V01.sendung_gew_einh_id,
 V01.sendung_vol_einh_id,
 V01.dat_leistung AS dat_lief_soll,
 V01.dat_zustellung,
 V01.sendung_id,
 V01.wup_id,
 V01.lagerort_id,
 V01.gp_id AS hgp_id,
 CAST(V01.gewicht_sendung AS NUMERIC) AS gewicht_sendung,
 V01.zustellart_id,
 V01.belos_vorgangart_id,
 V01.transportauftrag_id,
 V01.sonderabwicklung_id,
 V01.belos_adresse_absender_num_id,
 COALESCE(V01.belos_adresse_abholung_id, V02.belos_adresse_id) AS belos_adresse_abholung_id,
 V01.belos_adresse_empfaenger_id,
 V01.belos_adresse_spedition_id,
 V01.vol_stauraum,
 V01.debitor_id,
 V01.anz_unterverpackung,
 V01.unterverpackung_menge_einh_id,
  CASE
  WHEN V01.sammel_ladung_fg = 0
  THEN SUBSTR(CAST(- 1 AS STRING), 1, 40)
  ELSE V01.belos_adresse_spedition_id
  END AS anlieferart_id,
 V01.belos_sendungsstatus_id,
 V01.k_na_fg,
 V01.belos_auftrag_id_extern,
 V01.belos_lieferschein_id,
 V01.belos_sendung_id_extern,
 V01.belos_bestell_beleg_id_extern,
 V01.mandant_id_debitor,
 V01.referenz AS referenznr
FROM kfl_production_dbp_view.v_belos_vorgang AS V01
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse AS V02 ON V01.mandant_id = V02.mandant_id AND V01.belos_adresse_absender_num_id
    = V02.belos_adresse_num_id
WHERE CAST(FORMAT_DATE('%m%d%Y', V01.dat_leistung) AS FLOAT64) > 1011900
 AND V01.belos_vorgangart_id IN ('K-BESCH', 'K-RET', 'K-AV', 'K-LT', 'K-NA')
 AND V01.belosart_fg = 0
 AND V01.belos_adresse_absender_num_id IS NOT NULL;