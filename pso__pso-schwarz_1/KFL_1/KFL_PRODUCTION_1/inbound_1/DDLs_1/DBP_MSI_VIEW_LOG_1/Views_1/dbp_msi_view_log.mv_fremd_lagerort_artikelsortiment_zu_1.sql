CREATE OR REPLACE VIEW dbp_msi_view_log.MV_FREMD_LAGERORT_ARTIKELSORTIMENT_ZU_1
-- 26.03.2021, SPEC0107644, AP0081632 , dknop, initial
-- 30.03.2021, SPEC0107644, AP0081632 , nwag2310, added lagernummer+mandant_1 

AS 
SELECT 
 v01.mandant_id
,v02.lagernummer_id
,v01.fremd_lagerort_id
,v01.artikelsortiment_id
from dbp_view.v_fremd_lagerort_artikelsortiment_zu_1 v01
JOIN dbp_view.v_l_lagernummer_1 v02
	ON v01.mandant_id=v02.mandant_id
	AND Left(lagernummer_id,1) IN ('D','H','S','P','B','C','M','R')
	AND Length(Trim(lagernummer_id))=4;