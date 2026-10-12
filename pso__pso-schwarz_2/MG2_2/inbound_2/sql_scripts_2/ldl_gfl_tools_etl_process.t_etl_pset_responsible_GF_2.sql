MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_lsv_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_lsv_2_tcache_cbx_ldl_item_lsv' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_variant' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_variant_2_tcache_cbx_ldl_item_variant' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_article_ean_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_article_ean_2_tcache_cbx_ldl_item_article_ean' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_lsv_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_lsv_2_tcache_cbx_ldl_item_lsv' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_pack_assort_size' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_pack_assort_size_2_tcache_cbx_ldl_item_pack_assort_size' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_packing_method_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_packing_method_2_tcache_cbx_ldl_item_packing_method' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_size_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_size_2_tcache_cbx_ldl_item_size' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_style' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_style_2_tcache_cbx_ldl_item_style' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_unique_style_2' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_unique_style_2_tcache_cbx_ldl_item_unique_style' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;

MERGE INTO ETL_PROCESS.t_etl_pset_responsible_2 tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 'ldl_item_variant' AS INTERFACE
 , 'xx_upsert_unhist_ldl_item_variant_2_tcache_cbx_ldl_item_variant' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;
