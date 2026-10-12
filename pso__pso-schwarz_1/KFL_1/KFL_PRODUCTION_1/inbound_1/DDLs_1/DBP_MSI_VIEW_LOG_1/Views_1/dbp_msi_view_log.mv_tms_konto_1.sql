CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TMS_KONTO_1(
	TMS_KONTO_ID,
	TMS_KONTO_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
SELECT 
 TO_CHAR(tms_konto_id) AS tms_konto_id
,MAX(tms_konto_bez)
FROM  dbp_view.v_tms_konto_1
GROUP BY  tms_konto_id

UNION
SELECT
 'MFIX'
,'Speditionsfixkosten'

UNION
SELECT 
 'MDIES'
,'Frachtkosten Diesel'
UNION 
SELECT 'MSTRO' 
,'Frachtkosten Strom' 
UNION 
SELECT 
 'MGAS'
,'Frachtkosten Gas'
UNION
SELECT 
 'MMAUT' 
,'Frachtkosten Maut'
UNION
SELECT 
'MKUEH' 
,'Frachtkosten Kühlung'

;