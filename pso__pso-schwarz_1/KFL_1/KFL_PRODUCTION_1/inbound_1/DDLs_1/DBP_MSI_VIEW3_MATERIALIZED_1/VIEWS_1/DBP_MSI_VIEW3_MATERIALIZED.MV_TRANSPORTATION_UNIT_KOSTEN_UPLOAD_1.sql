create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORTATION_UNIT_KOSTEN_UPLOAD_1(
	MANDANT_ID,
	MANDANT_ID_DEBITOR,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	TOUR_ID,
	BELOS_VORGANG_ID,
	LAGERNUMMER_ID,
	WRG_ID,
	DAT_TOUR,
	KOSTEN_UPLOAD_FG,
	KOSTEN_UPLOAD_FG_BEZ,
	TU_COSTS_INCOMPLETE_FG
) as






SELECT 
 bv.mandant_id
,bv.mandant_id_debitor
,bv.belos_adresse_absender_num_id



,COALESCE(CASE WHEN TRY_CAST(bv.belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE v02.aktuell_wup_id END, TRY_CAST(LEFT(bv.belos_adresse_empfaenger_id,4) AS NUMBER(38,0)))  AS belos_adresse_empfaenger_id
,bv.belos_adresse_spedition_id 
,bv.tour_id AS tour_id
,bv.belos_vorgang_id
,l_lag.lagernummer_id
,CASE WHEN v05.wrg_typ_id=0 THEN 'EUR' ELSE tu_k.wrg_id END AS wrg_id_
,t.dat_tour
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
AND v02.wup_id = CASE WHEN bv.wup_id = 0 AND bv.belos_adresse_empfaenger_id = 'DCKP' THEN 9994::NUMBER(38,0)
WHEN bv.wup_id = 0 AND LEFT(bv.belos_adresse_empfaenger_id, 2) = 'DC' THEN TRY_CAST(RIGHT(belos_adresse_empfaenger_id,4) AS NUMBER(38,0)) ELSE bv.wup_id
END
AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

LEFT JOIN dbp_view.v_tour_1 t
ON bv.mandant_id = t.mandant_id
AND bv.tour_id = t.tour_id
AND transportart_id IN ('Z001', 'ZF01', 'ZF02', 'ZF03')

LEFT JOIN dbp_view.v_transportation_unit_kosten_1 tu_k 
ON bv.mandant_id = tu_k.mandant_id
AND bv.tour_id = tu_k.transportation_unit_id
AND bv.belos_adresse_absender_num_id = tu_k.wup_id

LEFT JOIN dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 ts_wup_k
ON bv.belos_adresse_spedition_id = ts_wup_k.tms_gp_id
AND bv.mandant_id = ts_wup_k.mandant_id
AND bv.belos_adresse_absender_num_id = ts_wup_k.wup_id
AND t.dat_tour BETWEEN ts_wup_k.dat_von AND ts_wup_k.dat_bis

JOIN dbp_view.v_l_lagernummer_1 l_lag
ON  bv.mandant_id=l_lag.mandant_id
AND bv.lagernummer_id = LEFT(l_lag.lagernummer_id,3)

LEFT JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs_1 v03 ON tu_k.wrg_id = v03.von_wrg_id
INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v04 ON bv.mandant_id = v04.mandant_id 
INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v05 
ON v04.wrg_typ_id = v05.wrg_typ_id;