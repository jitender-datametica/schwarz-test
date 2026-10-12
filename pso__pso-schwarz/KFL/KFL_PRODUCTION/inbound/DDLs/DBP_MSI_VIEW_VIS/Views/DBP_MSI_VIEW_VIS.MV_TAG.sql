create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_TAG(
	DAT,
	WTAG_ID,
	KJTAG_ID,
	GJTAG_ID,
	DAT_VJ,
	DAT_VVJ,
	KJWO,
	WO_DAT_VON,
	WO_DAT_BIS,
	KJMO,
	KJMO_VJ,
	GJ,
	MO_GJ,
	KJ,
	MO_KJ,
	GJQU,
	AKT_TAG,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	WO_VON_BIS,
	KJMO_DAT,
	AKT_QU,
	GJWO_NEU,
	KJWO_KL,
	TAG_TAG,
	REFERENZ_TAG,
	JDAT
) as
    
    
    
    
    
    
    
    
    
    
    
 SELECT
   dat
  ,wtag_id
  ,kjtag_id
  ,gjtag_id
  ,dat_vj
  ,dat_vj - 364                                                                                                                         AS dat_vvj
  ,kjwo
  ,wo_dat_von
  ,wo_dat_bis
  ,kjmo
  ,kjmo_vj
  ,gj
  ,mo_gj
  ,kj
  ,mo_kj
  ,gjqu
  ,akt_tag
  ,akt_wo
  ,akt_wo_komplett
  ,akt_mo
  ,akt_mo_komplett
  ,akt_gj
  ,akt_gj_komplett
  ,akt_kj
  ,akt_kj_komplett
  ,akt_gjqu
  ,akt_gjqu_komplett
  ,TO_CHAR(MOD(kjwo,100), 'FM00') || ' (' || TO_CHAR(wo_dat_von,'DD.MM.') || '-' || TO_CHAR(wo_dat_bis,'DD.MM.') || ')'::VARCHAR(20)    AS wo_von_bis
  ,CAST(SUBSTRING(CAST(dat AS VARCHAR), 1,8) ||'01' AS VARCHAR)                                                                         AS kjmo_dat
  ,akt_mo/3                                                                                                                             AS akt_qu
  ,CASE 
   WHEN SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date((kj-1900)*10000+301) BETWEEN wo_dat_von AND wo_dat_bis 
   THEN kj*100+1 
   ELSE gjwo_kl
   END                                                                                                                                  AS gjwo_neu
  ,kjwo_kl
  ,EXTRACT (DAY FROM dat)                                                                                                               AS tag_tag
  ,EXTRACT (DAY FROM CURRENT_DATE - 1 )                                                                                                 AS referenz_tag
  , CAST(TRIM(TO_VARCHAR(DAY(dat),'00')) || '.' || TRIM(TO_VARCHAR(MONTH(dat), '00')) || '.' AS VARCHAR(20))                            AS jdat
 FROM dbp_view.v_tag  v01
 
 WHERE v01.akt_gj BETWEEN -11 AND 1;
