CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_MES_ARBEITSPLATZ

(
mandant_id
,flw_arbeitsplatz_id
,flw_arbeitsplatztyp_id
)

AS

--14.06.2022 TWIE: SPEC0148992 neue Lookupview für Arbeitsplätze


SELECT

mandant_id
,flw_arbeitsplatz_id
,flw_arbeitsplatztyp_id

FROM dbp_view.v_flw_mes_arbeitsplatz
;
