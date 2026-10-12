CREATE OR REPLACE VIEW dbp_msi_view_log.mv_besch_faktura -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 auftraggeber_id
,dat_faktura
,faktura_beleg_id
,faktura_status_id
,fakturaart_id
,kalk_schema_id
,mandant_id
,storno_fg
,verkaufsorganisation_id
,wrg_id
,dat_erstellung
)
AS
SELECT
CAST(TRY_CAST(v01.auftraggeber_id AS INTEGER) AS VARCHAR (10)) AS auftraggeber_id, --Anpassung für Snowflake. 
v01.dat_faktura,
v01.faktura_beleg_id,
v01.faktura_status_id,
v01.fakturaart_id,
v01.kalk_schema_id,
v01.mandant_id,
v01.storno_fg,
v01.verkaufsorganisation_id,
v01.wrg_id,
v01.dat_erstellung
FROM dbp_view.v_besch_faktura v01;
