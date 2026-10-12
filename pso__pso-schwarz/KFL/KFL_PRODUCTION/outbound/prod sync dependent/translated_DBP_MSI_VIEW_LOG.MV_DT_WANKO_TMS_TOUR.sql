

CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_log.mv_dt_wanko_tms_tour
 AS
SELECT TMS_TOUR.mandant_id,
 TMS_TOUR.system_id,
 TMS_TOUR.tms_tour_id,
 COALESCE(t6.transportation_unit_id, wa_les.transportation_unit_id, ROUND(SAFE_CAST(FORMAT_DATE('%Y%m%d', TMS_TOUR.dat_tour
      ) || CAST(TMS_TOUR.tms_tour_id AS STRING) AS BIGNUMERIC), 0)) AS transportation_unit_id,
 COALESCE(t6.kj_transportation_unit, EXTRACT(YEAR FROM wa_les.dat_tour), EXTRACT(YEAR FROM TMS_TOUR.dat_tour)) AS
 kj_transportation_unit,
 TMS_TOUR.transportation_unit_id_ext,
 TMS_TOUR.tms_tour_bez,
 TMS_TOUR.dat_tour,
 TMS_TOUR.tms_tourart_detail_id AS tourart_id_,
 COALESCE(CAST(TMS_TOUR.tms_tourart_id AS BIGNUMERIC), -1) AS tms_tourart_id_,
  CASE
  WHEN COALESCE(CAST(TMS_TOUR.tms_tourart_id AS BIGNUMERIC), -1) = 0
  THEN 'K-K'
  WHEN COALESCE(CAST(TMS_TOUR.tms_tourart_id AS BIGNUMERIC), -1) = 1
  THEN 'L-K'
  WHEN COALESCE(CAST(TMS_TOUR.tms_tourart_id AS BIGNUMERIC), -1) = 2
  THEN 'K-L'
  WHEN COALESCE(CAST(TMS_TOUR.tms_tourart_id AS BIGNUMERIC), -1) = 3
  THEN 'L-L'
  ELSE 'not defined'
  END AS tms_tourart_bez,
 TMS_TOUR.tms_tourtyp_id,
 TMS_TOUR.tms_tourstatus_id,
 COALESCE(tms_tour_d.lieferkunde_tms_gp_typ_cd, '-1') AS lieferkunde_tms_gp_typ_cd,
 COALESCE(CASE
   WHEN tms_tour_d.tms_standorttyp_id = 0
   THEN -1
   ELSE tms_tour_d.tms_standorttyp_id
   END, -1) AS tms_standorttyp_id,
  CASE
  WHEN COALESCE(W.aktuell_wup_id, 0) <> COALESCE(W.wup_id, 0) AND COALESCE(W.wup_id, 0) > 0 AND tms_tour_d.lieferkunde_tms_gp_id
    NOT LIKE 'DC%'
  THEN CAST(W.aktuell_wup_id AS STRING)
  ELSE tms_tour_d.lieferkunde_tms_gp_id
  END AS lieferkunde_tms_gp_id,
 COALESCE(tms_rech.frachtzahler_tms_gp_id, TMS_DISPO.bestand_tms_gp_id, '-1') AS frachtzahler,
 TMS_TOUR.anz_stopp,
 TMS_TOUR.anz_stellplatz,
 TMS_TOUR.tms_fahrzeug_id,
 TMS_TOUR.tms_fahrzeugtyp_id,
 TMS_TOUR.tms_trailer_id,
 TMS_TOUR.tms_trailer_typ_id,
 COALESCE(TMS_TOUR.spedition_tms_gp_id, '-1') AS spedition_tms_gp_id,
 TMS_TOUR.spedition_tms_gp_typ_cd,
 'WANKO' AS tms,
  CASE
  WHEN TMS_TOUR.sortiment_temperaturgruppe_id = 1
  THEN 'TK'
  WHEN TMS_TOUR.sortiment_temperaturgruppe_id = 2
  THEN 'GK'
  WHEN TMS_TOUR.sortiment_temperaturgruppe_id = 3
  THEN 'TE'
  ELSE 'UK'
  END AS temperaturgruppe_id,
 -1 AS tms_sortiment_id,
 COALESCE(CAST(wa.artikelsortiment_id AS BIGNUMERIC), CAST(wa_les.artikelsortiment_id AS BIGNUMERIC), -1) AS
 artikelsortiment_id,
 COALESCE(wa_les.lagernummer_id, '-1') AS lagernummer_les_id,
 TMS_TOUR.gutschrift_erstellt_fg,
 TMS_DISPO.bestand_tms_gp_id AS startlager_tms_gp_id,
 TMS_DISPO.bestand_tms_gp_typ_cd AS startlager_tms_gp_typ_cd,
 ROUND(SAFE_CAST(TMS_DISPO.bestand_tms_gp_id AS BIGNUMERIC), 0) AS wup_id,
 TMS_TOUR.ziellager_tms_gp_id,
 TMS_TOUR.ziellager_tms_gp_typ_cd,
 TMS_TOUR.maut_km,
 TMS_TOUR.leer_km,
 TMS_TOUR.anz_aenderung,
 COALESCE(tms_rech.wrg_id, TU_K.wrg_id, W_TYP.wrg_id) AS wrg_id_,
  TMS_TOUR.betrag_fixkosten * CASE
   WHEN tms_rech.konto_700_vorh = 1
   THEN 0
   ELSE 1
   END AS betrag_fixkosten,
 tms_rech.betrag_netto,
 TU_K.betrag_diesel,
 TU_K.betrag_strom,
 TU_K.betrag_gas,
 TU_K.betrag_maut,
 TU_K.betrag_kuehlung,
 TMS_TOUR.tms_tour_richtungsart_id AS richtung_id,
 TMS_F.tms_treibstoff_id,
 COALESCE(TS_WUP_K.kosten_upload_fg, -1) AS kosten_upload_fg_,
  CASE
  WHEN COALESCE(TS_WUP_K.kosten_upload_fg, -1) = 1 AND IFNULL(TU_K.betrag_diesel, 0) = 0 AND IFNULL(TU_K.betrag_strom, 0
         ) = 0 AND IFNULL(TU_K.betrag_gas, 0) = 0 AND IFNULL(TU_K.betrag_maut, 0) = 0 AND IFNULL(TU_K.betrag_kuehlung, 0
      ) = 0 AND IFNULL(TU_K.betrag_sonstiges, 0) = 0
  THEN 1
  ELSE 0
  END AS tu_costs_incomplete_fg,
 COALESCE(wa.menge_lief_ist_kolli, wa_les.menge_lief_ist_kolli) AS menge_lief_ist_kolli,
  CASE
  WHEN wa_les.brtvol_ladung_gedeckelt IS NOT NULL
  THEN wa_les.brtvol_ladung_gedeckelt
  WHEN t6.mandant_id IS NOT NULL
  THEN wa.brtvol_hu_gedeckelt_oa
  WHEN tms_tour_d.volumen_cbm = 0 AND tms_tour_d.volumen_cbm_retoure > 0
  THEN tms_tour_d.volumen_cbm_retoure
  ELSE tms_tour_d.volumen_cbm
  END AS volumen_gedeckelt,
  CASE
  WHEN wa_les.brtgew_ladung IS NOT NULL
  THEN wa_les.brtgew_ladung
  WHEN t6.mandant_id IS NOT NULL
  THEN wa.brtgew_hu_oa
  WHEN tms_tour_d.gewicht_kg_retoure > 0 AND tms_tour_d.gewicht_kg = 0
  THEN tms_tour_d.gewicht_kg_retoure
  ELSE tms_tour_d.gewicht_kg
  END AS gewicht_brutto,
  CASE
  WHEN wa_les.anzahl_stellplatz IS NOT NULL
  THEN wa_les.anzahl_stellplatz
  WHEN t6.mandant_id IS NULL
  THEN CASE
   WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
   THEN tms_tour_d.anz_stellplatz_retoure
   WHEN tms_tour_d.anz_stellplatz = 0
   THEN 1
   ELSE tms_tour_d.anz_stellplatz
   END
  ELSE wa.anzahl_stellplatz_ewm
  END AS anzahl_stellplatz_,
 SUM(CASE
   WHEN wa_les.anzahl_stellplatz IS NOT NULL
   THEN wa_les.anzahl_stellplatz
   WHEN t6.mandant_id IS NULL
   THEN CASE
    WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
    THEN tms_tour_d.anz_stellplatz_retoure
    WHEN tms_tour_d.anz_stellplatz = 0
    THEN 1
    ELSE tms_tour_d.anz_stellplatz
    END
   ELSE wa.anzahl_stellplatz_ewm
   END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_stellplatz_gesamt,
 COUNT(tms_tour_d.lieferkunde_tms_gp_id || '_' || CAST(COALESCE(CAST(wa.artikelsortiment_id AS BIGNUMERIC), CAST(wa_les.artikelsortiment_id AS BIGNUMERIC)
     , -1) AS STRING)) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_kunde_sortiment,
   CASE
   WHEN (SUM(CASE
       WHEN wa_les.anzahl_stellplatz IS NOT NULL
       THEN wa_les.anzahl_stellplatz
       WHEN t6.mandant_id IS NULL
       THEN CASE
        WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
        THEN tms_tour_d.anz_stellplatz_retoure
        WHEN tms_tour_d.anz_stellplatz = 0
        THEN 1
        ELSE tms_tour_d.anz_stellplatz
        END
       ELSE wa.anzahl_stellplatz_ewm
       END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL OR (SUM(CASE
        WHEN wa_les.anzahl_stellplatz IS NOT NULL
        THEN wa_les.anzahl_stellplatz
        WHEN t6.mandant_id IS NULL
        THEN CASE
         WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
         THEN tms_tour_d.anz_stellplatz_retoure
         WHEN tms_tour_d.anz_stellplatz = 0
         THEN 1
         ELSE tms_tour_d.anz_stellplatz
         END
        ELSE wa.anzahl_stellplatz_ewm
        END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
   THEN 1
   WHEN wa_les.anzahl_stellplatz IS NOT NULL
   THEN wa_les.anzahl_stellplatz
   WHEN t6.mandant_id IS NULL
   THEN CASE
    WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
    THEN tms_tour_d.anz_stellplatz_retoure
    WHEN tms_tour_d.anz_stellplatz = 0
    THEN 1
    ELSE tms_tour_d.anz_stellplatz
    END
   ELSE wa.anzahl_stellplatz_ewm
   END / CASE
   WHEN COALESCE(SUM(CASE
       WHEN wa_les.anzahl_stellplatz IS NOT NULL
       THEN wa_les.anzahl_stellplatz
       WHEN t6.mandant_id IS NULL
       THEN CASE
        WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
        THEN tms_tour_d.anz_stellplatz_retoure
        WHEN tms_tour_d.anz_stellplatz = 0
        THEN 1
        ELSE tms_tour_d.anz_stellplatz
        END
       ELSE wa.anzahl_stellplatz_ewm
       END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
   THEN CAST(COUNT(tms_tour_d.lieferkunde_tms_gp_id || '_' || CAST(COALESCE(CAST(wa.artikelsortiment_id AS BIGNUMERIC), CAST(wa_les.artikelsortiment_id AS BIGNUMERIC)
        , -1) AS STRING)) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC)
   WHEN (SUM(CASE
       WHEN wa_les.anzahl_stellplatz IS NOT NULL
       THEN wa_les.anzahl_stellplatz
       WHEN t6.mandant_id IS NULL
       THEN CASE
        WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
        THEN tms_tour_d.anz_stellplatz_retoure
        WHEN tms_tour_d.anz_stellplatz = 0
        THEN 1
        ELSE tms_tour_d.anz_stellplatz
        END
       ELSE wa.anzahl_stellplatz_ewm
       END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
   THEN SUM(CASE
     WHEN wa_les.anzahl_stellplatz IS NOT NULL
     THEN wa_les.anzahl_stellplatz
     WHEN t6.mandant_id IS NULL
     THEN CASE
      WHEN tms_tour_d.anz_stellplatz_retoure > 0 AND tms_tour_d.anz_stellplatz = 0
      THEN tms_tour_d.anz_stellplatz_retoure
      WHEN tms_tour_d.anz_stellplatz = 0
      THEN 1
      ELSE tms_tour_d.anz_stellplatz
      END
     ELSE wa.anzahl_stellplatz_ewm
     END) OVER (PARTITION BY TMS_TOUR.mandant_id, TMS_TOUR.system_id, TMS_TOUR.tms_tour_id, TMS_TOUR.dat_tour
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   ELSE 1
   END AS anteil_stellplatz,
 COALESCE(wa.menge_gefahrgut, wa_les.menge_gefahrgut) AS menge_gefahrgut,
  CASE
  WHEN rf.tour_id IS NOT NULL
  THEN '1'
  ELSE '0'
  END AS rueckfuehrung_fg,
  CASE
  WHEN LEFT(S.kl_system_bez, 3) = 'FLW'
  THEN 2
  WHEN t6.transportation_unit_id IS NOT NULL
  THEN 1
  WHEN LEFT(TMS_TOUR.transportation_unit_id_ext, 3) = 'SAP' OR ewm.dat_ewm_von > TMS_TOUR.dat_tour
  THEN 0
  ELSE 1
  END AS ewm_fg,
 COALESCE(TU_A.nutzung_grund_id, wa_les.sap_auslastungsgrund) AS nutzung_grund_id,
 COALESCE(TMS_TOUR.antriebsart_id, -1) AS antriebsart_id
FROM kfl_production_dbp_view.v_tms_tour AS TMS_TOUR
 INNER JOIN kfl_production_dbp_view.v_l_system AS S ON TMS_TOUR.system_id = S.system_id
 INNER JOIN kfl_production_dbp_view.v_tms_dispostelle AS TMS_DISPO ON TMS_TOUR.mandant_id = TMS_DISPO.mandant_id AND
    TMS_TOUR.tms_tour_dispostelle_id = TMS_DISPO.tms_dispostelle_id AND TMS_TOUR.system_id = TMS_DISPO.system_id
 INNER JOIN (SELECT mandant_id,
   wup_id,
   MIN(COALESCE(dat, DATE '9999-12-31')) AS dat_ewm_von
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat
  GROUP BY mandant_id,
   wup_id) AS ewm ON TMS_DISPO.mandant_id = ewm.mandant_id AND CAST(TMS_DISPO.bestand_tms_gp_id AS FLOAT64) = ewm.wup_id
   
 LEFT JOIN (SELECT TMS_RECH_D.mandant_id,
   TMS_RECH_D.system_id,
   SAFE_CAST(TMS_RECH_D.tms_tour_id AS BIGNUMERIC) AS tms_tour_id,
   TMS_DISPO0.bestand_tms_gp_id AS tms_rech_dispostelle_gp_id,
   TMS_RECH.ersteller_tms_gp_id AS frachtzahler_tms_gp_id,
   TMS_RECH_D.dat_tour,
   TMS_RECH.wrg_id,
   MAX(CASE
     WHEN TMS_RECH_D.tms_konto_id = 700
     THEN 1
     ELSE 0
     END) AS konto_700_vorh,
   SUM(TMS_RECH_D.betrag_netto) AS betrag_netto
  FROM kfl_production_dbp_view.v_tms_rechnung_det AS TMS_RECH_D
   INNER JOIN kfl_production_dbp_view.v_tms_rechnung AS TMS_RECH ON TMS_RECH_D.tms_rech_beleg_id = TMS_RECH.tms_rech_beleg_id
       AND TMS_RECH_D.mandant_id = TMS_RECH.mandant_id AND TMS_RECH_D.system_id = TMS_RECH.system_id
   LEFT JOIN kfl_production_dbp_view.v_tms_dispostelle AS TMS_DISPO0 ON TMS_RECH.mandant_id = TMS_DISPO0.mandant_id AND
      TMS_RECH.tms_dispostelle_id = TMS_DISPO0.tms_dispostelle_id AND TMS_RECH.system_id = TMS_DISPO0.system_id
  WHERE TMS_RECH.storno_fg = 0
  GROUP BY TMS_RECH_D.mandant_id,
   TMS_RECH_D.system_id,
   TMS_RECH_D.tms_tour_id,
   tms_rech_dispostelle_gp_id,
   TMS_RECH_D.dat_tour,
   TMS_RECH.wrg_id,
   frachtzahler_tms_gp_id) AS tms_rech ON TMS_TOUR.mandant_id = tms_rech.mandant_id AND TMS_TOUR.tms_tour_id = tms_rech
     .tms_tour_id AND TMS_TOUR.dat_tour = tms_rech.dat_tour AND TMS_TOUR.system_id = tms_rech.system_id
 LEFT JOIN (SELECT mandant_id,
   transportation_unit_id_ext,
   kj_transportation_unit,
   MAX(transportation_unit_id) AS transportation_unit_id
  FROM kfl_production_dbp_view.v_transportation_unit
  GROUP BY mandant_id,
   kj_transportation_unit,
   transportation_unit_id_ext) AS t6 ON TMS_TOUR.mandant_id = t6.mandant_id AND TMS_TOUR.transportation_unit_id_ext = t6
   .transportation_unit_id_ext
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet AS TU_A ON t6.mandant_id = TU_A.mandant_id AND t6.transportation_unit_id
      = TU_A.transportation_unit_id AND t6.kj_transportation_unit = TU_A.kj_transportation_unit AND TU_A.aktivitaet_richtung_id
    = '2'
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS W_TYP ON TMS_TOUR.mandant_id = W_TYP.mandant_id AND W_TYP.wrg_typ_id
    = 1
 INNER JOIN (SELECT TMS_TOUR_DET.mandant_id,
   TMS_TOUR_DET.system_id,
   TMS_TOUR_DET.tms_tour_id,
   TMS_TOUR_DET.dat_tour,
   TMS_TOUR_DET.lieferkunde_tms_gp_id,
   TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd,
   COALESCE(TMS_GP.tms_standorttyp_id, -1) AS tms_standorttyp_id,
   SUM(TMS_TOUR_DET.gewicht_kg) AS gewicht_kg,
   SUM(TMS_TOUR_DET.volumen_cbm) AS volumen_cbm,
   SUM(TMS_TOUR_DET.anz_stellplatz) AS anz_stellplatz,
   SUM(TMS_TOUR_DET.gewicht_kg_retoure) AS gewicht_kg_retoure,
   SUM(TMS_TOUR_DET.volumen_cbm_retoure) AS volumen_cbm_retoure,
   SUM(TMS_TOUR_DET.anz_stellplatz_retoure) AS anz_stellplatz_retoure
  FROM kfl_production_dbp_view.v_tms_tour_det AS TMS_TOUR_DET
   LEFT JOIN kfl_production_dbp_view.v_tms_gp AS TMS_GP ON TMS_TOUR_DET.mandant_id = TMS_GP.mandant_id AND TMS_TOUR_DET
       .lieferkunde_tms_gp_id = TMS_GP.tms_gp_id AND TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd = TMS_GP.tms_gp_typ_cd AND
     TMS_TOUR_DET.system_id = TMS_GP.system_id
  GROUP BY TMS_TOUR_DET.mandant_id,
   TMS_TOUR_DET.system_id,
   TMS_TOUR_DET.tms_tour_id,
   TMS_TOUR_DET.dat_tour,
   TMS_TOUR_DET.lieferkunde_tms_gp_id,
   TMS_TOUR_DET.lieferkunde_tms_gp_typ_cd,
   TMS_GP.tms_standorttyp_id) AS tms_tour_d ON TMS_TOUR.mandant_id = tms_tour_d.mandant_id AND TMS_TOUR.tms_tour_id =
     tms_tour_d.tms_tour_id AND TMS_TOUR.dat_tour = tms_tour_d.dat_tour AND TMS_TOUR.system_id = tms_tour_d.system_id
 LEFT JOIN (SELECT mandant_id,
   system_id,
   tms_tour_id,
   dat_tour,
   lieferkunde_tms_gp_id
  FROM kfl_production_dbp_view.v_tms_tour_det AS TMS_TOUR_DET
  WHERE tms_tour_pos_id = 1) AS tms_tour_d_f ON TMS_TOUR.mandant_id = tms_tour_d_f.mandant_id AND TMS_TOUR.tms_tour_id =
     tms_tour_d_f.tms_tour_id AND TMS_TOUR.dat_tour = tms_tour_d_f.dat_tour AND TMS_TOUR.system_id = tms_tour_d_f.system_id
   
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON tms_tour_d.mandant_id = W.mandant_id AND ROUND(SAFE_CAST(REPLACE(TRANSLATE(tms_tour_d
        .lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS BIGNUMERIC), 0) = W.wup_id AND (W.nb_id IN (2, 0, -111
       ) AND W.wup_id > 0 OR W.nb_id = -1 AND W.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_tms_fahrzeug AS TMS_F ON TMS_TOUR.tms_fahrzeugtyp_id = TMS_F.tms_fahrzeugtyp_id AND
     TMS_TOUR.mandant_id = TMS_F.mandant_id AND TMS_TOUR.tms_fahrzeug_id = TMS_F.tms_fahrzeug_id AND TMS_TOUR.system_id
   = TMS_F.system_id
 LEFT JOIN (SELECT V01.mandant_id,
   V01.transportation_unit_id,
   V01.dat_tour,
   CAST(ROUND(SAFE_CAST(V02.kunde_id AS BIGNUMERIC), 0) AS STRING) AS kunde_id_,
   W0.system_id,
   W0.tms_standorttyp_id AS tms_standorttyp_id_kunde,
   W0.tms_gp_typ_cd,
    CASE
    WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '5'
    THEN '1'
    WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '7'
    THEN '2'
    ELSE LEFT(RIGHT(V01.versandstelle_id, 2), 1)
    END AS artikelsortiment_id,
   COALESCE(ttd.kd_exist, 0) AS kd_exist,
   SUM(V01.menge_lief_ist_kolli) AS menge_lief_ist_kolli,
   SUM(V01.brtvol_hu_gedeckelt_oa) AS brtvol_hu_gedeckelt_oa,
   SUM(V01.brtgew_hu_oa) AS brtgew_hu_oa,
   SUM(V01.anzahl_stellplatz_ewm) AS anzahl_stellplatz_ewm,
   SUM(V01.menge_gefahrgut) AS menge_gefahrgut
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum AS V01
   INNER JOIN kfl_production_dbp_view.v_besch_lief AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lief_beleg_id = V02
      .lief_beleg_id AND V01.dat_lief_soll = V02.dat_lief_soll
   LEFT JOIN kfl_production_dbp_view.v_wup AS W1 ON ROUND(SAFE_CAST(V02.kunde_id AS BIGNUMERIC), 0) = W1.wup_id AND V01
     .mandant_id_kunde = W1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_tms_gp AS W0 ON V01.mandant_id = W0.mandant_id AND CAST(ROUND(SAFE_CAST(V02.kunde_id AS BIGNUMERIC), 0) AS STRING)
      = W0.tms_gp_id AND CASE
      WHEN W1.nb_id IS NULL
      THEN W0.tms_gp_typ_cd
      WHEN COALESCE(W1.nb_id, 0) <> 0
      THEN 'L'
      ELSE '0'
      END = W0.tms_gp_typ_cd
   LEFT JOIN (SELECT mandant_id,
     system_id,
     tms_tour_id,
     dat_tour,
     lieferkunde_tms_gp_id,
     1 AS kd_exist
    FROM kfl_production_dbp_view.v_tms_tour_det
    GROUP BY mandant_id,
     system_id,
     tms_tour_id,
     dat_tour,
     lieferkunde_tms_gp_id) AS ttd ON V01.mandant_id = ttd.mandant_id AND W0.system_id = ttd.system_id AND V01.tms_tour_id
        = ttd.tms_tour_id AND V01.dat_tour = ttd.dat_tour AND CAST(ROUND(SAFE_CAST(V02.kunde_id AS BIGNUMERIC), 0) AS STRING)
     = ttd.lieferkunde_tms_gp_id
   INNER JOIN kfl_production_dbp_view.v_tag AS T ON V01.dat_lief_soll = T.dat AND T.akt_kj BETWEEN -2 AND 0
  GROUP BY V01.mandant_id,
   V01.transportation_unit_id,
   V01.dat_tour,
   V02.kunde_id,
   tms_standorttyp_id_kunde,
   artikelsortiment_id,
   W0.system_id,
   W0.tms_gp_typ_cd,
   kd_exist) AS wa ON TMS_TOUR.mandant_id = wa.mandant_id AND t6.transportation_unit_id = wa.transportation_unit_id AND
      TMS_TOUR.system_id = wa.system_id AND TMS_TOUR.dat_tour = wa.dat_tour AND CASE
     WHEN TMS_TOUR.tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> TMS_DISPO.bestand_tms_gp_id AND
         tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa.kd_exist = 0 OR TMS_TOUR.tms_tourart_detail_id = 6 AND wa.tms_standorttyp_id_kunde
          IN (1, 2) AND W.nb_id = -111
     THEN '1'
     ELSE tms_tour_d.lieferkunde_tms_gp_id
     END = CASE
     WHEN TMS_TOUR.tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> TMS_DISPO.bestand_tms_gp_id AND
         tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa.kd_exist = 0 OR TMS_TOUR.tms_tourart_detail_id = 6 AND wa.tms_standorttyp_id_kunde
          IN (1, 2) AND W.nb_id = -111
     THEN '1'
     ELSE wa.kunde_id_
     END AND CASE
    WHEN TMS_TOUR.tms_tourart_detail_id IN (1, 2) AND wa.kd_exist = 1
    THEN tms_tour_d.lieferkunde_tms_gp_typ_cd
    ELSE '0'
    END = CASE
    WHEN TMS_TOUR.tms_tourart_detail_id IN (1, 2) AND wa.kd_exist = 1
    THEN wa.tms_gp_typ_cd
    ELSE '0'
    END
 LEFT JOIN (SELECT TD.mandant_id,
   W2.system_id,
   T0.tour_id AS transportation_unit_id,
   T0.dat_tour,
   AGR.sap_auslastungsgrund,
   ROUND(SAFE_CAST(BL.kunde_id AS BIGNUMERIC), 0) AS kunde_id_,
   W2.tms_standorttyp_id AS tms_standorttyp_id_kunde,
   W2.tms_gp_typ_cd,
   BL.lagernummer_id,
    CASE
    WHEN TD.mandant_id <> 1
    THEN CASE
     WHEN RIGHT(BL.versandstelle_id, 1) = '5'
     THEN '1'
     WHEN RIGHT(BL.versandstelle_id, 1) = '7'
     THEN '2'
     ELSE RIGHT(BL.versandstelle_id, 1)
     END
    WHEN TD.mandant_id = 1
    THEN CASE
     WHEN RIGHT(BL.lagernummer_id, 1) IN ('6', '7')
     THEN '2'
     WHEN RIGHT(BL.lagernummer_id, 1) = '4'
     THEN '4'
     WHEN RIGHT(BL.lagernummer_id, 1) IN ('1', '0')
     THEN '3'
     WHEN RIGHT(BL.lagernummer_id, 1) = '3'
     THEN '1'
     WHEN RIGHT(BL.lagernummer_id, 1) = '9'
     THEN '8'
     ELSE '-1'
     END
    ELSE '-1'
    END AS artikelsortiment_id,
   COALESCE(ttd.kd_exist, 0) AS kd_exist,
   SUM(t23.menge_handling_kolli) AS menge_lief_ist_kolli,
   SUM(HU.brtvol_ladung_gedeckelt) AS brtvol_ladung_gedeckelt,
   SUM(CASE
     WHEN HU.versandeinheit_id IN (1, -1)
     THEN HU.anzahl_stellplatz
     ELSE 0
     END) AS anzahl_stellplatz,
   SUM(HU.menge_gefahrgut) AS menge_gefahrgut,
   SUM(HU.brtgew_ladung) AS brtgew_ladung
  FROM kfl_production_dbp_view.v_tour AS T0
   LEFT JOIN kfl_production_dbp_view.v_l_auslastungsgrund AS AGR ON T0.mandant_id = AGR.mandant_id AND T0.auslastungsgrund_id
      = AGR.auslastungsgrund_id
   INNER JOIN kfl_production_dbp_view.v_tms_tour AS TT ON T0.mandant_id = TT.mandant_id AND T0.tour_id = ROUND(SAFE_CAST(RIGHT(TT
          .transportation_unit_id_ext, LENGTH(TRIM(TT.transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0) AND T0.dat_tour
       = TT.dat_tour AND LEFT(TT.transportation_unit_id_ext, 3) = 'SAP'
   INNER JOIN kfl_production_dbp_view.v_tour_det AS TD ON T0.mandant_id = TD.mandant_id AND T0.tour_id = TD.tour_id AND
      T0.wup_id = TD.wup_id AND TD.loesch_fg = 0
   INNER JOIN (SELECT mandant_id,
     kj,
     lief_beleg_id,
     SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli
    FROM kfl_production_dbp_view.v_besch_lief_det
    WHERE kj BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 2 AND (EXTRACT(YEAR FROM CURRENT_DATE) + 1)
    GROUP BY mandant_id,
     lief_beleg_id,
     kj) AS t18 ON TD.mandant_id = t18.mandant_id AND TD.lief_beleg_id = t18.lief_beleg_id AND TD.kj_lief_beleg = t18.kj
     
   INNER JOIN kfl_production_dbp_view.v_besch_lief AS BL ON t18.mandant_id = BL.mandant_id AND t18.lief_beleg_id = BL.lief_beleg_id
       AND t18.kj = BL.kj
   LEFT JOIN kfl_production_dbp_view.v_wup AS W10 ON BL.mandant_id = W10.mandant_id AND ROUND(SAFE_CAST(BL.kunde_id AS
        BIGNUMERIC), 0) = W10.wup_id AND W10.nb_id = -111
   LEFT JOIN kfl_production_dbp_view.v_tms_gp AS W2 ON BL.mandant_id = W2.mandant_id AND ROUND(SAFE_CAST(BL.kunde_id AS
         BIGNUMERIC), 0) = ROUND(SAFE_CAST(W2.tms_gp_id AS BIGNUMERIC), 0) AND CASE
       WHEN COALESCE(W10.nb_id, 0) = 0
       THEN '0'
       ELSE W2.tms_gp_typ_cd
       END = W2.tms_gp_typ_cd AND TT.system_id = W2.system_id
   LEFT JOIN (SELECT mandant_id,
     system_id,
     tms_tour_id,
     dat_tour,
     lieferkunde_tms_gp_id,
     1 AS kd_exist
    FROM kfl_production_dbp_view.v_tms_tour_det
    GROUP BY mandant_id,
     system_id,
     tms_tour_id,
     dat_tour,
     lieferkunde_tms_gp_id) AS ttd ON TT.mandant_id = ttd.mandant_id AND W2.system_id = ttd.system_id AND TT.tms_tour_id
        = ttd.tms_tour_id AND TT.dat_tour = ttd.dat_tour AND ROUND(SAFE_CAST(BL.kunde_id AS BIGNUMERIC), 0) = ROUND(SAFE_CAST(ttd
       .lieferkunde_tms_gp_id AS BIGNUMERIC), 0)
   INNER JOIN (SELECT mandant_id,
     wup_id,
     handling_unit_id,
     kj_lief_beleg,
     lief_beleg_id,
     SUM(menge_handling_kolli) AS menge_handling_kolli
    FROM kfl_production_dbp_view.v_handling_unit_det
    WHERE kj_lief_beleg BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 2 AND (EXTRACT(YEAR FROM CURRENT_DATE) + 1)
    GROUP BY mandant_id,
     wup_id,
     handling_unit_id,
     lief_beleg_id,
     kj_lief_beleg) AS t23 ON t18.mandant_id = t23.mandant_id AND t18.lief_beleg_id = t23.lief_beleg_id AND t18.kj = t23
      .kj_lief_beleg AND T0.wup_id = t23.wup_id
   INNER JOIN kfl_production_dbp_view.v_handling_unit AS HU ON t23.mandant_id = HU.mandant_id AND t23.handling_unit_id =
       HU.handling_unit_id AND t23.wup_id = HU.wup_id AND t23.kj_lief_beleg = HU.kj_lief_beleg
   INNER JOIN kfl_production_dbp_view.v_tag AS TAG ON T0.dat_tour = TAG.dat AND TAG.akt_kj BETWEEN -2 AND 0
   INNER JOIN (SELECT mandant_id,
     wup_id,
     MIN(COALESCE(dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
    FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm
    GROUP BY mandant_id,
     wup_id) AS dw ON T0.mandant_id = dw.mandant_id AND T0.wup_id = dw.wup_id AND T0.dat_tour >= dw.dat_wanko_von
   INNER JOIN (SELECT mandant_id,
     wup_id,
     lagernummer_id,
     MIN(COALESCE(dat, DATE '9999-12-31')) AS dat_ewm_von
    FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat
    GROUP BY mandant_id,
     wup_id,
     lagernummer_id) AS ewm ON T0.mandant_id = ewm.mandant_id AND T0.wup_id = ewm.wup_id AND T0.dat_tour < ewm.dat_ewm_von
       AND BL.lagernummer_id = ewm.lagernummer_id
  GROUP BY TD.mandant_id,
   W2.system_id,
   transportation_unit_id,
   T0.dat_tour,
   AGR.sap_auslastungsgrund,
   kunde_id_,
   tms_standorttyp_id_kunde,
   W2.tms_gp_typ_cd,
   BL.lagernummer_id,
   artikelsortiment_id,
   kd_exist) AS wa_les ON TMS_TOUR.mandant_id = wa_les.mandant_id AND TMS_TOUR.system_id = wa_les.system_id AND ROUND(SAFE_CAST(RIGHT(TMS_TOUR
         .transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0) = wa_les
      .transportation_unit_id AND TMS_TOUR.dat_tour = wa_les.dat_tour AND CASE
     WHEN TMS_TOUR.tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> TMS_DISPO.bestand_tms_gp_id AND
         tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa_les.kd_exist = 0 OR TMS_TOUR.tms_tourart_detail_id = 6 AND
         wa_les.tms_standorttyp_id_kunde IN (1, 2) AND W.nb_id = -111
     THEN 1
     ELSE ROUND(SAFE_CAST(REPLACE(TRANSLATE(tms_tour_d.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS
       BIGNUMERIC), 0)
     END = CASE
     WHEN TMS_TOUR.tms_tourart_detail_id = 2 AND tms_tour_d.lieferkunde_tms_gp_id <> TMS_DISPO.bestand_tms_gp_id AND
         tms_tour_d.lieferkunde_tms_gp_typ_cd = 'L' AND wa_les.kd_exist = 0 OR TMS_TOUR.tms_tourart_detail_id = 6 AND
         wa_les.tms_standorttyp_id_kunde IN (1, 2) AND W.nb_id = -111
     THEN 1
     ELSE wa_les.kunde_id_
     END AND CASE
    WHEN TMS_TOUR.tms_tourart_detail_id IN (1, 2) AND wa_les.kd_exist = 1
    THEN tms_tour_d.lieferkunde_tms_gp_typ_cd
    ELSE '0'
    END = CASE
    WHEN TMS_TOUR.tms_tourart_detail_id IN (1, 2) AND wa_les.kd_exist = 1
    THEN wa_les.tms_gp_typ_cd
    ELSE '0'
    END
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kosten AS TU_K ON TMS_TOUR.mandant_id = TU_K.mandant_id AND CAST(TMS_DISPO.bestand_tms_gp_id AS FLOAT64)
     = TU_K.wup_id AND TU_K.transportation_unit_id = COALESCE(t6.transportation_unit_id, wa_les.transportation_unit_id,
     ROUND(SAFE_CAST(FORMAT_DATE('%Y%m%d', TMS_TOUR.dat_tour) || CAST(TMS_TOUR.tms_tour_id AS STRING) AS BIGNUMERIC), 0
      )) AND CASE
    WHEN t6.kj_transportation_unit IS NOT NULL
    THEN t6.kj_transportation_unit
    ELSE 1
    END = CASE
    WHEN t6.kj_transportation_unit IS NOT NULL
    THEN TU_K.kj_transportation_unit
    ELSE 1
    END
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per AS TS_WUP_K ON TMS_TOUR.spedition_tms_gp_id =
     TS_WUP_K.tms_gp_id AND TMS_TOUR.mandant_id = TS_WUP_K.mandant_id AND CAST(TMS_DISPO.bestand_tms_gp_id AS FLOAT64) =
    TS_WUP_K.wup_id AND TMS_TOUR.dat_tour BETWEEN TS_WUP_K.dat_von AND TS_WUP_K.dat_bis
 LEFT JOIN (SELECT L_T.mandant_id,
   L_T.tour_id,
   MIN(EXTRACT(YEAR FROM L_T.dat_buch)) AS kj
  FROM kfl_production_dbp_view.v_rueckfuehrung_lt AS L_T
   INNER JOIN kfl_production_dbp_view.v_tag AS T1 ON L_T.dat_buch = T1.dat
  WHERE T1.akt_kj >= -2
  GROUP BY L_T.mandant_id,
   L_T.tour_id) AS rf ON COALESCE(t6.transportation_unit_id, wa_les.transportation_unit_id) = rf.tour_id AND TMS_TOUR.mandant_id
     = rf.mandant_id AND EXTRACT(YEAR FROM TMS_TOUR.dat_tour) = rf.kj
WHERE S.system_gruppe = 'WANKO TMS';


