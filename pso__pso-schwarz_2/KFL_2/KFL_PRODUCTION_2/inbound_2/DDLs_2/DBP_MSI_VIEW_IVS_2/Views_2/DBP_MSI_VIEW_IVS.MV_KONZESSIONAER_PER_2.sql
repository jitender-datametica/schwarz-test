CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KONZESSIONAER_PER_2
AS
---------------------------------------------------------------
-- Lookup Stammdaten Konzessionaer (Ebene Debitor)
-- 2011KW34 konzessionaer_id von 0 auf '0' umgestellt.
-- 2011KW50 Update Verbundkennz1 (konzessionaer_gruppe)
-- 2013KW13 Transkription ergaenzt
---------------------------------------------------------------

SELECT
mandant_id
,konzessionaer_id
,length(konzessionaer_name) AS k_len
,SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 6) AS k_006
,SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 3) AS k_003
,dbp_process.transcriptc
(
CASE WHEN konzessionaer_id = '0' THEN ' '
WHEN k_006 = 'KK MB ' OR k_006 = 'KK  MB' THEN TRIM(SUBSTRING(konzessionaer_name,7, k_len - 7))
WHEN k_003 = 'KK ' OR k_003 = 'MB ' THEN TRIM(SUBSTRING(konzessionaer_name,4, k_len - 3))
ELSE konzessionaer_name
END
)       AS konzessionaer_name
,CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_gruppe_id END  AS konz_gruppe_id
,CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_holding_id END AS konzessionaer_holding_id
,dat_von
,dat_bis
,CAST(COALESCE(konzessionaer_branche_id, '000') AS CHAR(3))                         AS konzessionaer_branche_id
,CAST(CASE WHEN konzessionaer_id = '0' THEN 'E' ELSE intern_fg END AS CHAR(1))      AS intern_fg
,land_id
,konzessionaer_plz
,dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort
,dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse
,konzessionaer_rechtsform
,dat_insolvenz_eintritt
,konzessionaer_topmieter_fg
-- hilfsspalten

FROM dbp_view.v_ivs_konzessionaer_per_2
WHERE dat_bis = CAST('9999-12-31' AS DATE)
;