CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_NACHLAUFPALETTEN(
    MANDANT_ID,
    WUP_ID,
    DAT_TOUR,
    TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
    DAT_LIEF_SOLL,
    LIEF_PAL_TYP_ID,
    LIEF_BELEG_ID,
    MANDANT_ID_KUNDE,
    KUNDE_ID,
    HANDLING_UNIT_ID,
    HANDLING_UNIT_ID_EXT,
    LIEF_TYP_ID,
    LAGERSORTIMENT_ID,
    ARTIKELSORTIMENT_ID,
    HU_AUFGEPACKT,
    WERBEWARE_ID,
    LAGERNUMMER_ID,
    TMS,
    BELOS_SONDERABWICKLUNG_ID,
    tour_service_id,
    BELOS_TOURART_ID,
    TOURART_ID,
    ANZAHL_STELLPLATZ_EWM,
    ANZAHL_STELLPLATZ_EWM_EXT_PARENT,
    ABWEICHUNG_IN_TAGEN,
    ABWEICHUNG_IN_TAGEN_BEREINIGT,
    MENGE_LIEF_IST_KOLLI_HU,
    BRTVOL_HU_GEDECKELT_OA,
    BRTGEW_HU_OA,
    VOL_RELEVANT_FG,
    DISTRIBUTION_ABR_FG,
    VERSANDSTELLE_ID,
    TRANSPORTSORTIMENT_ID
) AS
--2022-04-11, AP0128641_SPEC0151348, dknop, initial
--2023-05-23, dknop adding filter lief_typ_id in ('YM','YU','YNOT','NL','ZLFI','ZLCC','YCD2','ZDD') to bl_bereinigt
--2023-11-24, dknop, adding hu_s.versandstelle_id
--2024-05-15, dknop, adding transportsortiment_id
--2024-07-22,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-28, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit duplication
--2024-10-07, nwag, limiting to dat_lief_soll >= 01.01.2022 also because of transportation_unit duplication
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-25, nwag, add TMS columns
--2025-02-25, nwag, diff only if a HU was actually delivered
--2025-04-17, dknop, adding brtgew_hu_oa 
--2025-08-01, nwag, merging changes to restore TMS columns
SELECT
 hu_s.mandant_id 
,hu_s.wup_id
,t_unit.dat_tour
,hu_s.transportation_unit_id
,t_unit.KJ_TRANSPORTATION_UNIT
,hu_s.dat_lief_soll
,hu_s.lief_pal_typ_id
,hu_s.lief_beleg_id
,hu_s.mandant_id_kunde
--,CASE WHEN TRY_CAST(hu_s.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id_
,aktuell_wup_id AS kunde_id
--,hu_s.kunde_id
,hu_s.handling_unit_id
,hu_s.handling_unit_id_ext
,hu_s.lief_typ_id
,hu_s.lagersortiment_id
,CASE WHEN LEFT(RIGHT(hu_s.VERSANDSTELLE_ID,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(hu_s.VERSANDSTELLE_ID,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(hu_s.VERSANDSTELLE_ID,2),1) END AS artikelsortiment_id
,CASE WHEN hu_s.handling_unit_id_parent <>0 THEN 1 ELSE 0 END AS hu_aufgepackt
,hu_s.werbeware_id
,hu_s.lagernummer_id
,CASE WHEN t_unit.dat_tour >= b_w_sw.dat_tms_wanko THEN 'WANKO' ELSE 'BELOS' END AS tms
,t_unit.belos_sonderabwicklung_id
,CASE WHEN tms = 'WANKO' THEN tms.tour_service 
      WHEN t_unit.belos_sonderabwicklung_id = 'TK' THEN 'TIKO'
      WHEN t_unit.belos_sonderabwicklung_id = 'GK' THEN 'GK'
      WHEN t_unit.belos_sonderabwicklung_id = 'TE' THEN 'TG'
      WHEN t_unit.belos_sonderabwicklung_id = 'UK' THEN 'UGK'
 ELSE '-1' END AS tour_service_id
,t_unit.belos_tourart_id
,CASE WHEN tms = 'WANKO' THEN COALESCE(tms.TMS_TOURART_DETAIL_ID, '-1') ELSE COALESCE (t_unit.belos_tourart_id, '-1') END AS tourart_id  
,hu_s.anzahl_stellplatz_ewm
,hu_s.anzahl_stellplatz_ewm_ext_parent
,t_unit.dat_tour - hu_s.dat_lief_soll AS abweichung_in_tagen
,SUM(CASE WHEN t_unit.dat_tour < bl_bereinigt.dat_lief_soll THEN -1
          WHEN t_unit.dat_tour > bl_bereinigt.dat_lief_soll THEN 1
          WHEN t_unit.dat_tour = bl_bereinigt.dat_lief_soll THEN 0
          END)  AS abweichung_in_tagen_bereinigt
,MAX(hu_s.menge_lief_ist_kolli_hu) AS menge_lief_ist_kolli_hu
,MAX(hu_s.brtvol_hu_gedeckelt_oa) AS brtvol_hu_gedeckelt_oa
,MAX(hu_s.brtgew_hu_oa) AS brtgew_hu_oa
,hu_s.vol_relevant_fg
,CASE WHEN tms = 'WANKO' THEN COALESCE(tms.distribution_abr_fg,1) ELSE COALESCE (bv.distribution_abr_fg, 1) END AS distribution_abr_fg_
,hu_s.versandstelle_id
,hu_s.transportsortiment_id

FROM dbp_view.v_besch_lief_wa_hu_sum hu_s

INNER JOIN dbp_view.v_wup w
   ON w.mandant_id = CASE WHEN hu_s.mandant_id_kunde IS NULL OR hu_s.mandant_id_kunde = 0 THEN hu_s.mandant_id ELSE hu_s.mandant_id_kunde END
   --AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND w.wup_id = hu_s.kunde_id
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))


JOIN dbp_view.v_transportation_unit_aktivitaet t_unit
ON  t_unit.aktivitaet_richtung_id = '2'
AND hu_s.handling_unit_id > 0
AND t_unit.mandant_id = hu_s.mandant_id
AND t_unit.transportation_unit_id = hu_s.transportation_unit_id
AND t_unit.dat_tour = hu_s.dat_tour

-- if there's any delivery for this store on a given date, this is considered an normal day (not sunday/holiday)
 JOIN (
   SELECT mandant_id_kunde
         ,kunde_id
         ,dat_lief_soll
   FROM dbp_view.v_besch_lief_wa_hu_sum
  --new: only consider relevant deliveries (e.g. no store returns to DC):
WHERE lief_typ_id IN ('YM','YU','YNOT','NL','ZLFI','ZLCC','YCD2','ZDD')
    AND handling_unit_id > 0
   GROUP BY mandant_id_kunde
,kunde_id
,dat_lief_soll
) bl_bereinigt

ON hu_s.mandant_id_kunde = bl_bereinigt.mandant_id_kunde
AND hu_s.kunde_id = TRY_CAST(bl_bereinigt.kunde_id AS INT)
AND (bl_bereinigt.dat_lief_soll BETWEEN t_unit.dat_tour AND hu_s.dat_lief_soll -- Lieferdatum nach Tourdatum
OR bl_bereinigt.dat_lief_soll BETWEEN hu_s.dat_lief_soll AND t_unit.dat_tour) -- Lieferdatum vor Tourdatum

LEFT JOIN ( SELECT mandant_id, lagernummer_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, lagernummer_id ) b_w_sw
            ON b_w_sw.mandant_id = t_unit.mandant_id
            AND b_w_sw.lagernummer_id = t_unit.lagernummer_id


LEFT JOIN (SELECT t.mandant_id , tu.transportation_unit_id, t.dat_tour, CASE WHEN t.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg, 
            CASE WHEN sortiment_temperaturgruppe_id = 1 THEN 'TK'
                 WHEN sortiment_temperaturgruppe_id = 2 THEN 'GK'
                 WHEN sortiment_temperaturgruppe_id = 3 THEN 'TE' ELSE 'UK' END AS tour_service, TMS_TOURART_DETAIL_ID
            FROM dbp_data.tms_tour t
            JOIN dbp_view.v_transportation_unit tu
            ON t.mandant_id=tu.mandant_id
            AND t.transportation_unit_id_ext=tu.transportation_unit_id_ext
            WHERE YEAR(t.dat_tour) >= YEAR(CURRENT_DATE)-2
            GROUP BY t.mandant_id , tu.transportation_unit_id, t.dat_tour, tour_service, TMS_TOURART_DETAIL_ID,distribution_abr_fg
            ) tms
ON t_unit.mandant_id=tms.mandant_id
AND t_unit.transportation_unit_id=tms.transportation_unit_id 
AND t_unit.dat_tour=tms.dat_tour

LEFT JOIN (SELECT 
            mandant_id
           ,tour_id 
           ,dat_leistung
           ,MAX(distribution_abr_fg) AS distribution_abr_fg
           FROM dbp_view.v_belos_vorgang
           GROUP BY
            mandant_id
           ,tour_id, dat_leistung
          ) bv
 ON t_unit.mandant_id=bv.mandant_id
AND t_unit.transportation_unit_id=bv.tour_id
AND t_unit.dat_tour=dat_leistung

WHERE t_unit.kj_transportation_unit >= YEAR(CURRENT_DATE) -2  
--t_unit.dat_tour >= '2022-01-01' AND hu_s.dat_lief_soll >= '2022-01-01'

GROUP BY hu_s.mandant_id
,hu_s.wup_id
,t_unit.dat_tour
,hu_s.transportation_unit_id
,t_unit.kj_transportation_unit
,hu_s.dat_lief_soll
,hu_s.lief_pal_typ_id
,hu_s.lief_beleg_id
,hu_s.mandant_id_kunde
,w.aktuell_wup_id
,hu_s.handling_unit_id
,hu_s.handling_unit_id_ext
,hu_s.lief_typ_id
,hu_s.werbeware_id
,hu_s.lagernummer_id
,hu_s.versandstelle_id
,hu_s.lagersortiment_id
,t_unit.belos_sonderabwicklung_id
,t_unit.belos_tourart_id
,hu_s.anzahl_stellplatz_ewm
,hu_s.anzahl_stellplatz_ewm_ext_parent
,hu_s.vol_relevant_fg
,abweichung_in_tagen
,hu_aufgepackt
,distribution_abr_fg_
,tms
,hu_s.transportsortiment_id
,tour_service_id
,tourart_id;

