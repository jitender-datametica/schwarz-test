CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_wanko_tms_tour_2 (USERID STRING) AS SELECT T.mandant_id,
 T.system_id,
 T.tms_tour_id,
 T.transportation_unit_id,
 T.kj_transportation_unit,
 T.transportation_unit_id_ext,
 T.tms_tour_bez,
 T.dat_tour,
 T.tourart_id,
 T.tms_tourart_id,
 T.tms_tourart_bez,
 T.tms_tourtyp_id,
 T.tms_tourstatus_id,
 T.lieferkunde_tms_gp_typ_cd,
 T.tms_standorttyp_id,
 T.lieferkunde_tms_gp_id,
 T.frachtzahler_id,
 T.anz_stopp,
 T.anz_stellplatz,
 T.tms_fahrzeug_id,
 T.tms_fahrzeugtyp_id,
 T.tms_trailer_id,
 T.tms_trailer_typ_id,
 T.spedition_tms_gp_id,
 T.spedition_tms_gp_typ_cd,
 T.tms,
 T.temperaturgruppe_id,
 T.tms_sortiment_id,
 T.artikelsortiment_id,
 T.lagernummer_les_id,
 T.gutschrift_erstellt_fg,
 T.startlager_tms_gp_id,
 T.startlager_tms_gp_typ_cd,
 T.wup_id,
 T.ziellager_tms_gp_id,
 T.ziellager_tms_gp_typ_cd,
 T.maut_km,
 T.leer_km,
 T.anz_aenderung,
 W_TYP.wrg_id,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_fixkosten * K.umrechnungskurs
  ELSE T.betrag_fixkosten
  END AS betrag_fixkosten,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_netto * K.umrechnungskurs
  ELSE T.betrag_netto
  END AS betrag_netto,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_diesel * K.umrechnungskurs
  ELSE T.betrag_diesel
  END AS betrag_diesel,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_strom * K.umrechnungskurs
  ELSE T.betrag_strom
  END AS betrag_strom,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_gas * K.umrechnungskurs
  ELSE T.betrag_gas
  END AS betrag_gas,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_maut * K.umrechnungskurs
  ELSE T.betrag_maut
  END AS betrag_maut,
  CASE
  WHEN W_TYP.wrg_typ_id = 0
  THEN T.betrag_kuehlung * K.umrechnungskurs
  ELSE T.betrag_kuehlung
  END AS betrag_kuehlung,
 T.richtung_id,
 T.tms_treibstoff_id,
 T.kosten_upload_fg,
 T.tu_costs_incomplete_fg,
 T.menge_lief_ist_kolli,
 T.volumen_gedeckelt,
 T.gewicht_brutto,
 T.anzahl_stellplatz,
 T.anzahl_stellplatz_gesamt,
 T.anzahl_kunde_sortiment,
 T.anteil_stellplatz,
 T.menge_gefahrgut,
 T.rueckfuehrung_fg,
 T.ewm_fg,
 T.nutzung_grund_id,
 T.antriebsart_id
FROM kfl_production_dbp_msi_view_log.mv_dt_wanko_tms_tour_2 AS T
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS W_TYP ON T.mandant_id = W_TYP.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS AKT_U ON W_TYP.wrg_typ_id = AKT_U.wrg_typ_id
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS K ON T.wrg_id = K.von_wrg_id;
