CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_LAGERNUMMER_LES_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERNUMMER_LES_ID
) AS

--2022-10-10, AP0145540, SPEC0169641, initial, dknop
--2023-07-20, AP0145540, SPEC0182434, adding '-1'
    SELECT 
         mandant_id
        ,wup_id
        ,'-111' AS nb_id
        ,lagernummer_les_id

FROM dbp_view.v_ts_mercareon_mapping_2  
GROUP BY mandant_id
        ,wup_id
        ,lagernummer_les_id
   
UNION

SELECT 
 mandant_id
,wup_id
,'-111' AS nb_id
,'-1'
FROM dbp_view.v_ts_mercareon_mapping_2  
GROUP BY mandant_id
        ,wup_id
        
;