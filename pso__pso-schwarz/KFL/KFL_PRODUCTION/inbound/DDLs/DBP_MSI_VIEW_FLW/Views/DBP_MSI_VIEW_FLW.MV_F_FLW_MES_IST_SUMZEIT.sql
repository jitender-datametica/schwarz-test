CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_MES_IST_SUMZEIT

(
mandant_id
,werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_ist_prod
,ist_prod_dauer
)

AS

--20.07.2022 TWIE: SPEC0148992 neue Fakttabelle
--mes_prodmengetyp_gruppe zwar im Tabellenschlüssel weil so von SAP, wird aber nicht verwendet, Datensatz ist auch ohne eindeutig

SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_ist_prod
,ist_prod_dauer

FROM dbp_view.v_flw_mes_ist_sumzeit

;
