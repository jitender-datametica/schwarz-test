create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_DT_TRANSPORTATION_UNIT_AKTIVITAET_2(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
	TRANSPORTATION_UNIT_ID_SR_ACT_ID,
	KJ_TRANSPORTATION_UNIT,
	DAT_TOUR,
	TMS,
	LAGERNUMMER_ID,
	DATZEIT_START_PLAN,
	DATZEIT_START_IST,
	DATZEIT_ENDE_PLAN,
	DATZEIT_ENDE_IST,
	NUTZUNG_GRUND_ID,
	PUNKTLICHKEIT_ANKUNFT_VZ,
	PUNKTLICHKEIT_ABFAHRT_VZ,
	AKTIVITAET_RICHTUNG_ID,
	BELOS_TOURSTATUS_ID,
	BELOS_TOURART_ID,
	BELOS_TOURART_SUBTYP_ID,
	BELOS_SONDERABWICKLUNG_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	TDL_ID,
	TOUR_SERVICES_ID,
	TOURART_ID,
	MENGE_GEFAHRGUT,
	RUNDLAUF_TRANSPORT_FG,
	FLEISCHWERK_FG,
	DISTRIBUTION_ABR_FG
) target_lag = '30 minutes' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
--05.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_2
--21.09.2021, SPEC0091861, AP0073899, dknop, adding nutzung_grund_id,
--27.10.2021, SPEC0091861, AP0073899, dknop, filter aktivitaet_richtung_id = 2 
--03.12.2021, SPEC0091861, AP0073899, dknop, adding belos_tourstatus_id, belos_tourart_id, belos_sonderabwicklung_id, belos_adresse_spedition_id
--06.12.2021, SPEC0091861, AP0073899, dknop, adding workaround for fleischwerk_fg, rundlauf_transport_fg, data typ change for aktivitaet_richtung_id
--14.12.2021, SPEC0091861, AP0073899, dknop, adding belos_tourart_subtyp_id
--01.02.2022, INC4197408, adding DISTRIBUTION_ABR_FG
--16.02.2022, AP0081642_SPEC0140470, dknop adding datzeit_start_plan,datzeit_start_ist,datzeit_ende_plan, datzeit_ende_ist, punktlichkeit_ankunft_VZ, punktlichkeit_abfahrt_VZ
--2022-02-22, AP0081642, SPEC0140470, dknop, adding lagernummer_id
--2022-03-08, AP0081642, SPEC0140470, dknop, adding TO_TIMESTAMP, change from minute to second in TIMESTAMPDIFF
--2022-08-11, AP0137779, SPEC0164467, adding -1 to punktlichkeit_ankunft_VZ, punktlichkeit_abfahrt_VZ
--2023-03-16, dknop, updating logic for belos_tourart_subtyp_id
--2023-07-21, dknop, setting colaesce for lagernummer to -1
--2023-07-28, dknop, updating definition of lagernummmer_id
--2023-08-04, dknop, updating definition of lagernummmer_id
--2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit_2 duplication
--2024-10-09, nwag, limiting to dat_leistung >= 01.01.2022 because of transportation_unit_2 duplication + lagernummer from tunit (now populated)
--2024-10-29, adding TMS, TDL_ID,TOUR_SERVICES_ID,TOURART_ID
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-26, nwag, branch to limit on >= 2023 as an interim solution
--2025-01-30, nwag, using -1 in belos_tourstatus to make tours managed by WANKO disappear from BELOS reports even though they're_2 still provided from BELOS, too
--2025-03-17, nwag, switch to DT
--2025-05-12, nwag, TZ correction RO/BG
--2025-07-02, dknop, adding transportation_unit_sr_act_id
--2025-09-18, nwag, tms_tourart_detail_id
--2025-09-19, nwag, INC11675222
--2025-11-06, dknop, INC12005128, temperaturgruppe_id/tour_service_id definition update
SELECT
v01.mandant_id
,v01.transportation_unit_id
,v01.transportation_unit_sr_act_id 
,v01.KJ_TRANSPORTATION_UNIT
,v01.dat_tour
,CASE WHEN v01.dat_tour >= b_w_sw.dat_tms_wanko THEN 'WANKO' ELSE 'BELOS' END AS tms
--,COALESCE(CASE WHEN v03.lagernummer_id='' THEN NULL ELSE v03.lagernummer_id END,'-1') AS lagernummer_id
,COALESCE(CASE WHEN v01.lagernummer_id='' THEN NULL ELSE v01.lagernummer_id END,COALESCE(v02.lagernummer_id,'-1')) AS lagernummer_id
,CASE WHEN v01.mandant_id IN (7,8) THEN TIMESTAMPADD(HOUR,1,TO_TIMESTAMP(v01.datzeit_start_plan)) ELSE TO_TIMESTAMP(v01.datzeit_start_plan) END 
,CASE WHEN v01.mandant_id IN (7,8) THEN TIMESTAMPADD(HOUR,1,TO_TIMESTAMP(v01.datzeit_start_ist)) ELSE TO_TIMESTAMP(v01.datzeit_start_ist) END 
,CASE WHEN v01.mandant_id IN (7,8) THEN TIMESTAMPADD(HOUR,1,TO_TIMESTAMP(v01.datzeit_ende_plan)) ELSE TO_TIMESTAMP(v01.datzeit_ende_plan) END 
,CASE WHEN v01.mandant_id IN (7,8) THEN TIMESTAMPADD(HOUR,1,TO_TIMESTAMP(v01.datzeit_ende_ist)) ELSE TO_TIMESTAMP(v01.datzeit_ende_ist) END 
,v01.nutzung_grund_id
,CASE WHEN TIMESTAMPDIFF('second',v01.datzeit_start_ist,v01.datzeit_start_plan)>=0 THEN 1
      WHEN TIMESTAMPDIFF('second',v01.datzeit_start_ist,v01.datzeit_start_plan) IS NULL THEN -1 
      ELSE 0 END AS punktlichkeit_ankunft_VZ
,CASE WHEN TIMESTAMPDIFF('second',v01.datzeit_ende_ist,v01.datzeit_ende_plan)>=0 THEN 1
      WHEN TIMESTAMPDIFF('second',v01.datzeit_ende_ist,v01.datzeit_ende_plan) IS NULL THEN -1 
      ELSE 0 END AS punktlichkeit_abfahrt_VZ
,v01.aktivitaet_richtung_id 
,CASE WHEN tms = 'WANKO' THEN '-1' ELSE COALESCE(v01.belos_tourstatus_id,'-1') END AS belos_tourstatus_id
,COALESCE(v01.belos_tourart_id,v021.tms_tourart_detail_id,'-1') AS belos_tourart_id
,CASE WHEN v04.spedition_fg = '-1' THEN '17' ELSE COALESCE(v01.belos_tourart_subtyp,'-1') END AS belos_tourart_subtyp_id
--legacy:
,COALESCE (v01.belos_sonderabwicklung_id,'-1') AS belos_sonderabwicklung_id
--,COALESCE (v01.belos_adresse_spedition_id, v021.spedition_tms_gp_id, '-1') AS belos_adresse_spedition_id
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (v01.belos_adresse_spedition_id, '-1') END AS belos_adresse_spedition_id
--new:
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.spedition_tms_gp_id, '-1') ELSE COALESCE (v01.belos_adresse_spedition_id, '-1') END AS tdl_id
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.TEMPERATURGRUPPE_ID, v01.belos_sonderabwicklung_id, '-1') ELSE COALESCE (v01.belos_sonderabwicklung_id, '-1') END AS tour_service_id
--tms tourart test_2:
,CASE WHEN tms = 'WANKO' THEN COALESCE(v021.tms_tourart_detail_id, '-1') ELSE COALESCE (v01.belos_tourart_id, '-1') END AS tourart_id
,SUM(v01.menge_gefahrgut) AS menge_gefahrgut
,COALESCE(CASE WHEN v02.industrie_abh_fg=1 THEN 10 ELSE v02.rundlauf_transport_fg END, -1) AS rundlauf_transport_fg
,COALESCE(v02.fleischwerk_fg, '-1') AS fleischwerk_fg
,COALESCE(v02.distribution_abr_fg,v021.distribution_abr_fg,'1') AS distribution_abr_fg
FROM dbp_view.v_transportation_unit_aktivitaet_2 v01

LEFT JOIN ( SELECT mandant_id, lagernummer_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM dbp_msi_data.ts_lagernummer_sortierung_scm_2 WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, lagernummer_id ) b_w_sw
            ON b_w_sw.mandant_id = v01.mandant_id
            AND b_w_sw.lagernummer_id = v01.lagernummer_id

LEFT JOIN (SELECT 
            bv.mandant_id
           ,bv.tour_id 
           ,bv.dat_leistung
           ,MAX(CASE WHEN lgn.lagernummer_id = '' THEN '-1' ELSE lgn.lagernummer_id END) AS lagernummer_id
           ,MAX(industrie_abh_fg) AS industrie_abh_fg
           ,MAX(fleischwerk_fg) AS fleischwerk_fg
           ,MAX(rundlauf_transport_fg) AS rundlauf_transport_fg
           ,MAX(distribution_abr_fg) AS distribution_abr_fg
           FROM dbp_view.v_belos_vorgang_2 bv
           LEFT JOIN dbp_view.v_l_lagernummer_2 lgn
            ON  bv.mandant_id=lgn.mandant_id
            AND bv.lagernummer_id = LEFT(lgn.lagernummer_id,3)
        WHERE bv.dat_leistung >= '2023-01-01'
           GROUP BY
            bv.mandant_id
           ,bv.tour_id
           ,bv.dat_leistung
          ) v02
ON v01.mandant_id=v02.mandant_id
AND v01.transportation_unit_id=v02.tour_id
AND v01.dat_tour=v02.dat_leistung
--AND v01.lagernummer_id=v02.lagernummer_id
LEFT JOIN (
SELECT DISTINCT t.mandant_id , tu.transportation_unit_id, t.dat_tour, CASE WHEN t.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg, t.spedition_tms_gp_id, CASE WHEN sortiment_temperaturgruppe_id = 1 THEN 'TK'
WHEN sortiment_temperaturgruppe_id = 2 THEN 'GK'
WHEN sortiment_temperaturgruppe_id = 3 THEN 'TE' ELSE 'UK' END AS temperaturgruppe_id, t.tms_tourtyp_id
,t.tms_tourart_detail_id
FROM dbp_data.tms_tour_2 t
JOIN dbp_view.v_transportation_unit_2 tu
ON t.mandant_id=tu.mandant_id
AND t.transportation_unit_id_ext=tu.transportation_unit_id_ext
) v021
ON v01.mandant_id=v021.mandant_id
AND v01.transportation_unit_id=v021.transportation_unit_id
AND v01.dat_tour=v021.dat_tour

LEFT JOIN dbp_view.v_belos_adresse_2 v04
ON v01.belos_adresse_absender_num_id = v04.belos_adresse_num_id 
AND v01.mandant_id = v04.mandant_id

WHERE YEAR(v01.dat_tour) >= YEAR(CURRENT_DATE) -2

GROUP BY v01.mandant_id
,v01.transportation_unit_id
,v01.transportation_unit_sr_act_id 
,v01.KJ_TRANSPORTATION_UNIT
,v01.dat_tour
,v01.nutzung_grund_id
,v01.belos_tourstatus_id
,v01.belos_tourart_id
,v01.belos_sonderabwicklung_id
,v02.rundlauf_transport_fg
,v02.fleischwerk_fg
,v02.industrie_abh_fg
,COALESCE(v02.distribution_abr_fg,v021.distribution_abr_fg,'1')
,v01.lagernummer_id
,v02.lagernummer_id
,v01.belos_adresse_spedition_id
,v01.aktivitaet_richtung_id 
,v01.belos_tourart_subtyp
,v01.datzeit_start_plan
,v01.datzeit_start_ist
,v01.datzeit_ende_plan
,v01.datzeit_ende_ist
,v01.nutzung_grund_id
,v04.spedition_fg
,punktlichkeit_ankunft_VZ
,punktlichkeit_ankunft_VZ
,b_w_sw.dat_tms_wanko
,V021.SPEDITION_TMS_GP_ID
,V021.TEMPERATURGRUPPE_ID
,V021.TMS_TOURART_DETAIL_ID
;
