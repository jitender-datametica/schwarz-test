CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_MES_PRODFEHLER_SPR_ZU_2

(
mandant_id
,mes_prodzeittyp_id
,mes_prodzeittyp_bez
)

AS

--28.07.2022 TWIE: SPEC0148993 neue Sprachview für Prodfehler (Zeit_2-Art_2)


SELECT

 v01.mandant_id
,v01.mes_prodzeittyp_id
,v01.mes_prodzeittyp_bez

FROM dbp_view.v_flw_mes_prodfehler_spr_zu_2 v01

JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
ON v01.spr_id = v02.spr_id
;