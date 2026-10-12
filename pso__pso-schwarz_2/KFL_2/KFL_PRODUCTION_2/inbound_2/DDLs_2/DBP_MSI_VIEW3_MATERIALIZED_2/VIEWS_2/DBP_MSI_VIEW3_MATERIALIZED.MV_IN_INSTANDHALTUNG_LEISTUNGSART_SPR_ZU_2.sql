create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_INSTANDHALTUNG_LEISTUNGSART_SPR_ZU_2(
	MANDANT_ID,
	INSTANDHALTUNG_LEISTUNGSART_ID,
	SPR_ID,
	INSTANDHALTUNG_LEISTUNGSART_BEZ,
	INSTANDHALT_LEISTART_BEZ_LANG
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.instandhaltung_leistungsart_id,
   v01.spr_id,
   v01.instandhaltung_leistungsart_bez,
   TRIM(v01.instandhaltung_leistungsart_id) || ' ' || TRIM(v01.instandhaltung_leistungsart_bez) AS instandhalt_leistart_bez_lang
FROM
   dbp_view.v_in_instandhaltung_leistungsart_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;