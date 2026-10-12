CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_MES_SOLL_SUMZEIT_2

(
mandant_id
,werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_soll_prod
,planungs_dauer
,planungs_einh
)

AS

--20.07.2022 TWIE: SPEC0148992 neue Fakttabelle


SELECT

mandant_id
,flw_werk_id AS werk_id
,flw_arbeitsplatz_id
,schicht_id
,mes_prodzeittyp_id
,dat_soll_prod
,planungs_dauer
,planungs_einh

FROM dbp_view.v_flw_mes_soll_sumzeit_2

;
