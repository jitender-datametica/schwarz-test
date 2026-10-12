CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTIKEL_EINA
(
 mandant_id
,art_id
)
AS
-- AP0221172/SPEC0299885 Neuanlage View / sschuecke 11.09.2025
-- View dient ausschließlich im Frontend zur Filterung von Artikeln, die nur einem Lieferanten zugeordnet sind
SELECT
 mandant_id
,art_id
FROM DBP_DATA.EK_INFOSATZ
WHERE mandant_id >1
AND dat_bis = '9999-12-31'
GROUP BY ALL
HAVING COUNT (DISTINCT ek_infosatz_id) = 1;