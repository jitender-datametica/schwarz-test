CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_BONUSKAUF_1
-- sap_aktion_id durch aktion_id ersetzt, analog Änderung in data.l_bonuskauf_1 - sschuecke 22.04.2016
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 02.02.2022
(
 mandant_id
,bonuskauf_id
,bonuskauf_bez
,bonuskauf_bez_de
,bonuskauf_bez_cz
,bonuskauf_bez_sk
,bonuskauf_bez_hr
,bonuskauf_bez_pl
,bonuskauf_bez_ro
,bonuskauf_bez_bg
,zeit_von
,zeit_bis
,konditionsart_id
,geschaeftsvorfall_id
,dat_von
,dat_bis
,aktion_id
)

AS
SELECT
 v01.mandant_id
,v01.bonuskauf_id
,COALESCE(MAX(CASE WHEN v03.spr_id = 22  THEN v03.bonuskauf_bez END), 'N/A')  AS bonuskauf_bez
,COALESCE(MAX(CASE WHEN v03.spr_id = 22  THEN v03.bonuskauf_bez END), 'N/A')  AS bonuskauf_bez_de
,COALESCE(MAX(CASE WHEN v03.spr_id = 124 THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_cz
,COALESCE(MAX(CASE WHEN v03.spr_id = 108 THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_sk
,COALESCE(MAX(CASE WHEN v03.spr_id = 65  THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_hr
,COALESCE(MAX(CASE WHEN v03.spr_id = 90  THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_pl
,COALESCE(MAX(CASE WHEN v03.spr_id = 95  THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_ro
,COALESCE(MAX(CASE WHEN v03.spr_id = 18  THEN v03.bonuskauf_bez END), bonuskauf_bez_de)  AS bonuskauf_bez_bg
,v01.zeit_von
,v01.zeit_bis
,v01.konditionsart_id
,v01.geschaeftsvorfall_id
,v01.dat_von
,v01.dat_bis
,v01.aktion_id

FROM dbp_view.v_l_bonuskauf_1 v01

JOIN dbp_view.v_bonuskauf_spr_zu_1 v03
ON v01.bonuskauf_id = v03.bonuskauf_id
AND v01.mandant_id = v03.mandant_id

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.bonuskauf_id
,v01.zeit_von
,v01.zeit_bis
,v01.konditionsart_id
,v01.geschaeftsvorfall_id
,v01.dat_von
,v01.dat_bis
,v01.aktion_id
;