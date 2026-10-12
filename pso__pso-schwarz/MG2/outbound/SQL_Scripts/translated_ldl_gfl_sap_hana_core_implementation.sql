/*

This SQL must be run AFTER the load to TCACHE, and BEFORE the transforms to core_rel of the historical data after implementation

*/


--      1. US2  (Some country codes of US2 - records are trash and will be deleted



DELETE FROM ldl_data_production_etl_process.t_tcache_saphana_cv_cube_ker_values_cdwh_snap
WHERE bic_zmlila = 'US2';


DELETE FROM ldl_data_production_etl_process.t_tcache_saphana_cv_cube_ker_stat_cdwh_snap
WHERE bic_zmlila = 'US2';


UPDATE ldl_data_production_etl_process.t_tcache_saphana_cv_cube_ker_values_cdwh_snap SET
 vlxecukyl = 'EUR',
 kalk_repr_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.kalk_repr_ist / 7.5345,
 kalk_repr_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.kalk_repr_plan / 7.5345,
 kalkulation_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.kalkulation_ist / 7.5345,
 kalkulation_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.kalkulation_plan / 7.5345,
 steuern_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.steuern_ist / 7.5345,
 steuern_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.steuern_plan / 7.5345,
 rvg_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.rvg_ist / 7.5345,
 rvg_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.rvg_plan / 7.5345,
 nrv_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.nrv_ist / 7.5345,
 nrv_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.nrv_plan / 7.5345,
 spedition_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.spedition_ist / 7.5345,
 spedition_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.spedition_plan / 7.5345,
 whrgdiff_ist = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.whrgdiff_ist / 7.5345,
 whrgdiff_plan = t_tcache_saphana_cv_cube_ker_values_cdwh_snap.whrgdiff_plan / 7.5345
WHERE bic_zmlila = 'HR' AND vlxecukyl = 'HRK';