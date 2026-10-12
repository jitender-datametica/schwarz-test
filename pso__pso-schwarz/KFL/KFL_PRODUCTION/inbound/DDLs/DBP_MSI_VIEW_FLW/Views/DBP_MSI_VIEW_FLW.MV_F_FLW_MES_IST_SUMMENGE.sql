CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_MES_IST_SUMMENGE

(
mandant_id
,werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodmengetyp_id
,dat_prod
,ist_menge
,ist_einh
)

AS

--19.07.2022 TWIE: SPEC0148992 neue Fakttabelle


SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodmengetyp_id
,dat_prod
,ist_menge
,ist_einh


FROM dbp_view.v_flw_mes_ist_summenge

;
