CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_MES_SCHICHT_1

(
mandant_id
,schicht_id
,schichttyp_id
,dat_schicht
,flw_arbeitsplatz_id
)

AS

--19.07.2022 TWIE: SPEC0148992 neue Lookupview für Schicht


SELECT

mandant_id
,schicht_id
,schichttyp_id
,dat_schicht
,flw_arbeitsplatz_id

FROM dbp_view.v_flw_mes_schicht_1

;
