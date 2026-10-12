CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TS_LIS_SCHWELLWERTE
(
mandant_id
,wup_id
,nb_id
,schwellwert_typ_bez
,schwellwert
,mandant_kbez
)
AS
   SELECT v01.mandant_id, v01.wup_id, v01.nb_id, v01.schwellwert_typ_bez, v01.schwellwert, v02.mandant_kbez
   FROM dbp_msi_view3.ts_lis_schwellwerte v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id
   ;