CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TRANSPORTATION_UNIT_KOSTEN_UPLOAD_1(
MANDANT_ID,
BELOS_ADRESSE_ABSENDER_NUM_ID,
BELOS_ADRESSE_EMPFAENGER_ID,
BELOS_ADRESSE_EMPFAENGER_NUM_ID,
BELOS_ADRESSE_SPEDITION_ID,
TMS,
TDL_ID,
TRANSPORTATION_UNIT_ID,
KJ_TRANSPORTATION_UNIT,
BELOS_VORGANG_ID,
LAGERNUMMER_ID,
DAT_TOUR,
KOSTEN_UPLOAD_FG,
KOSTEN_UPLOAD_FG_BEZ,
TU_COSTS_INCOMPLETE_FG
) AS
--2024-06-26, dknop, AP0226503, SPEC0255672, initial
--2024-08-13, SNIK1809, Updated CASE for tu_costs_incomplete_fg
--2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit_1 duplication
--2024-10-22, AP0210954_SPEC0239355, dknop, also display TDL for WANKO Tours
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-26, nwag, branch to limit on >= 2023 as an interim solution
--2025-01-22, INC10130607, nwag, add a UNION to fix shuttle tours
SELECT 
bv.mandant_id
,bv.belos_adresse_absender_num_id
,COALESCE (CAST(aktuell_wup_id AS VARCHAR), bv.belos_adresse_empfaenger_id) AS belos_adresse_empfaenger_id
,COALESCE(CASE WHEN TRY_CAST(bv.belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END, TRY_CAST(LEFT(bv.belos_adresse_empfaenger_id,4) AS NUMBER(38,0)))  AS belos_adresse_empfaenger_id_num
,bv.belos_adresse_spedition_id --not used
,CASE WHEN t_a.dat_tour >= b_w_sw.dat_tms_wanko THEN 'WANKO' ELSE 'BELOS' END AS tms
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (t_a.belos_adresse_spedition_id, '-1') END AS tdl_id
,bv.tour_id AS transportation_unit_id
,YEAR(bv.dat_leistung) AS KJ_TRANSPORTATION_UNIT
,bv.belos_vorgang_id
,l_lag.lagernummer_id
,t_a.dat_tour
,COALESCE(ts_wup_k.kosten_upload_fg,-1) AS kosten_upload_fg_
,CASE WHEN kosten_upload_fg_=1 THEN 'Km-basiert' 
      WHEN kosten_upload_fg_=-1 THEN 'nicht definiert / not defined'
      ELSE 'Kosten-basiert' END AS abrechnungslogik
,CASE WHEN kosten_upload_fg_=1 
  AND ZEROIFNULL(tu_k.BETRAG_DIESEL)=0
  AND ZEROIFNULL(tu_k.BETRAG_STROM)=0
 AND ZEROIFNULL(tu_k.BETRAG_GAS)=0
  AND ZEROIFNULL(tu_k.BETRAG_MAUT)=0
  AND ZEROIFNULL(tu_k.BETRAG_KUEHLUNG)=0
  AND ZEROIFNULL(tu_k.BETRAG_SONSTIGES)=0
  THEN 1 
  ELSE 0 
 END AS tu_costs_incomplete_fg

FROM dbp_view.v_belos_vorgang_1 bv

LEFT JOIN dbp_view.v_wup_1 v02
ON v02.mandant_id = bv.mandant_id
AND v02.wup_id = CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) END
AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

LEFT JOIN dbp_view.v_transportation_unit_aktivitaet_1 t_a
ON bv.mandant_id = t_a.mandant_id
AND bv.tour_id = t_a.transportation_unit_id
AND aktivitaet_richtung_id = '2'
AND t_a.dat_tour=bv.dat_leistung


LEFT JOIN ( SELECT mandant_id, lagernummer_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM_1 WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, lagernummer_id ) b_w_sw
            ON b_w_sw.mandant_id = t_a.mandant_id
            AND b_w_sw.lagernummer_id = t_a.lagernummer_id

LEFT JOIN (
SELECT DISTINCT t.mandant_id , tu.transportation_unit_id, t.dat_tour, CASE WHEN t.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg, t.spedition_tms_gp_id, t.TEMPERATURGRUPPE_ID, t.tms_tourtyp_id
,t.tms_tourart_id
FROM dbp_data.tms_tour_1 t
JOIN dbp_view.v_tag_1 d ON d.dat = t.dat_tour AND d.akt_kj >= -2
JOIN dbp_view.v_transportation_unit_1 tu
ON t.mandant_id=tu.mandant_id
AND t.transportation_unit_id_ext=tu.transportation_unit_id_ext
) v021
ON t_a.mandant_id=v021.mandant_id
AND t_a.transportation_unit_id=v021.transportation_unit_id
AND t_a.dat_tour=v021.dat_tour

LEFT JOIN dbp_view.v_transportation_unit_kosten_1 tu_k
ON bv.mandant_id = tu_k.mandant_id
AND bv.tour_id = tu_k.transportation_unit_id
AND bv.belos_adresse_absender_num_id = tu_k.wup_id
AND YEAR(dat_leistung) = tu_k.kj_transportation_unit

LEFT JOIN dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 ts_wup_k
--ON bv.belos_adresse_spedition_id = ts_wup_k.tms_gp_id
ON  tdl_id = ts_wup_k.tms_gp_id
AND bv.mandant_id = ts_wup_k.mandant_id
AND bv.belos_adresse_absender_num_id = ts_wup_k.wup_id
AND t_a.dat_tour BETWEEN ts_wup_k.dat_von AND ts_wup_k.dat_bis

JOIN dbp_view.v_l_lagernummer_1 l_lag
ON  bv.mandant_id=l_lag.mandant_id
AND bv.lagernummer_id = LEFT(l_lag.lagernummer_id,3)

WHERE YEAR(bv.dat_leistung) >= YEAR(CURRENT_DATE)-2

UNION  --shuttletouren-dummies:

SELECT 
bv.mandant_id
,bv.belos_adresse_absender_num_id
,CAST(COALESCE(aktuell_wup_id,kd.kunde_id) AS VARCHAR)  AS belos_adresse_empfaenger_id
,COALESCE(aktuell_wup_id,kd.kunde_id) AS belos_adresse_empfaenger_id_num
,bv.belos_adresse_spedition_id --not used
,CASE WHEN t_a.dat_tour >= b_w_sw.dat_tms_wanko THEN 'WANKO' ELSE 'BELOS' END AS tms
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (t_a.belos_adresse_spedition_id, '-1') END AS tdl_id
,bv.tour_id AS transportation_unit_id
,YEAR(bv.dat_leistung) AS KJ_TRANSPORTATION_UNIT
,-1 AS belos_vorgang_id
,l_lag.lagernummer_id
,t_a.dat_tour
,COALESCE(ts_wup_k.kosten_upload_fg,-1) AS kosten_upload_fg_
,CASE WHEN kosten_upload_fg_=1 THEN 'Km-basiert' 
      WHEN kosten_upload_fg_=-1 THEN 'nicht definiert / not defined'
      ELSE 'Kosten-basiert' END AS abrechnungslogik
,CASE WHEN kosten_upload_fg_=1 
AND ZEROIFNULL(tu_k.BETRAG_DIESEL)=0
 AND ZEROIFNULL(tu_k.BETRAG_STROM)=0
 AND ZEROIFNULL(tu_k.BETRAG_GAS)=0
AND ZEROIFNULL(tu_k.BETRAG_MAUT)=0
 AND ZEROIFNULL(tu_k.BETRAG_KUEHLUNG)=0
 AND ZEROIFNULL(tu_k.BETRAG_SONSTIGES)=0
 THEN 1 
 ELSE 0 
 END AS tu_costs_incomplete_fg

FROM dbp_view.v_belos_vorgang_1 bv

LEFT JOIN (SELECT mandant_id, transportation_unit_id, dat_tour, kunde_id FROM dbp_view.v_besch_lief_wa_hu_sum_1 WHERE YEAR(DAT_TOUR) >= YEAR(CURRENT_DATE)-2 GROUP BY  mandant_id, transportation_unit_id, dat_tour, kunde_id ) kd ON bv.tour_id=kd.transportation_unit_id AND bv.mandant_id=kd.mandant_id AND bv.dat_leistung=kd.dat_tour

LEFT JOIN dbp_view.v_wup_1 v02
ON v02.mandant_id = bv.mandant_id
AND v02.wup_id = kd.kunde_id
AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

LEFT JOIN dbp_view.v_transportation_unit_aktivitaet_1 t_a
ON bv.mandant_id = t_a.mandant_id
AND bv.tour_id = t_a.transportation_unit_id
AND aktivitaet_richtung_id = '2'
AND t_a.dat_tour=bv.dat_leistung


LEFT JOIN ( SELECT mandant_id, lagernummer_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM_1 WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, lagernummer_id ) b_w_sw
            ON b_w_sw.mandant_id = t_a.mandant_id
            AND b_w_sw.lagernummer_id = t_a.lagernummer_id

LEFT JOIN (
SELECT DISTINCT t.mandant_id , tu.transportation_unit_id, t.dat_tour, CASE WHEN t.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg, t.spedition_tms_gp_id, t.TEMPERATURGRUPPE_ID, t.tms_tourtyp_id
,t.tms_tourart_id, t.tms_tourart_detail_id
FROM dbp_data.tms_tour_1 t
JOIN dbp_view.v_tag_1 d ON d.dat = t.dat_tour AND d.akt_kj >= -2
JOIN dbp_view.v_transportation_unit_1 tu
ON t.mandant_id=tu.mandant_id
AND t.transportation_unit_id_ext=tu.transportation_unit_id_ext
) v021
ON t_a.mandant_id=v021.mandant_id
AND t_a.transportation_unit_id=v021.transportation_unit_id
AND t_a.dat_tour=v021.dat_tour

LEFT JOIN dbp_view.v_transportation_unit_kosten_1 tu_k
ON bv.mandant_id = tu_k.mandant_id
AND bv.tour_id = tu_k.transportation_unit_id
AND bv.belos_adresse_absender_num_id = tu_k.wup_id
AND YEAR(dat_leistung) = tu_k.kj_transportation_unit

LEFT JOIN dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 ts_wup_k
--ON bv.belos_adresse_spedition_id = ts_wup_k.tms_gp_id
ON  tdl_id = ts_wup_k.tms_gp_id
AND bv.mandant_id = ts_wup_k.mandant_id
AND bv.belos_adresse_absender_num_id = ts_wup_k.wup_id
AND t_a.dat_tour BETWEEN ts_wup_k.dat_von AND ts_wup_k.dat_bis

JOIN dbp_view.v_l_lagernummer_1 l_lag
ON  bv.mandant_id=l_lag.mandant_id
AND bv.lagernummer_id = LEFT(l_lag.lagernummer_id,3)

WHERE tms_tourart_detail_id=2 OR t_a.belos_tourart_id=2
AND YEAR(bv.dat_leistung) >= YEAR(CURRENT_DATE)-2;