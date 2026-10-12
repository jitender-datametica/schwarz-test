CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_INSTANDHALTUNG_LEISTUNGSART_SPR_ZU_1(
	INSTANDHALTUNG_LEISTUNGSART_ID,
	INSTANDHALTUNG_LEISTUNGSART_BEZ
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
--2023-05-12, AP0133256,SPEC0166769,dknop, adding exception that instandhaltung_leistungsart_id in ('061','062','063','064') will be taken from mandant_id = 6 
SELECT

 v01.instandhaltung_leistungsart_id
,v01.instandhaltung_leistungsart_bez 


FROM dbp_view.v_in_instandhaltung_leistungsart_spr_zu_1 v01
WHERE  spr_id = 22 AND mandant_id=1 AND instandhaltung_leistungsart_id NOT IN ('061','062','063','064')

UNION
--(in mandant_id 1 they are only used for FLW (meat company) and in mandant_id 6 they are used in logistics but only in this country_1…)
SELECT

 v01.instandhaltung_leistungsart_id
,v01.instandhaltung_leistungsart_bez 


FROM dbp_view.v_in_instandhaltung_leistungsart_spr_zu_1 v01
WHERE  spr_id = 22 AND mandant_id=6 AND instandhaltung_leistungsart_id IN ('061','062','063','064')

;