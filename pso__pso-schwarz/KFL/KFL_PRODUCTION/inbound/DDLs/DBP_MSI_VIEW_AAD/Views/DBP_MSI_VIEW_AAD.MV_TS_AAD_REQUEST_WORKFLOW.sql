CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_TS_AAD_REQUEST_WORKFLOW
(
	AAD_REQUEST_ID,
	CREATOR_USER_ID,
	SCENARIO_ID,
	WUP_ID,
	MANDANT_ID,
	HASHED_CASHIER_ID,
	REQUEST_REASON_TYPE_ID,
	SCENARIO_HIT_RECEIPTS_CNT,
	FRAUD_VALUE_GROSS_LOCAL_VAL,
	DWH_CREATED_TMSP,
	REQUEST_TYPE_ID,
	WRG_ID,
	CREATION_REASON_COMMENT_TXT,
	COMMENT_TXT,
	FIRST_APPROVER_USER_ID,
	SECOND_APPROVER_USER_ID,
	REQUEST_STATUS_TYPE_ID,
	EXPIRATION_TMSP,
	APPROVE_BY_COUNCIL_FG,
	CRIMINAL_COMPLAIN_FG,
	CRIMINAL_COMPLAIN_FG_ID,
	GENEHMIGT_FLAG_GENEHMIGER,
	GENEHMIGT_FLAG_2_GENEHMIGER,
	ANTRAEGE_VERLAUF,
	DAUER,
	LOSS_AMOUNT_GROSS_LOCAL_VAL,
	TAKEN_MEASURE_COMMENT_TXT,
	LINK_ANLAGE_ZUSAMMENFASSUNG,
	LINK_WEITERE_BONS,
	ZUSAMMENFASSUNG_FG
)
AS

-- 30.06.2023 staeblern Initiale Erstellung 
-- 13.13.2023 staeblern Anpassung - Ermittlung Datumswerte fuer Dauer 
-- 15.02.2024 SPEC0227051 twie: Tagattribut in Datum konvertieren, ist Timestamp in DB
-- 26.08.2024 twie: SPEC0266321 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							    somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

WITH t_Antraege_Verlauf AS (
    SELECT AAD_REQUEST_ID, DWH_CREATED_TMSP
    , MIN(DWH_CREATED_TMSP) OVER (PARTITION BY AAD_REQUEST_ID) AS Antragsdatum_zeitraumerweiterung 
    , MIN(DWH_CREATED_TMSP) OVER (PARTITION BY AAD_REQUEST_ID, REQUEST_STATUS_TYPE_ID, REQUEST_REASON_TYPE_ID) AS Datum_Status_Aenderung
    , MIN(REQUEST_TYPE_ID) OVER (PARTITION BY AAD_REQUEST_ID) AS zusammenfassung_fg 
    , RANK() OVER (PARTITION BY AAD_REQUEST_ID ORDER BY  DWH_CREATED_TMSP DESC ) AS Antraege_Verlauf
    FROM DBP_MSI_DATA.ts_AAD_REQUEST_WORKFLOW
)
SELECT 
    v01.AAD_REQUEST_ID,
    v01.creator_user_id,
    v01.scenario_id,
    v03.aktuell_wup_id AS wup_id,
    v01.mandant_id,
    v01.hashed_cashier_id,
    v01.REQUEST_REASON_TYPE_ID,
    v01.SCENARIO_HIT_RECEIPTS_CNT,
    v01.fraud_value_gross_local_val,
     -- Request typ id = 0 Bedeutet Antrag abgeschlossen, Bei dieser Zeile soll als Erstelldatum dies vom Antrag drin stehen 
    CASE WHEN v01.request_type_id = 0  THEN TO_DATE(v02.Antragsdatum_zeitraumerweiterung) ELSE TO_DATE(v01.dwh_created_tmsp) END AS dwh_created_tmsp,
    v01.request_type_id, 
    v01.wrg_id,
    v01.creation_reason_comment_txt,
    v01.comment_txt,
    v01.first_approver_user_id,
    v01.second_approver_user_id,
    v01.request_status_type_id,
    v01.EXPIRATION_TMSP,
    v01.APPROVE_BY_COUNCIL_FG,
    CASE WHEN v01.CRIMINAL_COMPLAIN_FG = 1 THEN 'Ja' 
        WHEN v01.CRIMINAL_COMPLAIN_FG = 0 THEN 'Nein'
        ELSE '-' END AS CRIMINAL_COMPLAIN_FG,
    v01.CRIMINAL_COMPLAIN_FG AS CRIMINAL_COMPLAIN_FG_ID,
    CASE v01.request_status_type_id 
        -- Genehmigt 
        WHEN  2 THEN 1 -- Zeitraumerweiterung
        WHEN  12  THEN 1 -- bedienerentschlüsselung (erster Genehmiger)
        WHEN  4  THEN 1 -- bedienerentschlüsselung (zweiter Genehmiger) - wird benötigt dass weiterhin angezeigt wird, dass der erste Genehmigt hat 
        -- abgelehnt Zeitraumerweiterung/ bedienerentschlüsselung
        WHEN 7 THEN 0
        -- SONST 
        ELSE NULL
        END 
    AS genehmigt_flag_genehmiger,
    -- beim zweiten Genehmiger gibt es nur Bedienerentschlüsselung 
    CASE v01.request_status_type_id 
        -- Genehmigt 
        WHEN  4 THEN 1 -- bedienerentschlüsselung 
        -- abgelehnt bedienerentschlüsselung
        WHEN 7 THEN 0
        -- SONST 
        ELSE NULL
        END 
    AS genehmigt_flag_2_genehmiger,
    v02.Antraege_Verlauf,
    DATEDIFF('day',v02.Antragsdatum_zeitraumerweiterung, v02.Datum_Status_Aenderung  ) AS dauer,
    v01.loss_amount_gross_local_val ,
    v01.taken_measure_comment_txt ,
    CASE WHEN v01.request_status_type_id = 4 AND v02.Antraege_Verlauf = 1 THEN 'Antrag abschließen' 
        WHEN v01.request_type_id = 0 AND v02.Antraege_Verlauf = 1 THEN 'Antrag einsehen'
    ELSE '' END AS link_anlage_zusammenfassung,
    CASE WHEN (v01.request_status_type_id = 4 OR v01.request_type_id = 0) AND v02.Antraege_Verlauf = 1 THEN 'weitere Bons hinzufuegen' ELSE '' END AS link_weitere_Bons,
    CASE WHEN v02.zusammenfassung_fg = 0 THEN 1 ELSE 0 END AS zusammenfassung_fg
    
FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW v01

JOIN t_Antraege_Verlauf v02
ON v01.aad_request_id = v02.aad_request_id
AND v01.dwh_created_tmsp = v02.dwh_created_tmsp

INNER JOIN dbp_view.v_wup v03
ON v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id
;