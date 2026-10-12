CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_MES_ARBEITSPLATZ_SPR_ZU

(
mandant_id
,flw_arbeitsplatz_id
,flw_arbeitsplatz_bez
)

AS

--19.07.2022 TWIE: SPEC0148992 neue Sprachview für Arbeitsplätze


SELECT

 v02.mandant_id
,v02.flw_arbeitsplatz_id
,v01.flw_arbeitsplatz_bez

FROM dbp_view.v_flw_mes_arbeitsplatz_schluessel_spr_zu v01

--flw_mes_arbeitsplatz_schluessel_spr_zu hat keine flw_arbeitsplatz_id, deshalb Join zu:
JOIN dbp_view.v_flw_mes_arbeitsplatz_schluessel v02
ON v01.mandant_id = v02.mandant_id
AND v01.flw_arbeitsplatzschluessel_id = v02.flw_arbeitsplatzschluessel_id


JOIN dbp_msi.akt_msi_user_spr_zu v03
ON v01.spr_id = v03.spr_id
;