CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_DIENSTLEISTER(
	DIENSTLEISTER_ID
) AS 
/* 
   LOOKUP: Dienstleister
   2023-07-05 muellerpatri : Setup AP0172061 
*/ 
SELECT  
  DISTINCT dl.dienstleister_id
FROM 
dbp_data.l_dienstleister dl
;