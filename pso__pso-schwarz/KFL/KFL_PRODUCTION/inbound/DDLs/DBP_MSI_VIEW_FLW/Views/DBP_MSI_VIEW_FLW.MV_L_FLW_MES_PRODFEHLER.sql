CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_MES_PRODFEHLER

(
mandant_id
,mes_prodzeittyp_id
)

AS

--28.07.2022 TWIE: SPEC0148993 neue Lookupview für Prodfehler (Zeit-Art)
--da es keine Lookuptabelle gibt, die Sprachtabelle auf den PK groupieren

SELECT

mandant_id
,mes_prodzeittyp_id

FROM dbp_view.v_flw_mes_prodfehler_spr_zu

GROUP BY
mandant_id
,mes_prodzeittyp_id
;
