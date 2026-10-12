MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_lsv_1' AS interface,
  'xx_upsert_unhist_ldl_item_lsv_2_tcache_cbx_ldl_item_lsv' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_variant' AS interface,
  'xx_upsert_unhist_ldl_item_variant_2_tcache_cbx_ldl_item_variant' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_article_ean_1' AS interface,
  'xx_upsert_unhist_ldl_item_article_ean_2_tcache_cbx_ldl_item_article_ean' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_lsv_1' AS interface,
  'xx_upsert_unhist_ldl_item_lsv_2_tcache_cbx_ldl_item_lsv' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_pack_assort_size' AS interface,
  'xx_upsert_unhist_ldl_item_pack_assort_size_2_tcache_cbx_ldl_item_pack_assort_size' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_packing_method_1' AS interface,
  'xx_upsert_unhist_ldl_item_packing_method_2_tcache_cbx_ldl_item_packing_method' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_size_1' AS interface,
  'xx_upsert_unhist_ldl_item_size_2_tcache_cbx_ldl_item_size' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_style' AS interface,
  'xx_upsert_unhist_ldl_item_style_2_tcache_cbx_ldl_item_style' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_unique_style_1' AS interface,
  'xx_upsert_unhist_ldl_item_unique_style_2_tcache_cbx_ldl_item_unique_style' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );


MERGE INTO ldl_data_production_etl_process.t_etl_pset_responsible_1 AS tgt
USING (SELECT 'ldl' AS division,
  'ldl_gfl_cbx_core' AS project,
  'LDL_GFL_CBX_CORE' AS application,
  'cbx-data' AS system_group,
  'ldl_item_variant' AS interface,
  'xx_upsert_unhist_ldl_item_variant_2_tcache_cbx_ldl_item_variant' AS pset,
  'rene.pereira_ext@mail.schwarz' AS email_developer,
  'petar.katsarov@mail.schwarz' AS email_team_lead,
  'danijel.jelic@mail.schwarz' AS email_bse,
  CURRENT_DATE AS last_reject_at,
  CURRENT_DATE AS dwh_created_tmsp) AS src
ON tgt.division = src.division AND tgt.project = src.project AND tgt.pset = src.pset
WHEN MATCHED THEN UPDATE SET
 application = src.application,
 system_group = src.system_group,
 interface = src.interface,
 email_developer = src.email_developer,
 email_team_lead = src.email_team_lead,
 email_bse = src.email_bse,
 last_reject_at = CAST(src.last_reject_at AS DATETIME),
 dwh_created_tmsp = CAST(src.dwh_created_tmsp AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(src.division, src.project, src.application, src.system_group, src.interface, src.pset
 , src.email_developer, src.email_team_lead, src.email_bse, CAST(src.last_reject_at AS DATETIME), CAST(src.dwh_created_tmsp AS DATETIME)
 );