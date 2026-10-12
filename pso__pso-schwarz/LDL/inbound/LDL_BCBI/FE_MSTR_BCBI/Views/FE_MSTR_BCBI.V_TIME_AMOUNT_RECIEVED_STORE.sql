CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TIME_AMOUNT_RECIEVED_STORE AS
(Select op.client_id
,op.country_iso
,op.wh_id
,op.wh_desc
,op.loc_sid_wh
,op.dat_open
,op.amount_open_stores
,CASE WHEN delivered.amount_delivered_stores IS NULL THEN 0 ELSE delivered.amount_delivered_stores END AS amount_delivered_stores FROM 
(SELECT client_id,country_iso,wh_id,wh_desc, loc_sid_wh,dat_open, COUNT(LOC_SID_WH) AS amount_open_stores FROM FE_MSTR_BCBI.V_TIME_DETAIL
GROUP BY 1,2,3,4,5,6
) AS op
LEFT JOIN
(SELECT client_id,country_iso,wh_id,wh_desc, loc_sid_wh,dat_open, COUNT(LOC_SID_WH) AS amount_delivered_stores FROM FE_MSTR_BCBI.V_TIME_DETAIL
WHERE missing_fg = 0
GROUP BY 1,2,3,4,5,6
) AS delivered
ON op.client_id = delivered.client_id
AND op.loc_sid_wh = delivered.loc_sid_wh
AND op.dat_open = delivered.dat_open
ORDER BY 1,2,3,4);