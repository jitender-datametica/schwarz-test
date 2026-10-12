/*

This SQL must be run AFTER the load to TCACHE, and BEFORE the transforms to core_rel of the historical data after implementation

*/


--      1. US2  (Some country_2 codes of US2 - records are trash and will be deleted
delete  from  ETL_PROCESS.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 where BIC_ZMLILA = 'US2' ;  
delete from  ETL_PROCESS.T_TCACHE_SAPHANA_CV_CUBE_KER_STAT_CDWH_SNAP_2 where BIC_ZMLILA = 'US2' ;
 
--      2. Croatia Case (Country_2 switches currency midway, transforms cannot handle that, convert all old currency records to new.

UPDATE ETL_PROCESS.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2
SET VLXECUKYL = 'EUR',
    KALK_REPR_IST = KALK_REPR_IST/7.5345 ,
    KALK_REPR_PLAN = KALK_REPR_PLAN/7.5345,
    KALKULATION_IST = KALKULATION_IST/7.5345 ,
    KALKULATION_PLAN = KALKULATION_PLAN/7.5345 ,
    STEUERN_IST = STEUERN_IST/7.5345  ,
    STEUERN_PLAN = STEUERN_PLAN/7.5345 ,
    RVG_IST = RVG_IST/7.5345,
    RVG_PLAN = RVG_PLAN/7.5345  ,
    NRV_IST = NRV_IST/7.5345,
    NRV_PLAN =  NRV_PLAN/7.5345  ,
    SPEDITION_IST = SPEDITION_IST/7.5345 ,
    SPEDITION_PLAN = SPEDITION_PLAN/7.5345 ,
    WHRGDIFF_IST = WHRGDIFF_IST/7.5345,
    WHRGDIFF_PLAN = WHRGDIFF_PLAN/7.5345
where bic_zmlila = 'HR' and VLXECUKYL = 'HRK';
   
