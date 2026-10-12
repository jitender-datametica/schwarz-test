create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_FRAGE_ANTWORT_ZU_2(
	FRAGE_ID,
	ANTWORT_ID,
	SEC_KZ,
	NOK_FG
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 11.12.2020 SPEC0087215, AP0066293, Pawel Staniszewski, adding sec_kz and nok_fg
-- 12.10.2022 twie: SPEC0167837 sek_kz von 51 auf 1 geändert

SELECT
  v01.frage_id
 ,v01.antwort_id
 ,1::BYTEINT AS sec_kz
 ,v01.nok_fg
 
 FROM dbp_view.v_mdl_frage_antwort_zu_2 v01;